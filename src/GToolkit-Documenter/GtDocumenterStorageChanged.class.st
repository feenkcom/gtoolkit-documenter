Class {
	#name : #GtDocumenterStorageChanged,
	#superclass : #BrEditorChangedEvent,
	#instVars : [
		'storage'
	],
	#category : #'GToolkit-Documenter-! Core'
}

{ #category : #accessing }
GtDocumenterStorageChanged >> storage [
	^ storage
]

{ #category : #accessing }
GtDocumenterStorageChanged >> storage: anObject [
	storage := anObject
]
