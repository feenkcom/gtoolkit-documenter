"
I request a current ${class:GtStorageStrategy}$ for ${class:GtDocumenterEditor}$.

"
Class {
	#name : #GtDocumenterStorageRequest,
	#superclass : #BrEditorRequest,
	#category : #'GToolkit-Documenter-! Editor - Events'
}

{ #category : #initialization }
GtDocumenterStorageRequest >> responseClass [
	^ GtDocumenterStorageChanged
]
