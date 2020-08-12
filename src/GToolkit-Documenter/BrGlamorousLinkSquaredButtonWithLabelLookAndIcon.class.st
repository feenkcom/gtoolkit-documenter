Class {
	#name : #BrGlamorousLinkSquaredButtonWithLabelLookAndIcon,
	#superclass : #BrGlamorousLinkSquaredButtonWithLabelLook,
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#category : #'GToolkit-Documenter-Brick - Looks'
}

{ #category : #initialization }
BrGlamorousLinkSquaredButtonWithLabelLookAndIcon >> initialize [

	super initialize.
	self addAll: { BrGlamorousButtonIconLook new. }.
]
