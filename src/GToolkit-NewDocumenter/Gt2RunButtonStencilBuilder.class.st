Class {
	#name : #Gt2RunButtonStencilBuilder,
	#superclass : #BrTextAdornmentStencilBuilder,
	#instVars : [
		'label',
		'document',
		'codeRope',
		'action'
	],
	#category : #'GToolkit-NewDocumenter-Brick - Stencils'
}

{ #category : #accessing }
Gt2RunButtonStencilBuilder >> action [
	^ action
]

{ #category : #accessing }
Gt2RunButtonStencilBuilder >> action: anObject [
	action := anObject
]

{ #category : #'api - instantiation' }
Gt2RunButtonStencilBuilder >> buildDefault [
	^ Gt2RunButtonStencil new
		label: self label;
		action: self action.
]

{ #category : #accessing }
Gt2RunButtonStencilBuilder >> document [
	^ document
]

{ #category : #accessing }
Gt2RunButtonStencilBuilder >> document: anObject [
	document := anObject
]

{ #category : #initialization }
Gt2RunButtonStencilBuilder >> initialize [
	super initialize.
	document := nil.
	label := nil.
	action := [ :aWidget :aButtonModel | self inform: 'Action!' ]
]

{ #category : #accessing }
Gt2RunButtonStencilBuilder >> label [
	^ label
]

{ #category : #accessing }
Gt2RunButtonStencilBuilder >> label: anObject [
	label := anObject
]
