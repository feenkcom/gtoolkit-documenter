Class {
	#name : #GtFlexibleHorizontalSpaceLook,
	#superclass : #BrLook,
	#category : #'GToolkit-Documenter-Brick-Looks'
}

{ #category : #initialization }
GtFlexibleHorizontalSpaceLook >> initializeLook [
	super initializeLook.
	self widgetDo: [ :anElement | 
		anElement constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 1 ]. ]
]
