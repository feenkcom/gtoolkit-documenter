Class {
	#name : #GtPillarBrickStencilBuilder,
	#superclass : #BrTextAdornmentStencilBuilder,
	#instVars : [
		'documentPart'
	],
	#category : #'GToolkit-Documenter-Brick-Stencils'
}

{ #category : #accessing }
GtPillarBrickStencilBuilder >> documentPart [
	<return: #GtPillarDocumentPart>

	^ documentPart
]

{ #category : #accessing }
GtPillarBrickStencilBuilder >> documentPart: aGtPillarDocumentPart [
	documentPart := aGtPillarDocumentPart
]

{ #category : #'api - instantiation' }
GtPillarBrickStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.
	
	aStencilExecutor push: self documentPart
]
