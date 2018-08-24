Class {
	#name : #GtBindings,
	#superclass : #Object,
	#traits : 'GtAssertingTrait + GtBindingsTrait',
	#classTraits : 'GtAssertingTrait classTrait + GtBindingsTrait classTrait',
	#category : 'GToolkit-Documenter-Bindings'
}

{ #category : #asserting }
GtBindings class >> assert: aBlock description: aStringOrBlock [
	"Throw an assertion error if aBlock does not evaluates to true.
	We check for true explicitly to make the assertion fail for non booleans."
	
	self isAssertionEnabled
		ifTrue: [ (aBlock value == true) ifFalse: [ 
				AssertionFailure signal: aStringOrBlock value ] ]
]

{ #category : #adding }
GtBindings >> at: aSymbol put: anObject [ 
	"Set bindings for a variable named aSymbol and value anObject."
	self subclassResponsibility
]

{ #category : #binding }
GtBindings >> bindingOf: aSymbol [
	"aSymbol is a variable name.
	Return a literal variable if the variable has a value assigned.
	Return nil, if the variable has no value assigned."
	<return: #LiteralVariable or: nil>
	^ self subclassResponsibility	
]

{ #category : #'gt-inspector-extension' }
GtBindings >> gtInspectorBindingsIn: composite [
	^ self subclassResponsibility
]
