Class {
	#name : #GtDocumenterNormalFontSizeRequest,
	#superclass : #BrEditorRequest,
	#category : #'GToolkit-Documenter-! Editor - Events'
}

{ #category : #initialization }
GtDocumenterNormalFontSizeRequest >> responseClass [
	^ GtDocumenterNormalFontSizeChanged
]
