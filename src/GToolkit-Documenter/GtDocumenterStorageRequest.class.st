Class {
	#name : #GtDocumenterStorageRequest,
	#superclass : #BrEditorRequest,
	#category : #'GToolkit-Documenter-! Core'
}

{ #category : #initialization }
GtDocumenterStorageRequest >> responseClass [
	^ GtDocumenterStorageChanged
]
