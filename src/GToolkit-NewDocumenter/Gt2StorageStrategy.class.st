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
	"Return root directory to access external data, e.g., images, change files"
	<return: #FileReference>
	^ self subclassResponsibility 
]

{ #category : #actions }
Gt2StorageStrategy >> store: aGt2Document [ 
	self subclassResponsibility
]
