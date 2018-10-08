Class {
	#name : #GtPillarResizablePreviewLook,
	#superclass : #BrLook,
	#traits : 'GtDocumenterConstantsTrait',
	#classTraits : 'GtDocumenterConstantsTrait classTrait',
	#category : #'GToolkit-Documenter-Brick-Looks'
}

{ #category : #initialization }
GtPillarResizablePreviewLook >> initialize [
	super initialize.
	self add: (BrLayoutLook linearVertical 
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: self constants exactPreviewHeight ])
]
