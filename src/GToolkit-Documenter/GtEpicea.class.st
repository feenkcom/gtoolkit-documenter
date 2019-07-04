Class {
	#name : #GtEpicea,
	#superclass : #Object,
	#traits : 'TBlDebug + TGt2DocumentConstants + TGtAnnouncer',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'ombuFile',
		'epiceaLog',
		'events',
		'diff',
		'applyErrorHandler',
		'hasImpact',
		'previousNumberOfEvents'
	],
	#classVars : [
		'DebugMode'
	],
	#category : #'GToolkit-Documenter-Epicea'
}

{ #category : #accessing }
GtEpicea class >> constants [
	^ GtDocumentConstants
]

{ #category : #modification }
GtEpicea >> addEvent: anEpEvent [ 
	self ombuFile parent exists ifFalse: [ self ombuFile parent ensureCreateDirectory ].
	self 
		assert: [ self ombuFile parent exists ] 
		description: [ 'The parent directory of the Epicea change file must exist' ].
	self log addEntryWith: anEpEvent tags: [ :tags | "ignore" ].
	self log store flush.
]

{ #category : #accessing }
GtEpicea >> announcer [
	^ announcer
]

{ #category : #modification }
GtEpicea >> applyChanges [
	self 
		assert: [ self log notNil ] 
		description: [ 'Epicea log must be non-nil.' ].
	self hasChanges ifFalse: [ ^ self ].
	EpLogBrowserOperationFactory new
		logBrowserModel: self log;
		entries: self entries;
		errorHandlerBlock: applyErrorHandler;
		applyCodeChanges.
	self notifyEpiceaChanged.
]

{ #category : #private }
GtEpicea >> computeImpact [
	"Return true if impact changed"
	<return: #Boolean>
	| anOldImpactState |
	anOldImpactState := hasImpact.
	hasImpact := self events anySatisfy: [ :eachEvent | 
			eachEvent accept: (EpHasImpactVisitor inEnvironment: self theEnvironment) ].
	hasImpact = anOldImpactState ifFalse: [ diff := nil ].
	^ hasImpact ~= anOldImpactState
]

{ #category : #accessing }
GtEpicea >> constants [
	^ GtDocumentConstants
]

{ #category : #accessing }
GtEpicea >> diff [
	<return: #BlRope>
	^ diff ifNil: [ 
			diff := self hasImpact 
				ifTrue: [ 
					GtEpiceaDiffStencil new
						from: self systemState;
						to: self tutorialState;
						create ]
				ifFalse: [ '"No changes comparing to current system state"' asRopedText 
						glamorousCodeFontAndSize;
						foreground: self constants subtleColor ] ]
]

{ #category : #accessing }
GtEpicea >> entries [
	<return: #OrderedeCollection of: #OmEntry>
	^ self log entries
]

{ #category : #accessing }
GtEpicea >> events [
	<return: #OrderedeCollection of: #EpEvent>
	^ events
]

{ #category : #'gt-extension' }
GtEpicea >> gtDiffFor: aView [
	<gtView>
	<gtViewChanges>
	^ aView textEditor
		title: 'Diff';
		priority: 1;
		look: BrGlamorousCodeEditorLook new;
		text: [ :anEditor | 
			self 
				when: GtEpiceaUpdatedAnnouncement 
				do: [ anEditor text: self diff asRopedText ].		
			self diff ]
]

{ #category : #'gt-extension' }
GtEpicea >> gtEventsFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Change List';
		priority: 3;
		stencil: [ 
			| aList |
			aList := BrColumnedList new display: self events.
			aList addEventHandler: GtInspectorListToSelectHandler new.
			aList constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
			self announcer 
				when: GtEpiceaUpdatedAnnouncement 
				do: [ :anAnnouncement | aList display: self events ].
			
			aList column 
				title: 'Icon';
				stencil: [ :anEpEvent :anIndex | 
					(anEpEvent accept: EpIconVisitor new) asElement ].
				
			aList column 
				title: 'Description';
				stencil: [ :anEpEvent :anIndex |
					| aRemoveButton aContainer | 
					aRemoveButton := BrButton new.
					aRemoveButton
						layout: BlLinearLayout new;
						look: BrGlamorousButtonWithIconLook;
						icon: (BlElement new 
							geometry: BlRectangle new;
							layout: BlLinearLayout new;
							background: Color lightGray;
							size: 10@3);
						action: [ 
							self removeEvent: anEpEvent.
							aRemoveButton enqueueTask: (BlTaskAction new 
								action: [ aRemoveButton visibility: BlVisibility hidden ]) ];
						visibility: BlVisibility hidden.
					aContainer := BlElement new 
						layout: BlLinearLayout horizontal;
						addChildren: (anEpEvent accept: GtEpiceaBrickVisitor new);
						addChild: aRemoveButton;
						constraintsDo: [ :c | 
							c horizontal fitContent.
							c vertical fitContent ].
					aContainer when: BlMouseEnterEvent do: [ :anEvent | 
						aRemoveButton visibility: BlVisibility visible ].
					aContainer when: BlMouseLeaveEvent do: [ :anEvent | 
						aRemoveButton visibility: BlVisibility hidden ].
					aContainer ].
			aList ]
]

{ #category : #'gt-extension' }
GtEpicea >> gtGlobalEntriesIn: aView [
	<gtView>
	^ aView explicit 
		title: 'Global Changes';
		priority: 20;
		stencil: [ 
			| aList aGlobalLog |
			aGlobalLog := EpMonitor current log entries reversed.
			aList := BrColumnedList new display: aGlobalLog.
			aList addEventHandler: GtInspectorListToSelectHandler new.
			aList constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
			
			aList column 
				title: 'Icon';
				stencil: [ :anOmEntry :anIndex | 
					(anOmEntry content accept: EpIconVisitor new) asElement ].
				
			aList column 
				title: 'Description';
				stencil: [ :anOmEntry :anIndex |
					| anAddButton aContainer | 
					anAddButton := BrButton new.
					anAddButton
						layout: BlLinearLayout new;
						look: BrGlamorousButtonWithIconLook;
						icon: GtInspectorPlusIconStencil new asElement;
						action: [ 
							self addEvent: anOmEntry content.
							anAddButton enqueueTask: (BlTaskAction new 
								action: [ anAddButton visibility: BlVisibility hidden ]) ];
						visibility: BlVisibility hidden.
					aContainer := BlElement new 
						layout: BlLinearLayout horizontal;
						addChildren: (anOmEntry content accept: GtEpiceaBrickVisitor new);
						addChild: anAddButton;
						constraintsDo: [ :c | 
							c horizontal fitContent.
							c vertical fitContent.
							c linear vertical alignCenter ].
					aContainer when: BlMouseEnterEvent do: [ :anEvent | 
						anAddButton visibility: BlVisibility visible ].
					aContainer when: BlMouseLeaveEvent do: [ :anEvent | 
						anAddButton visibility: BlVisibility hidden ].
					aContainer ].
			aList
			 ]
]

{ #category : #'gt-extension' }
GtEpicea >> gtPreviewFor: aView [
	^ aView explicit
		title: 'Document Preview';
		priority: 50;
		stencil: [  
			| aExportsViews aCompositeView |
			aExportsViews := GtPhlowViewsCollector new
				pragmaName: #gtViewChanges;
				fromObject: self;
				collect.
			aCompositeView := GtPhlowView empty composite views: aExportsViews.
			aCompositeView asElementDo: [ :anElement | anElement ]
		 ]
]

{ #category : #'gt-extension' }
GtEpicea >> gtTutorialFor: aView [
	<gtView>
	<gtViewChanges>
	^ aView textEditor
		title: 'Code';
		priority: 2;
		look: BrGlamorousCodeEditorLook new;
		text: [ :anEditor | 
			self 
				when: GtEpiceaUpdatedAnnouncement 
				do: [ anEditor text: self tutorialStateRope ].
			self tutorialStateRope ]
]

{ #category : #'announcement handling' }
GtEpicea >> handleEpEntryAddedAnnouncement: anEpEntryAdded [
	self privateAddEvent: anEpEntryAdded entry content.
	self notifyEpiceaChanged.
]

{ #category : #testing }
GtEpicea >> hasChanges [
	<return: #Boolean>
	^ self numberOfEvents isZero not
]

{ #category : #accessing }
GtEpicea >> hasImpact [
	"Return true, if changes have impact to the current system state"
	<return: #Boolean>
	^ hasImpact
]

{ #category : #initialization }
GtEpicea >> initialize [
	super initialize.
	announcer := Announcer new.
	hasImpact := false.
	previousNumberOfEvents := 0.
	applyErrorHandler := [ :anException | | message |
		DebugMode ifTrue: [ anException pass ].
		message := 'Error while applying Epicea changes: ' , anException asString.
		message traceCr.
		self inform: message ].
]

{ #category : #accessing }
GtEpicea >> log [
	<return: #EpLog>
	^ epiceaLog
]

{ #category : #notifying }
GtEpicea >> notifyEpiceaChanged [
	| anImpactChanged |
	anImpactChanged := self computeImpact.
	self notifyEpiceaChangedWithImpactState: self hasImpact impactChanged: anImpactChanged.
]

{ #category : #notifying }
GtEpicea >> notifyEpiceaChangedWithImpactState: anImpactStateBoolean impactChanged: anImpactChangeBoolean [
	| anAnnouncement |
	anAnnouncement := (GtEpiceaUpdatedAnnouncement new 
		hasImpact: anImpactStateBoolean;
		impactChanged: anImpactChangeBoolean;
		numberOfEvents: self numberOfEvents;
		previousNumberOfEvents: previousNumberOfEvents).
	previousNumberOfEvents := self numberOfEvents.
	self announce: anAnnouncement.
]

{ #category : #accessing }
GtEpicea >> numberOfEvents [
	<return: #Integer>
	^ events ifNotNil: #size ifNil: 0
]

{ #category : #accessing }
GtEpicea >> ombuFile [
	<return: #FileReference>
	^ ombuFile
]

{ #category : #accessing }
GtEpicea >> ombuFile: aFileReference [
	ombuFile := aFileReference.
	self log ifNotNil: [ self log announcer unsubscribe: self ].
	epiceaLog := EpLog fromFile: "freshFromFile:" ombuFile.
	self privateEvents: (self entries collect: #content).
	self log announcer
		subscribe: EpEntryAdded 
		send: #handleEpEntryAddedAnnouncement: 
		to: self.
	self notifyEpiceaChanged.
]

{ #category : #testing }
GtEpicea >> ombuFileExists [
	<return: #Boolean>
	^ self ombuFile notNil and: [ self ombuFile exists ]
]

{ #category : #private }
GtEpicea >> privateAddEvent: anEpEvent [
	events addLast: anEpEvent.
	diff := nil.
]

{ #category : #private }
GtEpicea >> privateEvents: aCollection [
	events := aCollection.
	diff := nil.
]

{ #category : #modification }
GtEpicea >> removeEvent: anEpEvent [
	| aNewEvents |
	aNewEvents := self events reject: [ :eachEvent | eachEvent = anEpEvent ].
	ombuFile ensureDelete.
	aNewEvents do: [ :eachEvent | 
		self log addEntryWith: eachEvent tags: [ :tags | "ignore" ] ].
	self log store flush.
	self privateEvents: aNewEvents.
	self notifyEpiceaChanged.
]

{ #category : #accessing }
GtEpicea >> systemState [
	<return: #String>
	^ String streamContents: [ :aStream | 
		self events 
			do: [ :eachEvent | 
				| anOutput |
				anOutput := eachEvent accept: (GtEpiceaCurrentStateVisitor 
					inEnvironment: self theEnvironment).
				aStream nextPutAll: anOutput ]
			separatedBy: [ aStream cr; cr ] ]
]

{ #category : #accessing }
GtEpicea >> theEnvironment [
	^ self class environment
]

{ #category : #accessing }
GtEpicea >> tutorialState [
	<return: #String>
	^ String streamContents: [ :aStream | 
		self events 
			do: [ :eachEvent | 
				| anOutput |
				anOutput := eachEvent accept: GtEpiceaNewStateVisitor new.
				aStream nextPutAll: anOutput ]
			separatedBy: [ aStream cr; cr ] ]
]

{ #category : #accessing }
GtEpicea >> tutorialStateRope [
	<return: #BlRope>
	^ self tutorialState asRopedText
			glamorousCodeFontAndSize; 
			foreground: self constants matchLineColor
]

{ #category : #modification }
GtEpicea >> updateImpact [
	"Return true if impact changed"
	<return: #Boolean>
	| anImpactChanged |
	anImpactChanged := self computeImpact.
	anImpactChanged ifTrue: [ 
		self notifyEpiceaChangedWithImpactState: self hasImpact impactChanged: anImpactChanged ].
	^ anImpactChanged
]
