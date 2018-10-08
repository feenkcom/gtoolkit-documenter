Class {
	#name : #GtPillarSlimButtonLook,
	#superclass : #BrLook,
	#category : #'GToolkit-Documenter-Brick-Looks'
}

{ #category : #initialization }
GtPillarSlimButtonLook >> initializeLook [
	super initializeLook.
	self widgetDo: [ :anElement | 
		anElement padding: (BlInsets top: 1 right: 5 bottom: 1 left: 5).
		anElement margin: (BlInsets all: 2). ]
]
