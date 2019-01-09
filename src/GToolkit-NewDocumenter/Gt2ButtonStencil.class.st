Class {
	#name : #Gt2ButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'action',
		'label',
		'iconStencilBuilder'
	],
	#category : #'GToolkit-NewDocumenter-Brick - Stencils'
}

{ #category : #accessing }
Gt2ButtonStencil >> action [
	^ action
]

{ #category : #accessing }
Gt2ButtonStencil >> action: aValuable [
	action := aValuable
]

{ #category : #'api - instantiation' }
Gt2ButtonStencil >> create [
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
Gt2ButtonStencil >> hasLabel [
	^ self label notNil and: [ self label isEmpty not ]
]

{ #category : #accessing }
Gt2ButtonStencil >> icon [
	<return: #BlElement>

	^ iconStencilBuilder asElement
]

{ #category : #accessing }
Gt2ButtonStencil >> icon: aStencilBuilder [
	iconStencilBuilder := aStencilBuilder asStencilBuilder
]

{ #category : #initialization }
Gt2ButtonStencil >> initialize [
	super initialize.

	self icon: BrGlamorousIcons playinspect.
"	self label: 'Run'."
	self action: [ :aWidget :aButtonModel | self inform: 'Executed' ]
]

{ #category : #accessing }
Gt2ButtonStencil >> label [
	^ label
]

{ #category : #accessing }
Gt2ButtonStencil >> label: aStringOrText [
	label := aStringOrText
]
