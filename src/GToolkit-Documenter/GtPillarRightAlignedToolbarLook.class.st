Class {
	#name : #GtPillarRightAlignedToolbarLook,
	#superclass : #GtPillarToolbarLook,
	#category : #'GToolkit-Documenter-Brick-Looks'
}

{ #category : #initialization }
GtPillarRightAlignedToolbarLook >> initialize [
	super initialize.
	self add: (BrLayoutLook linearHorizontal alignCenterRight vFitContent hFitContent).
]
