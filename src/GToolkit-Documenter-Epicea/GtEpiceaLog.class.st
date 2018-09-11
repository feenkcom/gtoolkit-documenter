Class {
	#name : #GtEpiceaLog,
	#superclass : #Object,
	#traits : 'GtAssertingTrait + GtAnnouncerTrait',
	#classTraits : 'GtAssertingTrait classTrait + GtAnnouncerTrait classTrait',
	#instVars : [
		'ombuFile',
		'errorHandler',
		'hasImpact',
		'theLog'
	],
	#classVars : [
		'DebugMode'
	],
	#category : 'GToolkit-Documenter-Epicea'
}

{ #category : #'instance creation' }
GtEpiceaLog class >> fromFileReference: aFileReference [
	^ self new ombuFile: aFileReference asFileReference
]

{ #category : #initialization }
GtEpiceaLog class >> initialize [
	self unsetDebugMode
]

{ #category : #initialization }
GtEpiceaLog class >> setDebugMode [
	<script>
	DebugMode := true
]

{ #category : #initialization }
GtEpiceaLog class >> unsetDebugMode [
	<script>
	DebugMode := false
]

{ #category : #actions }
GtEpiceaLog >> addEntryWith: anEpEvent tags: aBlockClosure [
	self ombuFile parent exists ifFalse: [ self ombuFile parent ensureCreateDirectory ].
	self 
		assert: [ self ombuFile parent exists ] 
		description: [ 'The parent directory of the Epicea change file should exist' ].
	theLog addEntryWith: anEpEvent tags: aBlockClosure.
]

{ #category : #accessing }
GtEpiceaLog >> announcer [
	self 
		assert: [ theLog notNil ]
		description: [ 'Epicea log has to be initialized first. Then you can use the announcer' ].
	^ theLog announcer
]

{ #category : #actions }
GtEpiceaLog >> applyCodeChanges [
	self assert: [ theLog notNil ] description: 'Epicea log is not initialized.'.
	self isValid ifFalse: [ ^ self ].
	EpLogBrowserOperationFactory new
		logBrowserModel: theLog;
		entries: theLog entries;
		errorHandlerBlock: errorHandler;
		applyCodeChanges.
]

{ #category : #actions }
GtEpiceaLog >> browseEvents [
	theLog browseEvents
]

{ #category : #private }
GtEpiceaLog >> checkImpact [
	hasImpact := self checkImpact: theLog entries
]

{ #category : #testing }
GtEpiceaLog >> checkImpact: entries [
	^ entries anySatisfy: [ :eachEntry | 
		eachEntry content accept: (EpHasImpactVisitor inEnvironment: self theEnvironment) ]
]

{ #category : #accessing }
GtEpiceaLog >> currentStateString [
	<return: #String>
	^ String streamContents: [ :aStream | 
		theLog entries 
			do: [ :eachEntry | | output |
				output := eachEntry content accept: (GtEpiceaCurrentStateVisitor 
					inEnvironment: self theEnvironment).
				aStream nextPutAll: output ]
			separatedBy: [ aStream cr; cr ] ]
]

{ #category : #actions }
GtEpiceaLog >> flush [
	self 
		assert: [ theLog notNil ] 
		description: [ 'Flush method should be called after the log initialization' ].
	theLog store flush.
]

{ #category : #'gt-extension' }
GtEpiceaLog >> gtGlobalEntriesIn: aView [
	<gtView>
	^ aView explicit 
		title: 'Global Entries';
		priority: 20;
		stencil: [ 
			| aList aGlobalLog |
			aGlobalLog := EpMonitor current log entries.
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
						"size: 30@30;"
						icon: GtInspectorPlusIconStencil new asElement;
						action: [ 
							self addEntryWith: anOmEntry content tags: [ :tags | ].
							anAddButton enqueueTask: (BlTaskAction new 
								action: [ anAddButton visibility: BlVisibility hidden ]).
							anAddButton enqueueTask: (BlDelayedTaskAction new 
								action: [ anAddButton visibility: BlVisibility visible  ]) ];
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
GtEpiceaLog >> gtInspectorEntriesIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ theLog ifNotNil: [ :aLog | 
		(aLog gtInspectorEntriesIn: composite)
			title: [ 'Tutorial' translated ];
			updateOn: EpEntryAdded from: [ self announcer ];
			selectionAct: [ :aPresentation | 
				self removeSelectedItemsFromPresentation: aPresentation  ] 
				entitled: 'Remove from tutorial' 
				condition: [ true ] ]
]

{ #category : #'gt-extension' }
GtEpiceaLog >> gtInspectorGlobalEntriesIn: composite [
	<gtInspectorPresentationOrder: 2>
	^ (EpMonitor current log gtInspectorEntriesIn: composite)
			title: [ 'Global Changes' translated ];
			selectionAct: [ :aPresentation | 
				self insertSelectedItemsFromPresentation: aPresentation  ] 
				entitled: 'Add to tutorial' 
				condition: [ true ]
]

{ #category : #'gt-extension' }
GtEpiceaLog >> gtTutorialEntriesIn: aView [
	<gtView>
	theLog ifNil: [ ^ aView empty ].
	^ aView explicit 
		title: 'Tutorial';
		priority: 0;
		stencil: [ 
			| aList anEntries |
			anEntries := theLog store entries.
			aList := BrColumnedList new display: anEntries.
			aList addEventHandler: GtInspectorListToSelectHandler new.
			aList constraintsDo: [ :c | c padding: (BlInsets top: 10) ].
			self announcer 
				when: EpEntryAdded 
				do: [ :anAnnouncement | aList display: theLog store entries ].
			
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
						icon: (BlElement new 
							geometry: BlRectangle new;
							layout: BlLinearLayout new;
							background: Color lightGray;
							size: 10@3);
						action: [ 
							self removeEntity: anOmEntry.
							anAddButton enqueueTask: (BlTaskAction new 
								action: [ anAddButton visibility: BlVisibility hidden ]) ];
						visibility: BlVisibility hidden.
					aContainer := BlElement new 
						layout: BlLinearLayout horizontal;
						addChildren: (anOmEntry content accept: GtEpiceaBrickVisitor new);
						addChild: anAddButton;
						constraintsDo: [ :c | 
							c horizontal fitContent.
							c vertical fitContent ].
					aContainer when: BlMouseEnterEvent do: [ :anEvent | 
						anAddButton visibility: BlVisibility visible ].
					aContainer when: BlMouseLeaveEvent do: [ :anEvent | 
						anAddButton visibility: BlVisibility hidden ].
					aContainer ].
			aList
			 ]
]

{ #category : #testing }
GtEpiceaLog >> hasImpact [
	hasImpact ifNil: [ self checkImpact ].
	^ hasImpact
]

{ #category : #initialization }
GtEpiceaLog >> initialize [
	super initialize.
	errorHandler := [ :error | | message |
		DebugMode ifTrue: [ error pass ].
		message := 'error on operation: ' , error asString.
		message traceCr.
		self inform: message ].
]

{ #category : #private }
GtEpiceaLog >> insertSelectedItemsFromPresentation: aGLMPresentation [ 
	| anOmbuEntry |
	anOmbuEntry := aGLMPresentation rawSelection.
	anOmbuEntry ifNil: [ ^ self ].
	self addEntryWith: anOmbuEntry content tags: [ :tags |  ].
]

{ #category : #testing }
GtEpiceaLog >> isValid [
	^ self ombuFile notNil and: [ self ombuFile exists ]
]

{ #category : #accessing }
GtEpiceaLog >> newStateString [
	<return: #String>
	^ String streamContents: [ :aStream | 
		theLog entries 
			do: [ :eachEntry | | entryItem |
				entryItem := EpEntryItem new entry: eachEntry.
				aStream nextPutAll: entryItem newStateString ]
			separatedBy: [ aStream cr; cr ] ]
]

{ #category : #accessing }
GtEpiceaLog >> oldStateString [
	<return: #String>
	^ String streamContents: [ :aStream | 
		theLog entries 
			do: [ :eachEntry | | entryItem |
				entryItem := EpEntryItem new entry: eachEntry.
				aStream nextPutAll: entryItem oldStateString ]
			separatedBy: [ aStream cr; cr ] ]
]

{ #category : #accessing }
GtEpiceaLog >> ombuFile [
	^ ombuFile
]

{ #category : #accessing }
GtEpiceaLog >> ombuFile: aFileReference [
	ombuFile := aFileReference.
	theLog := EpLog freshFromFile: ombuFile.
]

{ #category : #private }
GtEpiceaLog >> removeEntity: anOmbuEntry [ 
	| entries |
	entries := (theLog entries reject: [ :eachEntry | eachEntry xdEquals: anOmbuEntry ]).
	ombuFile ensureDelete.
	entries do: [ :eachEntry | 
		self addEntryWith: eachEntry content tags: [ :tags |  ] ] 
]

{ #category : #private }
GtEpiceaLog >> removeSelectedItemsFromPresentation: aGLMPresentation [ 
	| anOmbuEntry entries |
	anOmbuEntry := aGLMPresentation rawSelection.
	anOmbuEntry ifNil: [ ^ self ].
	entries := (theLog entries reject: [ :eachEntry | eachEntry xdEquals: anOmbuEntry ]).
	ombuFile ensureDelete.
	entries do: [ :eachEntry | 
		self addEntryWith: eachEntry content tags: [ :tags |  ] ] 
]

{ #category : #accessing }
GtEpiceaLog >> theEnvironment [
	^ self class environment
]
