"
I create a play button

Example:

[[[
	(GtPillarPlayButtonStencil new
		icon: GtPillarPlayButtonIconStencil new;
		label: 'Play';
		action: [ self inform: 'Clicked' ]) asElement
]]]
"
Class {
	#name : #GtPillarPlayButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'action',
		'label',
		'iconStencilBuilder'
	],
	#category : #'GToolkit-Documenter-Brick-Stencils'
}

{ #category : #accessing }
GtPillarPlayButtonStencil >> action [
	^ action
]

{ #category : #accessing }
GtPillarPlayButtonStencil >> action: aValuable [
	action := aValuable
]

{ #category : #'api - instantiation' }
GtPillarPlayButtonStencil >> create [
	| aButton aLook |
	
	aLook := BrGlamorousButtonWithIconLook + GtPillarSlimButtonLook.

	aButton := BrButton new.
	aButton look: aLook.

	aButton icon: self icon.
	aButton label: self label.
	aButton action: self action.
	
	^ aButton
]

{ #category : #accessing }
GtPillarPlayButtonStencil >> icon [
	<return: #BlElement>

	^ iconStencilBuilder asElement
]

{ #category : #accessing }
GtPillarPlayButtonStencil >> icon: aStencilBuilder [
	iconStencilBuilder := aStencilBuilder asStencilBuilder
]

{ #category : #initialization }
GtPillarPlayButtonStencil >> initialize [
	super initialize.

	self icon: BrGlamorousIcons play.
	self label: 'Run'.
	self action: [ self inform: 'Executed' ]
]

{ #category : #accessing }
GtPillarPlayButtonStencil >> label [
	^ label
]

{ #category : #accessing }
GtPillarPlayButtonStencil >> label: aStringOrText [
	label := aStringOrText
]
