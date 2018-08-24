Class {
	#name : #GtOutBindings,
	#superclass : #GtBindings,
	#instVars : [
		'result',
		'bindings'
	],
	#category : 'GToolkit-Documenter-Bindings'
}

{ #category : #converting }
GtOutBindings >> asDictionary [
	<return: #Dictionary>
	| aDictionary anOutBindings |
	aDictionary := self bindings asDictionary.
	anOutBindings := self previousCodeSnippetResult.
	anOutBindings ifNotNil: [ 
		aDictionary 
			at: GtDocumenterConstants resultVariableName
			put: anOutBindings ].
	^ aDictionary
]

{ #category : #adding }
GtOutBindings >> at: aSymbol put: anObject [ 
	"Set bindings for a variable named aSymbol and value anObject."
	self assert: [ aSymbol isSymbol ] description: [ 'Variable name should be a symbol' ].
	aSymbol = GtDocumenterConstants resultVariableName
		ifTrue: [ self value: anObject ]
		ifFalse: [ bindings at: aSymbol put: anObject ]
]

{ #category : #binding }
GtOutBindings >> bindingOf: aSymbol [
	"aSymbol is a variable name.
	Return a literal variable if the variable has a value assigned.
	Return nil, if the variable has no value assigned."
	<return: #LiteralVariable or: nil>
	self assert: [ aSymbol isSymbol ] description: [ 'Variable name should be a symbol' ].
	^ aSymbol = GtDocumenterConstants resultVariableName 
		ifTrue: [ self previousCodeSnippetResult ]
		ifFalse: [ bindings bindingOf: aSymbol ]
]

{ #category : #accessing }
GtOutBindings >> bindings [
	^ bindings
]

{ #category : #accessing }
GtOutBindings >> bindings: anObject [
	bindings := anObject
]

{ #category : #private }
GtOutBindings >> ensureResult [
	result ifNotNil: [ ^ self ].
	result := WorkspaceVariable named: GtDocumenterConstants resultVariableName.
]

{ #category : #'gt-inspector-extension' }
GtOutBindings >> gtInspectorBindingsIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ bindings gtInspectorBindingsIn: composite
]

{ #category : #testing }
GtOutBindings >> hasResult [
	^ result notNil
]

{ #category : #initialization }
GtOutBindings >> initialize [
	super initialize.
	bindings := GtNoBindings uniqueInstance.
]

{ #category : #private }
GtOutBindings >> outs [
	<return: #LiteralVariable or: nil>
	^ bindings bindingOf: GtDocumenterConstants resultsVariableName 
]

{ #category : #private }
GtOutBindings >> previousCodeSnippetResult [
	<return: #LiteralVariable or: nil>
	^ self outs ifNotNil: [ :anLiteralVariable | 
		anLiteralVariable value before: self ]
]

{ #category : #accessing }
GtOutBindings >> result [
	^ result
]

{ #category : #accessing }
GtOutBindings >> value [
	^ result value
]

{ #category : #accessing }
GtOutBindings >> value: anObject [
	self ensureResult.
	^ result value: anObject
]
