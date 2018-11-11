Class {
	#name : #Gt2EpiceaBrickVisitor,
	#superclass : #EpEntryContentVisitor,
	#category : #'GToolkit-NewDocumenter-Epicea'
}

{ #category : #private }
Gt2EpiceaBrickVisitor >> brickFactory [

	^ Gt2EpiceaBrickFactory default
]

{ #category : #private }
Gt2EpiceaBrickVisitor >> displayBehavior: aString [ 

	^ { self brickFactory emphasizedStringFor: aString }
]

{ #category : #private }
Gt2EpiceaBrickVisitor >> displayBehavior: aClassName method: aSelector [

	^ (self displayBehavior: aClassName), (self displayOperation: '»'), (self displayString: aSelector)
]

{ #category : #private }
Gt2EpiceaBrickVisitor >> displayBehaviorComment: aClassName [

	^ (self displayBehavior: aClassName), (self displayOperation: 'comment')
]

{ #category : #private }
Gt2EpiceaBrickVisitor >> displayBrowserOperation: aBrowserOperationEvent [

	^ self displayOperation: (
		String streamContents: [ :stream |
			stream nextPutAll: aBrowserOperationEvent title ])
]

{ #category : #private }
Gt2EpiceaBrickVisitor >> displayCategory: aCategoryName [

	^ (self displayOperation: 'Package tag'), (self displayString: aCategoryName asString)
]

{ #category : #private }
Gt2EpiceaBrickVisitor >> displayClass: aClassName protocol: aProtocolName [

	^ (self displayBehavior: aClassName), (self displayOperation: 'protocol'), (self displayString: aProtocolName)

]

{ #category : #private }
Gt2EpiceaBrickVisitor >> displayOperation: aString [ 

	^ self 
		displayString: aString 
		color: self brickFactory softerTextColor
]

{ #category : #private }
Gt2EpiceaBrickVisitor >> displayString: aString [

	^ { self brickFactory stringFor: aString }
]

{ #category : #private }
Gt2EpiceaBrickVisitor >> displayString: aString color: aColor [

	^ { self brickFactory stringFor: aString color: aColor }
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitBehaviorCategoryChange: aClassRecategorizationChange [

	^	(self displayOperation: 'Move'),
		(self displayBehavior: aClassRecategorizationChange behaviorAffectedName), 
		(self displayOperation: 'from tag'),
		(self displayString: aClassRecategorizationChange oldCategory), 
		(self displayOperation: 'to'), 
		(self displayString: aClassRecategorizationChange newCategory)
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitBehaviorCommentChange: aChange [

	^ self displayBehaviorComment: aChange behaviorAffectedName
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitBehaviorCopy: aClassCopy [

	^ (self displayBehavior: aClassCopy definition name), (self displayOperation: 'copyNamed:'), (self displayBehavior: '#', aClassCopy newName)
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitBehaviorNameChange: aClassRenamedChange [

	^	(self displayOperation: 'Rename'), 
		(self displayBehavior: aClassRenamedChange oldName), 
		(self displayOperation: 'as'), 
		(self displayString: aClassRenamedChange newName)
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitCategoryAddition: aCategoryChange [

	^ self displayCategory: aCategoryChange categoryName
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitCategoryRemoval: aCategoryChange [

	^ self displayCategory: aCategoryChange categoryName
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitCategoryRename: aCategoryChange [

	^	(self displayOperation: 'Rename tag'),
		(self displayString: aCategoryChange oldCategoryName),
		(self displayOperation: 'as'),
		(self displayString: aCategoryChange newCategoryName )
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitClassChange: aChange [

	^ self displayBehavior: aChange behaviorAffectedName
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitEvent: anEvent [

	^ self displayString: ''
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitExpressionEvaluation: anExpressionEvaluation [

	^ (self displayOperation: 'DoIt:'), (self displayString:
		(anExpressionEvaluation expression printStringLimitedTo: 50) 
			withSeparatorsCompacted)
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitLogCommentModification: aLogCommentModification [ 

	^ self displayString: aLogCommentModification comment printString
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitMethodAddition: aMethodCreatedChange [

	^ self 
		displayBehavior: aMethodCreatedChange behaviorAffectedName
		method: aMethodCreatedChange methodAdded selector
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitMethodModification: aMethodModified [

	^ self 
		displayBehavior: aMethodModified behaviorAffectedName
		method: aMethodModified oldMethod selector
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitMethodRemoval: aMethodRemoved [

	^ self 
		displayBehavior: aMethodRemoved behaviorAffectedName
		method: aMethodRemoved methodRemoved selector
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitMonticelloVersionSave: aChange [

	^	(self displayOperation: 'MC save'), 
		(self displayString: aChange versionName asString), 
		(self displayOperation: 'on'), 
		(self displayString: aChange repositoryDescription asString)
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitMonticelloVersionsLoad: aMonticelloVersionLoaded [ 

	^	(self displayOperation: 'MC load'), 
		(self displayString: aMonticelloVersionLoaded versionNames asCommaStringAnd)
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitProtocolAddition: aProtocolChange [

	^ self 
		displayClass: aProtocolChange behaviorAffectedName
		protocol: aProtocolChange protocol asString
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitProtocolRemoval: aProtocolChange [

	^ self 
		displayClass: aProtocolChange behaviorAffectedName
		protocol: aProtocolChange protocol asString
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitRedo: aRedoEvent [

	^ self displayBrowserOperation: aRedoEvent
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitRefactoring: aRefactoring [ 

	^  (self displayOperation: 'Refactoring: '), 
		(self displayString: (String streamContents: [ :aStream | 
			aRefactoring summaryOn: aStream ]))
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitSessionEnd: anEvent [

	^ (self displayOperation: 'End:'), 
		(self displayString: anEvent imageName)
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitSessionSnapshot: anEvent [

	^ (self displayOperation: 'Snapshot:'), 
		(self displayString: anEvent imageName)
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitSessionStart: anEvent [

	^ (self displayOperation: 'Start:'), 
		(self displayString: anEvent imageName)
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitTraitChange: aChange [

	^ self displayBehavior: aChange behaviorAffectedName
]

{ #category : #visitor }
Gt2EpiceaBrickVisitor >> visitUndo: anUndoEvent [

	^ self displayBrowserOperation: anUndoEvent
]
