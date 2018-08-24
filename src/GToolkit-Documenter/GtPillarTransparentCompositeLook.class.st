Class {
	#name : #GtPillarTransparentCompositeLook,
	#superclass : #BrLook,
	#category : 'GToolkit-Documenter-Brick-Looks'
}

{ #category : #initialization }
GtPillarTransparentCompositeLook >> initialize [
	super initialize.
	self add: (BrLayoutLook linearVertical 
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c vertical fitContentLimited.
			c horizontal matchParent ]).
]
