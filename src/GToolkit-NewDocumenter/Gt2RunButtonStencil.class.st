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
	| aButton aLook |
	
	aLook := BrGlamorousButtonWithIconLook "+ BrGlamorousButtonLabelLook".

	aButton := BrButton new.
	aButton look: aLook.

	aButton icon: self icon.
	aButton label: self label.
	aButton action: self action.
	
	^ aButton
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
	self action: [ self inform: 'Executed' ]
]

{ #category : #accessing }
Gt2RunButtonStencil >> label [
	^ label
]

{ #category : #accessing }
Gt2RunButtonStencil >> label: aStringOrText [
	label := aStringOrText
]
