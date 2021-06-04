"
I inform about {{gtClass:GtStorageStrategy}} changes in {{gtClass:GtDocumenterEditor}}.


"
Class {
	#name : #GtDocumenterStorageChanged,
	#superclass : #BrEditorChangedEvent,
	#instVars : [
		'storage'
	],
	#category : #'GToolkit-Documenter-! Editor - Events'
}

{ #category : #accessing }
GtDocumenterStorageChanged >> storage [
	^ storage
]

{ #category : #accessing }
GtDocumenterStorageChanged >> storage: anObject [
	storage := anObject
]
