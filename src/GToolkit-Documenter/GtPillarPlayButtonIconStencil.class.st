"
I create a play button icon

Example:

[[[
	(GtPillarPlayButtonIconStencil new) asElement
]]]
"
Class {
	#name : #GtPillarPlayButtonIconStencil,
	#superclass : #BrStencil,
	#category : 'GToolkit-Documenter-Brick-Stencils'
}

{ #category : #'api - instantiation' }
GtPillarPlayButtonIconStencil >> create [
	^ BlElement new
		size: 8@10;
    	geometry: (BlPolygon vertices: { 0@0 . 8@5. 0@10 });
    	background: Color green muchDarker;
		margin: (BlInsets all: 2)
]
