Class {
	#name : #GtOldExampleCodeSnippet,
	#superclass : #GtOldAnnouncableCodeSnippet,
	#instVars : [
		'showMessageName',
		'previewHeight',
		'shouldDisplayCode',
		'shouldExpandPreview',
		'methodDefinition'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #accessing }
GtOldExampleCodeSnippet >> exampleMethod [
	<return: #CompiledMethod>
	^ methodDefinition isDefined
		ifTrue: [ methodDefinition compiledMethod ] 
		ifFalse: [ nil ]
]

{ #category : #'announcement handling' }
GtOldExampleCodeSnippet >> handleClassAddedOrRemovedAnnouncement: aClassAnnouncement [
	self methodClassName ifNil: [ ^ self ].
	((aClassAnnouncement classAffected name = self methodClassName) or: [ 
		aClassAnnouncement classAffected name = ('AnObsolete', self methodClassName) ]) 
			ifFalse: [ ^ self ].
	self announcer announce: (GtExampleClassUpdatedAnnouncement 
		document: self document
		codeSnippet: self)
]

{ #category : #'announcement handling' }
GtOldExampleCodeSnippet >> handleClassRenamedAnnouncement: aClassAnnouncement [
	((aClassAnnouncement newName = self methodClassName) or: [ 
		aClassAnnouncement oldName = self methodClassName ]) ifFalse: [ ^ self ].
	self announcer announce: (GtExampleClassUpdatedAnnouncement 
		document: self document
		codeSnippet: self)
]

{ #category : #'announcement handling' }
GtOldExampleCodeSnippet >> handleMethodAnnouncement: aMethodModified [ 
	((aMethodModified classAffected name = self methodClassName) and: [ 
		aMethodModified selector = self methodSelectorName ]) ifFalse: [ ^ self ].
	self announcer announce: (GtExampleClassUpdatedAnnouncement 
		document: self document
		codeSnippet: self)
]

{ #category : #'announcement handling' }
GtOldExampleCodeSnippet >> handleSystemChange: aSystemAnnouncement [ 
	self announcer announce: (GtExampleClassUpdatedAnnouncement 
		document: self document
		codeSnippet: self)
]

{ #category : #initialization }
GtOldExampleCodeSnippet >> initialize [
	super initialize.
	shouldDisplayCode := true.
	shouldExpandPreview := true.
]

{ #category : #initialization }
GtOldExampleCodeSnippet >> initializeFromTokens: aGtPillarScriptTokens [
	"Initialize code snippet using an information from a Pillar document"
	super initializeFromTokens: aGtPillarScriptTokens.
	self methodName: aGtPillarScriptTokens exampleParameterValue.
	aGtPillarScriptTokens hasShowParameter  
		ifTrue: [ self showMessageName: aGtPillarScriptTokens showParameterValue ].
	aGtPillarScriptTokens isPreviewHeightDefined ifTrue: [ 
		self previewHeight: aGtPillarScriptTokens heightParameterValue ].
	self showMessageName: aGtPillarScriptTokens showParameterValue.
	self shouldDisplayCode: aGtPillarScriptTokens shouldDisplayCode.
	self shouldExpandPreview: aGtPillarScriptTokens shouldExpandPreview.
]

{ #category : #testing }
GtOldExampleCodeSnippet >> isMethodClassDefined [
	^ methodDefinition parent isDefined
]

{ #category : #testing }
GtOldExampleCodeSnippet >> isMethodDefined [
	^ methodDefinition isDefined
]

{ #category : #testing }
GtOldExampleCodeSnippet >> isPreviewHeightDefined [
	^ self previewHeight notNil
]

{ #category : #accessing }
GtOldExampleCodeSnippet >> methodClass [
	<return: #Class>
	^ self exampleMethod methodClass
]

{ #category : #accessing }
GtOldExampleCodeSnippet >> methodClassName [
	<return: #String or: nil>
	^ methodDefinition ifNotNil: [ :aMethodDefinition | aMethodDefinition parent name ]
]

{ #category : #accessing }
GtOldExampleCodeSnippet >> methodName [
	<return: #String or: nil>
	^ methodDefinition printString
]

{ #category : #accessing }
GtOldExampleCodeSnippet >> methodName: aString [
	"Set Ring method definition from a string method definition, e.g., MyClass>>#myMethod"
	methodDefinition := GtSystemUtility methodDefinitionFromString: aString
]

{ #category : #accessing }
GtOldExampleCodeSnippet >> methodSelectorName [
	<return: #String>
	^ methodDefinition selector
]

{ #category : #accessing }
GtOldExampleCodeSnippet >> methodSourceCode [
	<return: #String>
	^ self exampleMethod sourceCode
]

{ #category : #accessing }
GtOldExampleCodeSnippet >> previewHeight [
	<return: #Integer or: nil>
	^ previewHeight
]

{ #category : #accessing }
GtOldExampleCodeSnippet >> previewHeight: anInteger [
	self 
		assert: [ anInteger isInteger ] 
		description: [ 'Preview height parameter should be an integer' ].
	previewHeight := anInteger
]

{ #category : #testing }
GtOldExampleCodeSnippet >> shouldDisplayCode [
	^ shouldDisplayCode
]

{ #category : #accessing }
GtOldExampleCodeSnippet >> shouldDisplayCode: aBoolean [
	self 
		assert: [ aBoolean == true or: [ aBoolean == false ] ] 
		description: [ 'Should display code parameter should be a boolean' ].
	shouldDisplayCode := aBoolean
]

{ #category : #testing }
GtOldExampleCodeSnippet >> shouldDisplayResult [
	^ self showMessageName notNil
]

{ #category : #accessing }
GtOldExampleCodeSnippet >> shouldExpandPreview [
	<return: #Boolean>
	^ shouldExpandPreview
]

{ #category : #accessing }
GtOldExampleCodeSnippet >> shouldExpandPreview: aBoolean [
	self 
		assert: [ aBoolean == true or: [ aBoolean == false ] ] 
		description: [ 'Should expand preview parameter should be a boolean' ].
	shouldExpandPreview := aBoolean
]

{ #category : #accessing }
GtOldExampleCodeSnippet >> showMessageName [
	"Return a message name that should be used to display an example preview (result)"
	<return: #Symbol or: nil>
	^ showMessageName
]

{ #category : #accessing }
GtOldExampleCodeSnippet >> showMessageName: aSymbol [
	"Set a message name that should be used to display an example preview (result)"
	self assert: [ aSymbol isSymbol ] description: [ 'Message name has to be a symbol' ].
	showMessageName := aSymbol
]

{ #category : #private }
GtOldExampleCodeSnippet >> subscribeToDocument: aGtDocument [ 
	super subscribeToDocument: aGtDocument.
	aGtDocument systemChangesHandler
		subscribe: MethodAdded, MethodModified, MethodRemoved
		send: #handleMethodAnnouncement:
		to: self.
	aGtDocument systemChangesHandler
		subscribe: ClassAdded, ClassRemoved
		send: #handleClassAddedOrRemovedAnnouncement:
		to: self.
	aGtDocument systemChangesHandler
		subscribe: ClassRenamed
		send: #handleClassRenamedAnnouncement:
		to: self.
]
