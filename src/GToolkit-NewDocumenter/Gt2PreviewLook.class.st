Class {
	#name : #Gt2PreviewLook,
	#superclass : #BrLook,
	#category : #'GToolkit-NewDocumenter-Brick - Looks'
}

{ #category : #initialization }
Gt2PreviewLook >> initialize [
	super initialize.

	self add: BrShadowLook new
]

{ #category : #initialization }
Gt2PreviewLook >> initializeLook [
	super initializeLook.
	self widget 
		constraintsDo: [ :c |
			c textFlow pushLine.
			c margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20) ];
		background: Color white
]
