Class {
	#name : #GtPillarInlinedCompositeLook,
	#superclass : #BrLook,
	#category : #'GToolkit-Documenter-Brick-Looks'
}

{ #category : #initialization }
GtPillarInlinedCompositeLook >> initialize [
	super initialize.

	self add: (BrLayoutLook linearHorizontal alignCenterLeft fitContent)
]
