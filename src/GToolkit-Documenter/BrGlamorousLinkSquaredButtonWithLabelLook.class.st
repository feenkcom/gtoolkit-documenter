Class {
	#name : #BrGlamorousLinkSquaredButtonWithLabelLook,
	#superclass : #BrLook,
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'labelLook'
	],
	#category : #'GToolkit-Documenter-Brick - Looks'
}

{ #category : #accessing }
BrGlamorousLinkSquaredButtonWithLabelLook >> attributesBuilder [
	<return: #BlTextAttributesBuilder>
	
	^ labelLook attributesBuilder
]

{ #category : #'api - text font' }
BrGlamorousLinkSquaredButtonWithLabelLook >> fontSize: aNumber [
	labelLook fontSize: aNumber
]

{ #category : #initialization }
BrGlamorousLinkSquaredButtonWithLabelLook >> initialize [
	super initialize.
	
	self addAll: {
		labelLook := BrGlamorousLinkButtonLabelLook new
			labelDo: [ :aLabelElement |
				aLabelElement padding: (BlInsets all: 0) ].
		BrGlamorousLinkButtonExteriorInnerLook new.
	}
]
