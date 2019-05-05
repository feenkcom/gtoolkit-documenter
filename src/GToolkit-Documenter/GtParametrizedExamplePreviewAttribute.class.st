Class {
	#name : #GtParametrizedExamplePreviewAttribute,
	#superclass : #GtExamplePreviewAttribute,
	#instVars : [
		'inputVariableNames'
	],
	#category : #'GToolkit-Documenter-Text - Attributes'
}

{ #category : #'instance creation' }
GtParametrizedExamplePreviewAttribute >> examplePreviewStencilClass [
	^ GtParametrizedExamplePreviewStencil
]

{ #category : #accessing }
GtParametrizedExamplePreviewAttribute >> inputVariableNames [
	^ inputVariableNames
]

{ #category : #accessing }
GtParametrizedExamplePreviewAttribute >> inputVariableNames: anObject [
	inputVariableNames := anObject
]

{ #category : #'instance creation' }
GtParametrizedExamplePreviewAttribute >> newExamplePreviewStencil [
	^ super newExamplePreviewStencil 
		inputVariableNames: self inputVariableNames
]
