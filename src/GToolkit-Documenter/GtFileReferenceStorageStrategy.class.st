Class {
	#name : #GtFileReferenceStorageStrategy,
	#superclass : #GtStorageStrategy,
	#instVars : [
		'file'
	],
	#category : 'GToolkit-Documenter-Storage'
}

{ #category : #accessing }
GtFileReferenceStorageStrategy >> basename [
	"Return a string representing the document filename"
	<return: #String>
	^ self name
]

{ #category : #accessing }
GtFileReferenceStorageStrategy >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution"
	<return: #Object>
	^ self file
]

{ #category : #testing }
GtFileReferenceStorageStrategy >> exists [
	<return: #Boolean>
	^ self file exists
]

{ #category : #accessing }
GtFileReferenceStorageStrategy >> file [
	^ file
]

{ #category : #accessing }
GtFileReferenceStorageStrategy >> file: aFileReference [
	file := aFileReference asFileReference
]

{ #category : #accessing }
GtFileReferenceStorageStrategy >> name [
	"Return a string representing the stored document"
	<return: #String>
	^ self file basename
]

{ #category : #actions }
GtFileReferenceStorageStrategy >> read: aGt2Document [ 
	self 
		assert: [ self file notNil ]
		description: [ 'File reference must be non-nil to read a document' ].
	self 
		assert: [ self file exists ]
		description: [ 'File reference must exists' ].
	aGt2Document text: self file contents
]

{ #category : #accessing }
GtFileReferenceStorageStrategy >> rootDirectory [
	self 
		assert: [ self file notNil ]
		description: [ 'File reference must be non-nil' ].
	^ self file parent
]

{ #category : #actions }
GtFileReferenceStorageStrategy >> save: aGt2Document [ 
	| aNewContent aBackupFile |
	self 
		assert: [ self file notNil ]
		description: [ 'File reference must be non-nil to store a document to a file' ].
	
	aNewContent := aGt2Document text asString.
	aBackupFile := (self file parent / (self file basename, '.backup')) asFileReference ensureDelete.
	self file 
		copyTo: aBackupFile;
		ensureDelete; 
		writeStreamDo: [ :s | s nextPutAll: aNewContent ] 
]
