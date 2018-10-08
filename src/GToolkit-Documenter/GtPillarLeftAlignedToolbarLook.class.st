Class {
	#name : #GtPillarLeftAlignedToolbarLook,
	#superclass : #GtPillarToolbarLook,
	#category : #'GToolkit-Documenter-Brick-Looks'
}

{ #category : #initialization }
GtPillarLeftAlignedToolbarLook >> initialize [
	super initialize.
	self add: (BrLayoutLook linearHorizontal alignCenterLeft vFitContent hMatchParent).
]
