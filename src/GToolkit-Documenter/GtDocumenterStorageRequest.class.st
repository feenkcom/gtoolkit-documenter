Class {
	#name : #GtDocumenterStorageRequest,
	#superclass : #BrEditorRequest,
	#category : #'GToolkit-Documenter-! Editor - Events'
}

{ #category : #initialization }
GtDocumenterStorageRequest >> responseClass [
	^ GtDocumenterStorageChanged
]
