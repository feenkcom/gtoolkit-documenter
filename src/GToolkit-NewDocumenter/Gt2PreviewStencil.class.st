Class {
	#name : #Gt2PreviewStencil,
	#superclass : #BrStencil,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#instVars : [
		'result',
		'showSelector',
		'height'
	],
	#category : #'GToolkit-NewDocumenter-Brick - Stencils'
}

{ #category : #'api - instantiation' }
Gt2PreviewStencil >> create [
	<return: #BlElement>
	| aView |
	aView := GtPhlowView empty on: self result perform: self showSelector.
	^ aView asElementDo:
		[ :anElement | self newContainerFor: anElement ]
]

{ #category : #'instance creation' }
Gt2PreviewStencil >> defaultHeight [
	^ self constants defaultPreviewHeight
]

{ #category : #accessing }
Gt2PreviewStencil >> height [
	<return: #Number or: nil>
	^ height
]

{ #category : #accessing }
Gt2PreviewStencil >> height: anInteger [
	self 
		assert: [ anInteger notNil ] 
		description: [ 'Height value must be non-nil' ].
	self 
		assert: [ anInteger > 0 ] 
		description: [ 'Height value must be a pozitive number' ].
	height := anInteger
]

{ #category : #initialization }
Gt2PreviewStencil >> initialize [
	super initialize.

	result := self class.
	showSelector := self constants defaultShowSelector.
	height := self defaultHeight.
]

{ #category : #'instance creation' }
Gt2PreviewStencil >> newContainerFor: anElement [
	^ BlElement new
		addChild: anElement;
		layout: BlLinearLayout new;
		look: Gt2PreviewLook + BrShadowLook;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: self height ]
]

{ #category : #accessing }
Gt2PreviewStencil >> result [
	^ result
]

{ #category : #accessing }
Gt2PreviewStencil >> result: anObject [
	result := anObject
]

{ #category : #accessing }
Gt2PreviewStencil >> showSelector [
	^ showSelector
]

{ #category : #accessing }
Gt2PreviewStencil >> showSelector: aSymbol [
	self 
		assert: [ aSymbol notNil ] 
		description: [ 'Show selector name must be non-nil' ].
	self 
		assert: [ aSymbol isSymbol ] 
		description: [ 'Show selector name must be a symbol' ].
	showSelector := aSymbol
]
