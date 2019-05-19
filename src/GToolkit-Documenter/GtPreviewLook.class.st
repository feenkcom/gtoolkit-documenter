Class {
	#name : #GtPreviewLook,
	#superclass : #BrLook,
	#category : #'GToolkit-Documenter-Brick - Looks'
}

{ #category : #initialization }
GtPreviewLook >> initialize [
	super initialize.
	self add: BrShadowLook new.
	changes
		add:
			(#(widget background)
				asBrLookPropertyChangeWithValue: [ Color white asBlBackground ]).
	changes
		add:
			(#(widget margin)
				asBrLookPropertyChangeWithValue: [ BlInsets
						top: 5
						left: 20
						bottom: 5
						right: 20 ]).
	changes
		add:
			(BrLookChange new
				up: [ :e | self widget constraintsDo: [ :c | c textFlow pushLine ] ];
				down: [ :e |  ];
				yourself)
]
