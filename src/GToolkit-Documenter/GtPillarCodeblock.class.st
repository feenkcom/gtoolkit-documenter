Class {
	#name : #GtPillarCodeblock,
	#superclass : #GtPillarDocumentExecutablePart,
	#instVars : [
		'isException'
	],
	#category : #'GToolkit-Documenter-Pillar'
}

{ #category : #accessing }
GtPillarCodeblock >> documentClass [
	^ self document class
]

{ #category : #actions }
GtPillarCodeblock >> executeWithPlaygroundStrategy [
	self executeWithStrategy: GtPlaygroundBindingStrategy new
]

{ #category : #actions }
GtPillarCodeblock >> executeWithStrategy: aGtBindingStrategy [
	| newValue aCommand anErrorCatchingCommand |
	self 
		assert: [ aGtBindingStrategy notNil ] 
		description: [ 'Binding strategy has to be defined' ].
	aGtBindingStrategy bindings: outBindings.
	aCommand := GtEvaluateSourceCodeCommand new.
	aCommand requestor: self.
	aCommand sourceCode: self sourceCode asString.
	aCommand variableBindings: aGtBindingStrategy.
	aCommand receiver: self document.
	anErrorCatchingCommand := aCommand asErrorCatchingCommand.
	anErrorCatchingCommand execute.
	newValue := anErrorCatchingCommand result.
	outBindings value: newValue.
	isException := anErrorCatchingCommand isException.
	isException 
		ifFalse: [ 
			announcer announce: (GtCodeSnippetSuccessfulExecutionAnnouncement 
				document: self document codeSnippet: self newValue: newValue) ]
		ifTrue: [  
			announcer announce: (GtCodeSnippetFailedExecutionAnnouncement 
				document: self document codeSnippet: self exception: newValue) ].
]

{ #category : #initialization }
GtPillarCodeblock >> initialize [
	super initialize.
	isException := false.
]

{ #category : #testing }
GtPillarCodeblock >> isException [
	^ isException
]

{ #category : #accessing }
GtPillarCodeblock >> label [
	<return: #String>
	^ self pillarNode label ifEmpty: [ GtDocumenterConstants defaultExecuteButtonLabel ]
]

{ #category : #accessing }
GtPillarCodeblock >> sourceCode [
	<return: #String>
	^ self pillarNode text
]
