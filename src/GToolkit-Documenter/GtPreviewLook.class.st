Class {
	#name : #GtPreviewLook,
	#superclass : #BrLook,
	#category : #'GToolkit-Documenter-Brick - Looks'
}

{ #category : #initialization }
GtPreviewLook >> initialize [
	super initialize.

	self add: BrShadowLook new
]

{ #category : #initialization }
GtPreviewLook >> initializeLook [
	super initializeLook.
	self widget 
		constraintsDo: [ :c |
			c textFlow pushLine.
			c margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20) ];
		background: Color white
]
