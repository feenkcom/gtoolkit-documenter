Class {
	#name : #GtPillarExampleStencilBuilder,
	#superclass : #GtPillarBrickStencilBuilder,
	#category : 'GToolkit-Documenter-Brick-Stencils'
}

{ #category : #'api - instantiation' }
GtPillarExampleStencilBuilder >> buildDefault [
	^ GtPillarExampleStencil new
		text: self text;
		editor: self editor;
		documentPart: self documentPart
]
