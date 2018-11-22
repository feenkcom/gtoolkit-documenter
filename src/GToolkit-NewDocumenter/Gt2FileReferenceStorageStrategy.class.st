Class {
	#name : #Gt2FileReferenceStorageStrategy,
	#superclass : #Gt2StorageStrategy,
	#instVars : [
		'file'
	],
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #accessing }
Gt2FileReferenceStorageStrategy >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution"
	<return: #Object>
	^ self file
]

{ #category : #testing }
Gt2FileReferenceStorageStrategy >> exists [
	<return: #Boolean>
	^ self file exists
]

{ #category : #accessing }
Gt2FileReferenceStorageStrategy >> file [
	^ file
]

{ #category : #accessing }
Gt2FileReferenceStorageStrategy >> file: aFileReference [
	file := aFileReference asFileReference
]

{ #category : #accessing }
Gt2FileReferenceStorageStrategy >> name [
	"Return a string representing the stored document"
	<return: #String>
	^ self file basename
]

{ #category : #actions }
Gt2FileReferenceStorageStrategy >> read: aGt2Document [ 
	self 
		assert: [ self file notNil ]
		description: [ 'File reference must be non-nil to read a document' ].
	self 
		assert: [ self file exists ]
		description: [ 'File reference must exists' ].
	aGt2Document text: self file contents
]

{ #category : #accessing }
Gt2FileReferenceStorageStrategy >> rootDirectory [
	self 
		assert: [ self file notNil ]
		description: [ 'File reference must be non-nil' ].
	^ self file parent
]

{ #category : #actions }
Gt2FileReferenceStorageStrategy >> store: aGt2Document [ 
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
