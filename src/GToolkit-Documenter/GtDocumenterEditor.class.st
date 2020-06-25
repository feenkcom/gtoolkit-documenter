Class {
	#name : #GtDocumenterEditor,
	#superclass : #BrEditor,
	#instVars : [
		'normalFontSizeModel',
		'storageModel'
	],
	#category : #'GToolkit-Documenter-! Core'
}

{ #category : #'api - storage' }
GtDocumenterEditor >> classComment: aClass [
	storageModel classComment: aClass
]

{ #category : #defaults }
GtDocumenterEditor >> defaultParser [
	^ GtDocumenterParser new
]

{ #category : #defaults }
GtDocumenterEditor >> defaultStyler [
	^ GtDocumenterStyler new 
		document: self; 
		parser: self defaultParser;
		hideMarkup
]

{ #category : #'api - initialization' }
GtDocumenterEditor >> document: aGtDocumenter [
	self styler document: aGtDocumenter.
]

{ #category : #'api - storage' }
GtDocumenterEditor >> fileReference: aFileReference [ 
	storageModel fileReference: aFileReference
]

{ #category : #initialization }
GtDocumenterEditor >> initialize [
	super initialize.
	self viewModel add: (normalFontSizeModel := GtDocumenterEditorNormalFontSizeModel new).
	self viewModel add: (storageModel := GtDocumenterEditorStorageModel new).
	self styler: self defaultStyler.
]

{ #category : #accessing }
GtDocumenterEditor >> normalFontSize [
	<rerturn: #Number>
	^ normalFontSizeModel normalFontSize
]

{ #category : #accessing }
GtDocumenterEditor >> normalFontSize: aNumber [
	normalFontSizeModel normalFontSize: aNumber
]

{ #category : #'api - storage' }
GtDocumenterEditor >> storage [
	<return: #GtStorageStrategy>
	^ storageModel storage
]

{ #category : #'api - styling' }
GtDocumenterEditor >> styleTextRequest [
	self editor styleText
]
