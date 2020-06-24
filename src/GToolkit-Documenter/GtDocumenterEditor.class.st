Class {
	#name : #GtDocumenterEditor,
	#superclass : #BrEditor,
	#instVars : [
		'normalFontSizeModel'
	],
	#category : #'GToolkit-Documenter-! Core'
}

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

{ #category : #initialization }
GtDocumenterEditor >> initialize [
	super initialize.
	self viewModel add: (normalFontSizeModel := GtDocumenterEditorNormalFontSizeModel new).
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

{ #category : #'api - styling' }
GtDocumenterEditor >> styleTextRequest [
	self editor styleText
]
