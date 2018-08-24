Class {
	#name : #GtOldExecutableCodeSnippet,
	#superclass : #GtOldAnnouncableCodeSnippet,
	#instVars : [
		'label',
		'isException'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #protocol }
GtOldExecutableCodeSnippet >> executeWithPlaygroundStrategy [
	self executeWithStrategy: GtPlaygroundBindingStrategy new
]

{ #category : #protocol }
GtOldExecutableCodeSnippet >> executeWithStrategy: aGtBindingStrategy [
	| newValue aCompiler |
	self 
		assert: [ aGtBindingStrategy notNil ] 
		description: [ 'Binding strategy has to be defined' ].

	aGtBindingStrategy bindings: self.
	aCompiler := self documentClass compiler
		source: self sourceCode readStream;
		compilationContext: (CompilationContext new
			class: self documentClass class;
			forSyntaxHighlighting: false;
			bindings: aGtBindingStrategy;
			requestor: aGtBindingStrategy);
		receiver: self document.
	[ 
		newValue := aCompiler evaluate.
		self value: newValue.
		isException := false.
		announcer announce: (GtCodeSnippetSuccessfulExecutionAnnouncement document: self document codeSnippet: self newValue: newValue).
	] on: Error do: [ :anException | 
		self value: anException.
		isException := true.
		announcer announce: (GtCodeSnippetFailedExecutionAnnouncement document: self document codeSnippet: self exception: anException).
	].
	
]

{ #category : #initialization }
GtOldExecutableCodeSnippet >> initialize [
	super initialize.
	label := GtDocumenterConstants defaultExecuteButtonLabel.
	isException := false.
]

{ #category : #initialization }
GtOldExecutableCodeSnippet >> initializeFromTokens: aGtPillarScriptTokens [
	"Initialize code snippet using an information from a Pillar document"
	super initializeFromTokens: aGtPillarScriptTokens.
	self label: aGtPillarScriptTokens labelParameterValue.
]

{ #category : #testing }
GtOldExecutableCodeSnippet >> isException [
	"Answer whether the last code snippet evaluation was with an exception (true) or not (false)"
	<return: #Boolean>
	^ isException
]

{ #category : #accessing }
GtOldExecutableCodeSnippet >> label [
	<return: #String>
	^ label
]

{ #category : #accessing }
GtOldExecutableCodeSnippet >> label: aString [
	self 
		assert: [ aString isString ] 
		description: [ 'Label should be an instance of String' ].
	label := aString
]
