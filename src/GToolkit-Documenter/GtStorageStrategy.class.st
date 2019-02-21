Class {
	#name : #GtStorageStrategy,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Documenter-Model'
}

{ #category : #factory }
GtStorageStrategy class >> classComment [
	^ GtClassCommentStrategy new
]

{ #category : #factory }
GtStorageStrategy class >> classComment: aClass [
	^ self classComment classToComment: aClass
]

{ #category : #factory }
GtStorageStrategy class >> fileReference [
	^ GtFileReferenceStorageStrategy new
]

{ #category : #factory }
GtStorageStrategy class >> fileReference: aFileReference [
	^ self fileReference file: aFileReference
]

{ #category : #factory }
GtStorageStrategy class >> null [
	^ GtNoStorageStrategy uniqueInstance
]

{ #category : #accessing }
GtStorageStrategy >> basename [
	"Return a string representing the document filename"
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtStorageStrategy >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution"
	<return: #Object>
	^ self subclassResponsibility
]

{ #category : #testing }
GtStorageStrategy >> exists [
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtStorageStrategy >> name [
	"Return a string representing the stored document"
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #actions }
GtStorageStrategy >> read: aGt2Document [ 
	self subclassResponsibility
]

{ #category : #accessing }
GtStorageStrategy >> rootDirectory [
	<return: #FileReference>
	^ self subclassResponsibility
]

{ #category : #actions }
GtStorageStrategy >> store: aGt2Document [ 
	self subclassResponsibility
]
