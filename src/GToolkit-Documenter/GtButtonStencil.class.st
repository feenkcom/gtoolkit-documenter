Class {
	#name : #GtButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'action',
		'label',
		'iconStencilBuilder'
	],
	#category : #'GToolkit-Documenter-Brick - Stencils'
}

{ #category : #accessing }
GtButtonStencil >> action [
	^ action
]

{ #category : #accessing }
GtButtonStencil >> action: aValuable [
	action := aValuable
]

{ #category : #'api - instantiation' }
GtButtonStencil >> create [
	| aLook |
	aLook := BrGlamorousButtonWithIconLook.
	self hasLabel ifTrue: [ 
		aLook := aLook + BrGlamorousButtonLabelLook ].

	^ BrButton new
		look: aLook;
		beSmall;
		icon: self icon;
		label: self label;
		action: self action
]

{ #category : #testing }
GtButtonStencil >> hasLabel [
	^ self label notNil and: [ self label isEmpty not ]
]

{ #category : #accessing }
GtButtonStencil >> icon [
	<return: #BlElement>

	^ iconStencilBuilder asElement
]

{ #category : #accessing }
GtButtonStencil >> icon: aStencilBuilder [
	iconStencilBuilder := aStencilBuilder asStencilBuilder
]

{ #category : #initialization }
GtButtonStencil >> initialize [
	super initialize.

	self icon: BrGlamorousIcons playinspect.
"	self label: 'Run'."
	self action: [ :aWidget :aButtonModel | self inform: 'Executed' ]
]

{ #category : #accessing }
GtButtonStencil >> label [
	^ label
]

{ #category : #accessing }
GtButtonStencil >> label: aStringOrText [
	label := aStringOrText
]
