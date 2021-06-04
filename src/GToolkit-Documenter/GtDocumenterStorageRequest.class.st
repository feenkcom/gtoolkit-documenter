"
I request a current {{gtClass:GtStorageStrategy}} for {{gtClass:GtDocumenterEditor}}.


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
