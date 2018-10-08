Class {
	#name : #GtPillarToolbarLook,
	#superclass : #BrLook,
	#category : #'GToolkit-Documenter-Brick-Looks'
}

{ #category : #initialization }
GtPillarToolbarLook >> initializeLook [
	super initializeLook.
	self widgetDo: [ :anElement | 
		anElement padding: (BlInsets all: 2).
		anElement margin: (BlInsets all: 1). ]
]
