Class {
	#name : #GtOldPillarEpiceaBrickStencilBuilder,
	#superclass : #GtOldPillarBrickStencilBuilder,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #'api - instantiation' }
GtOldPillarEpiceaBrickStencilBuilder >> buildDefault [
	^ GtOldPillarEpiceaBrickStencil new
		codeSnippet: self codeSnippet
]
