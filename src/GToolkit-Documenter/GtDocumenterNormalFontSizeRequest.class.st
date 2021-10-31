"
I request a normal font size for ${class:GtDocumenterEditor}$.

"
Class {
	#name : #GtDocumenterNormalFontSizeRequest,
	#superclass : #BrEditorRequest,
	#category : 'GToolkit-Documenter-! Editor - Events'
}

{ #category : #initialization }
GtDocumenterNormalFontSizeRequest >> responseClass [
	^ GtDocumenterNormalFontSizeChanged
]
