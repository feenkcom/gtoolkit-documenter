Class {
	#name : 'GtSplitTextStencil',
	#superclass : 'BrStencil',
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#instVars : [
		'textParts',
		'leftStencil',
		'centerStencil',
		'rightStencil',
		'oneStencil',
		'theElements'
	],
	#category : 'GToolkit-Documenter-Brick - Stencils'
}

{ #category : 'api - instantiation' }
GtSplitTextStencil >> create [
	<return: #Collection of: #BlElement>

	self numberOfTextParts = 0 ifTrue: [ ^ self returnEmptyCollection ].
	self numberOfTextParts = 1 ifTrue: [ ^ self returnCollectionWithOneElement ].
	self numberOfTextParts = 2 ifTrue: [ ^ self returnCollectionWithTwoElements ].
	^ self returnCollectionWithMoreElements
]

{ #category : 'accessing - convenience' }
GtSplitTextStencil >> numberOfTextParts [
	<return: #Integer>
	^ self textParts size
]

{ #category : 'private - create' }
GtSplitTextStencil >> returnCollectionWithTwoElements [
	<return: #Collection of: #BlElement>
	self 
		assert: [ self numberOfTextParts = 2 ] 
		description: [ 'There must be exactly two text items' ].
	theElements := Array 
		with: (self leftStencil value: self textParts first)
		with: (self rightStencil value: self textParts second).
	self interConnectElements: theElements.
	^ theElements
]

{ #category : 'accessing' }
GtSplitTextStencil >> stringParts: aCollectionOfString [
	self 
		assert: [ aCollectionOfString isNotNil ] 
		description: [ 'Collection of string istances must be non-nil' ].
	self textParts: (aCollectionOfString collect: #asRopedText)
]

{ #category : 'accessing' }
GtSplitTextStencil >> textParts [
	<return: #Collection of: #BlText>
	^ textParts
]

{ #category : 'accessing' }
GtSplitTextStencil >> textParts: aCollectionOfBlText [
	self 
		assert: [ aCollectionOfBlText isNotNil ] 
		description: [ 'Collection of text istances must be non-nil' ].
	textParts := aCollectionOfBlText
]
