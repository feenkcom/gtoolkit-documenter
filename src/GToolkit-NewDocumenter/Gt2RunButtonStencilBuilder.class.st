Class {
	#name : #Gt2RunButtonStencilBuilder,
	#superclass : #BrTextAdornmentStencilBuilder,
	#instVars : [
		'label',
		'document'
	],
	#category : #'GToolkit-NewDocumenter-Brick - Stencils'
}

{ #category : #'api - instantiation' }
Gt2RunButtonStencilBuilder >> buildDefault [
	^ Gt2RunButtonStencil new
		label: self label
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
]

{ #category : #accessing }
Gt2RunButtonStencilBuilder >> label [
	^ label
]

{ #category : #accessing }
Gt2RunButtonStencilBuilder >> label: anObject [
	label := anObject
]
