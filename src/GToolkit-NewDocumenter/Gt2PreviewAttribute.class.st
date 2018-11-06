Class {
	#name : #Gt2PreviewAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TBlDebug + TGt2DocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait',
	#instVars : [
		'result',
		'showSelector'
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
Gt2PreviewAttribute >> initialize [
	super initialize.
	result := self.
	showSelector := self constants showDefaultValue.
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
