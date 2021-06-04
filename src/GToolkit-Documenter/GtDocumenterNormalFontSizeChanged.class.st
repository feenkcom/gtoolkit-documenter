"
I inform about normal font size changes in ${class:GtDocumenterEditor}$.

"
Class {
	#name : #GtDocumenterNormalFontSizeChanged,
	#superclass : #BrEditorChangedEvent,
	#instVars : [
		'normalFontSize'
	],
	#category : #'GToolkit-Documenter-! Editor - Events'
}

{ #category : #accessing }
GtDocumenterNormalFontSizeChanged >> normalFontSize [
	^ normalFontSize
]

{ #category : #accessing }
GtDocumenterNormalFontSizeChanged >> normalFontSize: anObject [
	normalFontSize := anObject
]
