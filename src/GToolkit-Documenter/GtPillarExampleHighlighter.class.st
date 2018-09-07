Class {
	#name : #GtPillarExampleHighlighter,
	#superclass : #GtPillarNodeHighlighter,
	#category : 'GToolkit-Documenter-Pillar - Highlighter'
}

{ #category : #'api - actions' }
GtPillarExampleHighlighter >> highlight [
	self stylePillarNodeText.
	self styleExpandingView.
]

{ #category : #'instance creation' }
GtPillarExampleHighlighter >> newPreviewAttribute [
	^ BrTextAdornmentDynamicAttribute new
		beAppend;
		stencil: (GtPillarExampleStencilBuilder new documentPart: self pillarNode)
]

{ #category : #'private-styles' }
GtPillarExampleHighlighter >> styleExpandingView [
	| anAttributeCreatingBlock |
	anAttributeCreatingBlock := [ self newPreviewAttribute ].
	self pillarNode expandedParameterValue
		ifTrue: [ self styleExpandedTextExpandAttribute: anAttributeCreatingBlock ]
		ifFalse: [ self styleCollapsedTextExpandAttribute: anAttributeCreatingBlock ]
]
