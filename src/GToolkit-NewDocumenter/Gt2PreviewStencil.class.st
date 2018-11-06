Class {
	#name : #Gt2PreviewStencil,
	#superclass : #BrStencil,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#instVars : [
		'result',
		'showSelector'
	],
	#category : #'GToolkit-NewDocumenter-Brick - Stencils'
}

{ #category : #'api - instantiation' }
Gt2PreviewStencil >> create [
	<return: #BlElement>
	| aView |
	aView := GtPhlowView on: self result perform: self showSelector.
	^ aView asElementDo: [ :element |
		element 
			look: Gt2PreviewLook;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				"c vertical exact: 300" ] ]
]

{ #category : #initialization }
Gt2PreviewStencil >> initialize [
	super initialize.
	result := self.
	showSelector := self constants showDefaultValue.
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
