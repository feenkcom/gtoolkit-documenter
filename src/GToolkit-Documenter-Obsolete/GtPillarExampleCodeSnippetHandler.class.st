Class {
	#name : #GtPillarExampleCodeSnippetHandler,
	#superclass : #GtPillarScriptHandler,
	#instVars : [
		'exampleMethod'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #initialization }
GtPillarExampleCodeSnippetHandler >> defaultPreviewStencilBuilder [
	^ GtOldDocumenterExampleCodeSnippetStencilBuilder new
]

{ #category : #private }
GtPillarExampleCodeSnippetHandler >> doHandle [
	self styleParameters.
	self styleExpandingCode
]

{ #category : #accessing }
GtPillarExampleCodeSnippetHandler >> exampleMethod [
	<return: #CompiledMethod>
	^ exampleMethod ifNil: [ exampleMethod := Compiler evaluate: tokens exampleParameterValue ].
]

{ #category : #'private-styles' }
GtPillarExampleCodeSnippetHandler >> expandingAttributes [
	| attributes expandingAttribute |
	attributes := super expandingAttributes.
	expandingAttribute := attributes first.
	^ tokens shouldBeExpanded
		ifFalse: [ attributes ]
		ifTrue: [ | previewAttribute |
			previewAttribute := self newPreviewAttribute.
			expandingAttribute isExpanded: true.
			expandingAttribute createdAttributes: { previewAttribute }.
			attributes copyWith: previewAttribute ].
]
