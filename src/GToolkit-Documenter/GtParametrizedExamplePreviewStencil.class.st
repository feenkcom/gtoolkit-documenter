Class {
	#name : #GtParametrizedExamplePreviewStencil,
	#superclass : #GtExamplePreviewStencil,
	#instVars : [
		'inputVariableNames'
	],
	#category : #'GToolkit-Documenter-Brick - Stencils'
}

{ #category : #accessing }
GtParametrizedExamplePreviewStencil >> example [
	^ example
]

{ #category : #accessing }
GtParametrizedExamplePreviewStencil >> inputVariableNames [
	^ inputVariableNames
]

{ #category : #accessing }
GtParametrizedExamplePreviewStencil >> inputVariableNames: anObject [
	inputVariableNames := anObject
]
