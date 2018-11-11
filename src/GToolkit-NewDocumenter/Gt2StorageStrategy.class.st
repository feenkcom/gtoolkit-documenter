Class {
	#name : #Gt2StorageStrategy,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #factory }
Gt2StorageStrategy class >> fileReference [
	^ Gt2FileReferenceStorageStrategy new
]

{ #category : #factory }
Gt2StorageStrategy class >> fileReference: aFileReference [
	^ self fileReference file: aFileReference
]

{ #category : #factory }
Gt2StorageStrategy class >> null [
	^ Gt2NoStorageStrategy uniqueInstance
]

{ #category : #actions }
Gt2StorageStrategy >> read: aGt2Document [ 
	self subclassResponsibility
]

{ #category : #accessing }
Gt2StorageStrategy >> rootDirectory [
	self 
		assert: [ self file notNil ]
		description: [ 'File reference must be non-nil' ].
	^ self file parent
]

{ #category : #actions }
Gt2StorageStrategy >> store: aGt2Document [ 
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
