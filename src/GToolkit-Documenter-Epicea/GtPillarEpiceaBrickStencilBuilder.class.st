Class {
	#name : #GtPillarEpiceaBrickStencilBuilder,
	#superclass : #GtPillarBrickStencilBuilder,
	#category : 'GToolkit-Documenter-Epicea'
}

{ #category : #'api - instantiation' }
GtPillarEpiceaBrickStencilBuilder >> buildDefault [
	^ GtPillarEpiceaBrickStencil new
			documentPart: self documentPart
]
