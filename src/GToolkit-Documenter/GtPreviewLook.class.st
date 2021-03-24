Class {
	#name : #GtPreviewLook,
	#superclass : #BrAptitude,
	#category : #'GToolkit-Documenter-Brick - Looks'
}

{ #category : #initialization }
GtPreviewLook >> initialize [
	super initialize.
	self add: BrShadowLook new.
	self
		addChangeProperty: #(widget background)
		with: [ Color white asBlBackground ].
	self
		addChangeProperty: #(widget margin)
		with: [ BlInsets
				top: 5
				left: 5
				bottom: 5
				right: 5 ].
	self
		addChange:
			(BrLookChange new
				up: [ :e | self widget constraintsDo: [ :c | c textFlow pushLine ] ];
				down: [ :e |  ];
				yourself)
]
