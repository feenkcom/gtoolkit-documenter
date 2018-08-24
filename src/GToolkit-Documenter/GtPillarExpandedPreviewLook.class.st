Class {
	#name : #GtPillarExpandedPreviewLook,
	#superclass : #BrLook,
	#category : 'GToolkit-Documenter-Brick-Looks'
}

{ #category : #initialization }
GtPillarExpandedPreviewLook >> initializeLook [
	super initializeLook.
	self widget 
		constraintsDo: [ :c |
			c textFlow pushLine.
			c padding: (BlInsets all: 5).
			c margin: (BlInsets all: 10) ];
		background: Color white;
		outskirts: BlOutskirts outside;
		border: (BlBorder paint: Color veryLightGray width: 1)";
		effect: (BlDropShadowEffect color: (Color gray alpha: 0.5) width: 10 offset: 5@5)."
]
