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

{ #category : #'gt-inspector-extension' }
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

{ #category : #'gt-inspector-extension' }
GtEpiceaLog >> gtInspectorGlobalEntriesIn: composite [
	<gtInspectorPresentationOrder: 2>
	^ (EpMonitor current log gtInspectorEntriesIn: composite)
			title: [ 'Global Changes' translated ];
			selectionAct: [ :aPresentation | 
				self insertSelectedItemsFromPresentation: aPresentation  ] 
				entitled: 'Add to tutorial' 
				condition: [ true ]
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
