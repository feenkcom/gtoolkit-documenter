Class {
	#name : #Gt2RunButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'action',
		'label',
		'iconStencilBuilder'
	],
	#category : #'GToolkit-NewDocumenter-Brick - Stencils'
}

{ #category : #accessing }
Gt2RunButtonStencil >> action [
	^ action
]

{ #category : #accessing }
Gt2RunButtonStencil >> action: aValuable [
	action := aValuable
]

{ #category : #'api - instantiation' }
Gt2RunButtonStencil >> create [
	| aLook |
	aLook := BrGlamorousButtonWithIconLook.
	self hasLabel ifTrue: [ 
		aLook := aLook + BrGlamorousButtonLabelLook ].

	^ BrButton new
		look: aLook;
		beSmall;
		icon: self icon;
		label: self label;
		action: self action.
]

{ #category : #testing }
Gt2RunButtonStencil >> hasLabel [
	^ self label notNil and: [ self label isEmpty not ]
]

{ #category : #accessing }
Gt2RunButtonStencil >> icon [
	<return: #BlElement>

	^ iconStencilBuilder asElement
]

{ #category : #accessing }
Gt2RunButtonStencil >> icon: aStencilBuilder [
	iconStencilBuilder := aStencilBuilder asStencilBuilder
]

{ #category : #initialization }
Gt2RunButtonStencil >> initialize [
	super initialize.

	self icon: BrGlamorousIcons play.
	self label: 'Run'.
	self action: [ :aWidget :aButtonModel | self inform: 'Executed' ]
]

{ #category : #accessing }
Gt2RunButtonStencil >> label [
	^ label
]

{ #category : #accessing }
Gt2RunButtonStencil >> label: aStringOrText [
	label := aStringOrText
]
