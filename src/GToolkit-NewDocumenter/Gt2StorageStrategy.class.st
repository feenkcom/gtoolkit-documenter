Class {
	#name : #Gt2StorageStrategy,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #factory }
Gt2StorageStrategy class >> classComment [
	^ Gt2ClassCommentStrategy new
]

{ #category : #factory }
Gt2StorageStrategy class >> classComment: aClass [
	^ self classComment classToComment: aClass
]

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

{ #category : #accessing }
Gt2StorageStrategy >> basename [
	"Return a string representing the document filename"
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #accessing }
Gt2StorageStrategy >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution"
	<return: #Object>
	^ self subclassResponsibility
]

{ #category : #testing }
Gt2StorageStrategy >> exists [
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #accessing }
Gt2StorageStrategy >> name [
	"Return a string representing the stored document"
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #actions }
Gt2StorageStrategy >> read: aGt2Document [ 
	self subclassResponsibility
]

{ #category : #accessing }
Gt2StorageStrategy >> rootDirectory [
	<return: #FileReference>
	^ self subclassResponsibility
]

{ #category : #actions }
Gt2StorageStrategy >> store: aGt2Document [ 
	self subclassResponsibility
]
