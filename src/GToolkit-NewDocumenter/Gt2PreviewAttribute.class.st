Class {
	#name : #Gt2PreviewAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TBlDebug + TGt2DocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait',
	#instVars : [
		'result',
		'showSelector',
		'height'
	],
	#category : #'GToolkit-NewDocumenter-Text - Attributes'
}

{ #category : #accessing }
Gt2PreviewAttribute >> affect: aBrText in: anEditorElement [
	^ Gt2PreviewStencil new
		result: self result;
		showSelector: self showSelector;
		asElement
]

{ #category : #initialization }
Gt2PreviewAttribute >> defaultHeight [
	^ self constants defaultPreviewHeight
]

{ #category : #accessing }
Gt2PreviewAttribute >> height [
	<return: #Number or: nil>
	^ height
]

{ #category : #accessing }
Gt2PreviewAttribute >> height: anInteger [
	self 
		assert: [ anInteger notNil ] 
		description: [ 'Height value must be non-nil' ].
	self 
		assert: [ anInteger > 0 ] 
		description: [ 'Height value must be a pozitive number' ].
	height := anInteger
]

{ #category : #initialization }
Gt2PreviewAttribute >> initialize [
	super initialize.
	
	self beAppend.
	result := self.
	showSelector := self constants showDefaultValue.
	height := self defaultHeight.
]

{ #category : #accessing }
Gt2PreviewAttribute >> result [
	^ result
]

{ #category : #accessing }
Gt2PreviewAttribute >> result: anObject [
	result := anObject
]

{ #category : #accessing }
Gt2PreviewAttribute >> showSelector [
	^ showSelector
]

{ #category : #accessing }
Gt2PreviewAttribute >> showSelector: aSymbol [
	self 
		assert: [ aSymbol notNil ] 
		description: [ 'Show selector name must be non-nil' ].
	self 
		assert: [ aSymbol isSymbol ] 
		description: [ 'Show selector name must be a symbol' ].
	showSelector := aSymbol
]
