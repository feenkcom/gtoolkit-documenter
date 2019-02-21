Class {
	#name : #GtPreviewAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#instVars : [
		'result',
		'showSelector',
		'height'
	],
	#category : #'GToolkit-Documenter-Text - Attributes'
}

{ #category : #accessing }
GtPreviewAttribute class >> constants [
	^ GtDocumentConstants
]

{ #category : #accessing }
GtPreviewAttribute >> affect: aBrText in: anEditorElement [
	^ GtPreviewStencil new
		result: self result;
		showSelector: self showSelector;
		asElement
]

{ #category : #accessing }
GtPreviewAttribute >> constants [
	^ GtDocumentConstants
]

{ #category : #initialization }
GtPreviewAttribute >> defaultHeight [
	^ self constants defaultPreviewHeight
]

{ #category : #accessing }
GtPreviewAttribute >> height [
	<return: #Number or: nil>
	^ height
]

{ #category : #accessing }
GtPreviewAttribute >> height: anInteger [
	self 
		assert: [ anInteger notNil ] 
		description: [ 'Height value must be non-nil' ].
	self 
		assert: [ anInteger > 0 ] 
		description: [ 'Height value must be a pozitive number' ].
	height := anInteger
]

{ #category : #initialization }
GtPreviewAttribute >> initialize [
	super initialize.
	
	self beAppend.
	result := self.
	showSelector := self constants defaultShowSelector.
	height := self defaultHeight.
]

{ #category : #accessing }
GtPreviewAttribute >> result [
	^ result
]

{ #category : #accessing }
GtPreviewAttribute >> result: anObject [
	result := anObject
]

{ #category : #accessing }
GtPreviewAttribute >> showSelector [
	^ showSelector
]

{ #category : #accessing }
GtPreviewAttribute >> showSelector: aSymbol [
	self 
		assert: [ aSymbol notNil ] 
		description: [ 'Show selector name must be non-nil' ].
	self 
		assert: [ aSymbol isSymbol ] 
		description: [ 'Show selector name must be a symbol' ].
	showSelector := aSymbol
]
