Class {
	#name : #GtPillarCodeblock,
	#superclass : #GtPillarDocumentExecutablePart,
	#instVars : [
		'isException'
	],
	#category : 'GToolkit-Documenter-Pillar'
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
	| newValue aCompiler |
	self 
		assert: [ aGtBindingStrategy notNil ] 
		description: [ 'Binding strategy has to be defined' ].

	aGtBindingStrategy bindings: outBindings.
	aCompiler := self documentClass compiler
		source: self sourceCode asString readStream;
		compilationContext: (CompilationContext new
			class: self documentClass;
			forSyntaxHighlighting: false;
			bindings: aGtBindingStrategy;
			requestor: aGtBindingStrategy);
		receiver: self document.
	[ 
		newValue := aCompiler evaluate.
		outBindings value: newValue.
		isException := false.
		announcer announce: (GtCodeSnippetSuccessfulExecutionAnnouncement document: self document codeSnippet: self newValue: newValue).
	] on: Error do: [ :anException | 
		outBindings value: anException.
		isException := true.
		announcer announce: (GtCodeSnippetFailedExecutionAnnouncement document: self document codeSnippet: self exception: anException).
	].
	
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
