Class {
	#name : #Gt2Epicea,
	#superclass : #Object,
	#traits : 'TBlDebug + TGt2DocumentConstants + GtAnnouncerTrait',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait + GtAnnouncerTrait classTrait',
	#instVars : [
		'announcer',
		'ombuFile',
		'epiceaLog',
		'events',
		'diff',
		'applyErrorHandler',
		'hasImpact'
	],
	#classVars : [
		'DebugMode'
	],
	#category : #'GToolkit-NewDocumenter-Epicea'
}

{ #category : #modification }
Gt2Epicea >> addEvent: anEpEvent [ 
	self ombuFile parent exists ifFalse: [ self ombuFile parent ensureCreateDirectory ].
	self 
		assert: [ self ombuFile parent exists ] 
		description: [ 'The parent directory of the Epicea change file must exist' ].
	self log addEntryWith: anEpEvent tags: [ :tags | "ignore" ].
	self log store flush.
]

{ #category : #accessing }
Gt2Epicea >> announcer [
	^ announcer
]

{ #category : #modification }
Gt2Epicea >> applyChanges [
	self 
		assert: [ self log notNil ] 
		description: [ 'Epicea log must be non-nil.' ].
	self ombuFileExists ifFalse: [ ^ self ].
	EpLogBrowserOperationFactory new
		logBrowserModel: self log;
		entries: self entries;
		errorHandlerBlock: applyErrorHandler;
		applyCodeChanges.
	self notifyEpiceaChanged.
]

{ #category : #private }
Gt2Epicea >> computeImpact [
	"Return true if impact changed"
	<return: #Boolean>
	| anOldImpactState |
	anOldImpactState := hasImpact.
	hasImpact := self events anySatisfy: [ :eachEvent | 
			eachEvent accept: (EpHasImpactVisitor inEnvironment: self theEnvironment) ].
	hasImpact = anOldImpactState ifFalse: [ diff := nil ].
	^ hasImpact = anOldImpactState
]

{ #category : #accessing }
Gt2Epicea >> diff [
	<return: #BlRope>
	^ diff ifNil: [ 
			diff := Gt2EpiceaDiffStencil new
				from: self systemState;
				to: self tutorialState;
				create ]
]

{ #category : #accessing }
Gt2Epicea >> entries [
	<return: #OrderedeCollection of: #OmEntry>
	^ self log entries
]

{ #category : #accessing }
Gt2Epicea >> events [
	<return: #OrderedeCollection of: #EpEvent>
	^ events
]

{ #category : #'gt-extension' }
Gt2Epicea >> gtDiffFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Diff';
		priority: 2;
		text: [ :anEditor | 
			self 
				when: Gt2EpiceaUpdatedAnnouncement 
				do: [ anEditor text: self diff asRopedText ].		
			self diff ]
]

{ #category : #'gt-extension' }
Gt2Epicea >> gtEventsFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Tutorial Changes';
		priority: 3;
		stencil: [ 
			| aList |
			aList := BrColumnedList new display: self events.
			aList addEventHandler: GtInspectorListToSelectHandler new.
			aList constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
			self announcer 
				when: Gt2EpiceaUpdatedAnnouncement 
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
						look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
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
Gt2Epicea >> gtGlobalEntriesIn: aView [
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
						look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
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
Gt2Epicea >> gtPreviewFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Document Preview';
		priority: 10;
		text: [ :anEditor | 
			self 
				when: Gt2EpiceaUpdatedAnnouncement 
				do: [ anEditor text: self diff asRopedText ].
			self tutorialState asRopedText 
				monospace; 
				foreground: self constants matchLineColor ]
]

{ #category : #'gt-extension' }
Gt2Epicea >> gtTutorialFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Tutorial';
		priority: 1;
		text: [ :anEditor | 
			self 
				when: Gt2EpiceaUpdatedAnnouncement 
				do: [ anEditor text: self tutorialStateRope ].
			self tutorialStateRope ]
]

{ #category : #'announcement handling' }
Gt2Epicea >> handleEpEntryAddedAnnouncement: anEpEntryAdded [
	self privateAddEvent: anEpEntryAdded entry content.
	self notifyEpiceaChanged.
]

{ #category : #accessing }
Gt2Epicea >> hasImpact [
	"Return true, if changes have impact to the current system state"
	<return: #Boolean>
	^ hasImpact
]

{ #category : #initialization }
Gt2Epicea >> initialize [
	super initialize.
	announcer := Announcer new.
	hasImpact := false.
	applyErrorHandler := [ :anException | | message |
		DebugMode ifTrue: [ anException pass ].
		message := 'Error while applying Epicea changes: ' , anException asString.
		message traceCr.
		self inform: message ].
]

{ #category : #accessing }
Gt2Epicea >> log [
	<return: #EpLog>
	^ epiceaLog
]

{ #category : #notifying }
Gt2Epicea >> notifyEpiceaChanged [
	self computeImpact.
	self notifyEpiceaChangedWithImpactState: self hasImpact
]

{ #category : #notifying }
Gt2Epicea >> notifyEpiceaChangedWithImpactState: aBoolean [
	self announce: (Gt2EpiceaUpdatedAnnouncement new hasImpact: aBoolean)
]

{ #category : #accessing }
Gt2Epicea >> numberOfEvents [
	<return: #Integer>
	^ events ifNotNil: #size ifNil: 0
]

{ #category : #accessing }
Gt2Epicea >> ombuFile [
	<return: #FileReference>
	^ ombuFile
]

{ #category : #accessing }
Gt2Epicea >> ombuFile: aFileReference [
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
Gt2Epicea >> ombuFileExists [
	<return: #Boolean>
	^ self ombuFile notNil and: [ self ombuFile exists ]
]

{ #category : #private }
Gt2Epicea >> privateAddEvent: anEpEvent [
	events addLast: anEpEvent.
	diff := nil.
]

{ #category : #private }
Gt2Epicea >> privateEvents: aCollection [
	events := aCollection.
	diff := nil.
]

{ #category : #modification }
Gt2Epicea >> removeEvent: anEpEvent [
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
Gt2Epicea >> systemState [
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
Gt2Epicea >> theEnvironment [
	^ self class environment
]

{ #category : #accessing }
Gt2Epicea >> tutorialState [
	<return: #String>
	^ String streamContents: [ :aStream | 
		self events 
			do: [ :eachEvent | 
				| anOutput |
				anOutput := eachEvent accept: EpNewStateVisitor new.
				aStream nextPutAll: anOutput ]
			separatedBy: [ aStream cr; cr ] ]
]

{ #category : #accessing }
Gt2Epicea >> tutorialStateRope [
	<return: #BlRope>
	^ self tutorialState asRopedText
			monospace; 
			foreground: self constants matchLineColor
]

{ #category : #modification }
Gt2Epicea >> updateImpact [
	"Return true if impact changed"
	<return: #Boolean>
	| anImpactChanged |
	anImpactChanged := self computeImpact.
	anImpactChanged ifTrue: [ 
		self notifyEpiceaChangedWithImpactState: self hasImpact ].
	^ anImpactChanged
]
