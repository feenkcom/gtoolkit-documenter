Class {
	#name : #Gt2ButtonStencilBuilder,
	#superclass : #BrTextAdornmentStencilBuilder,
	#instVars : [
		'label',
		'icon',
		'action'
	],
	#category : #'GToolkit-NewDocumenter-Brick - Stencils'
}

{ #category : #accessing }
Gt2ButtonStencilBuilder >> action [
	^ action
]

{ #category : #accessing }
Gt2ButtonStencilBuilder >> action: anObject [
	action := anObject
]

{ #category : #'api - instantiation' }
Gt2ButtonStencilBuilder >> buildDefault [
	^ Gt2RunButtonStencil new
		label: self label;
		icon: self icon;
		action: self action
]

{ #category : #accessing }
Gt2ButtonStencilBuilder >> icon [
	^ icon
]

{ #category : #accessing }
Gt2ButtonStencilBuilder >> icon: anObject [
	icon := anObject
]

{ #category : #initialization }
Gt2ButtonStencilBuilder >> initialize [
	super initialize.
	label := 'Button'.
	icon := BrGlamorousIcons play.
	action := [ :aWidget :aButtonModel | self inform: 'Action!' ]
]

{ #category : #accessing }
Gt2ButtonStencilBuilder >> label [
	^ label
]

{ #category : #accessing }
Gt2ButtonStencilBuilder >> label: anObject [
	label := anObject
]
