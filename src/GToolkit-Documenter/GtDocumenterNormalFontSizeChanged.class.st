Class {
	#name : #GtDocumenterNormalFontSizeChanged,
	#superclass : #BrEditorChangedEvent,
	#instVars : [
		'normalFontSize'
	],
	#category : #'GToolkit-Documenter-! Core'
}

{ #category : #accessing }
GtDocumenterNormalFontSizeChanged >> normalFontSize [
	^ normalFontSize
]

{ #category : #accessing }
GtDocumenterNormalFontSizeChanged >> normalFontSize: anObject [
	normalFontSize := anObject
]
