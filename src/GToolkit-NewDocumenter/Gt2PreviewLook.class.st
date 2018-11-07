Class {
	#name : #Gt2PreviewLook,
	#superclass : #BrLook,
	#category : #'GToolkit-NewDocumenter-Brick - Looks'
}

{ #category : #initialization }
Gt2PreviewLook >> initializeLook [
	super initializeLook.
	self widget 
		constraintsDo: [ :c |
			c textFlow pushLine.
			c padding: (BlInsets all: 0).
			c margin: (BlInsets all: 10) ];
		background: Color white;
		outskirts: BlOutskirts outside;
		border: (BlBorder paint: Color veryLightGray width: 1)
]
