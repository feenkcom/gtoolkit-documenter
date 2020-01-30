Class {
	#name : #BrGlamorousLinkSquaredButtonWithLabelLook,
	#superclass : #BrLook,
	#category : #'GToolkit-Documenter-Brick - Looks'
}

{ #category : #initialization }
BrGlamorousLinkSquaredButtonWithLabelLook >> initialize [
	super initialize.
	
	self addAll: {
		BrGlamorousLinkButtonLabelLook new
			labelDo: [ :aLabelElement |
				aLabelElement padding: (BlInsets all: 0) ].
		BrGlamorousLinkButtonExteriorInnerLook new.
	}
]
