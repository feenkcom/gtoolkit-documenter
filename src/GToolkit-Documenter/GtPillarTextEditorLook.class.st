Class {
	#name : #GtPillarTextEditorLook,
	#superclass : #BrLook,
	#category : 'GToolkit-Documenter-Brick-Looks'
}

{ #category : #initialization }
GtPillarTextEditorLook >> initialize [
	super initialize.
	self add: (BrLayoutLook constraintsDo: [ :c | 
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical fitContent ]).
]

{ #category : #initialization }
GtPillarTextEditorLook >> initializeLook [
	super initializeLook.
	self widgetDo: [ :anElement | 
		anElement background: Color white.
		anElement padding: (BlInsets all: 2).
		"anElement border: (BlBorder paint: Color veryLightGray width: 1)" ]
]
