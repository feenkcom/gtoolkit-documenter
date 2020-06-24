Class {
	#name : #GtDocumenterNormalFontSizeRequest,
	#superclass : #BrEditorRequest,
	#category : #'GToolkit-Documenter-! Core'
}

{ #category : #initialization }
GtDocumenterNormalFontSizeRequest >> responseClass [
	^ GtDocumenterNormalFontSizeChanged
]
