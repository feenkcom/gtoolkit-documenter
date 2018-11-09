Class {
	#name : #Gt2FileReferenceStorageStrategy,
	#superclass : #Gt2StorageStrategy,
	#instVars : [
		'file'
	],
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #accessing }
Gt2FileReferenceStorageStrategy >> file [
	^ file
]

{ #category : #accessing }
Gt2FileReferenceStorageStrategy >> file: aFileReference [
	file := aFileReference
]
