Class {
	#name : #GtOldPillarEpiceaCodeSnippetHandler,
	#superclass : #GtPillarScriptHandler,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #parameters }
GtOldPillarEpiceaCodeSnippetHandler class >> epiceaParameterName [
	^ 'epicea'
]

{ #category : #initialization }
GtOldPillarEpiceaCodeSnippetHandler >> defaultPreviewStencilBuilder [
	^ GtOldPillarEpiceaBrickStencilBuilder new
]

{ #category : #private }
GtOldPillarEpiceaCodeSnippetHandler >> doHandle [
	"Handle (style) given script, represented by script parameters and tokens, in the target text"
	self styleParameters.
	self styleExpandingCode
]

{ #category : #'private-styles' }
GtOldPillarEpiceaCodeSnippetHandler >> expandingAttributes [
	| attributes expandingAttribute previewAttribute |
	attributes := super expandingAttributes.
	expandingAttribute := attributes first.
	previewAttribute := self newPreviewAttribute.
	expandingAttribute isExpanded: true.
	expandingAttribute createdAttributes: { previewAttribute }.
	^ attributes copyWith: previewAttribute.
]
