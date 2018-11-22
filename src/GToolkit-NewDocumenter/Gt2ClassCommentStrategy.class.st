Class {
	#name : #Gt2ClassCommentStrategy,
	#superclass : #Gt2StorageStrategy,
	#instVars : [
		'classRingDefinition'
	],
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #accessing }
Gt2ClassCommentStrategy >> classToComment [
	^ classRingDefinition
]

{ #category : #accessing }
Gt2ClassCommentStrategy >> classToComment: aClass [
	self 
		assert: [ aClass notNil ]
		description: [ 'Class to document must be non-nil' ].
	classRingDefinition := aClass asRingDefinition
]

{ #category : #accessing }
Gt2ClassCommentStrategy >> comment [
	<return: #String>
	^ self classToComment isDefined 
		ifTrue: [ self classToComment realClass comment ]
		ifFalse: [ self classToComment hasComment
			ifTrue: [ self classToComment comment content ]
			ifFalse: [ '' ] ]
]

{ #category : #accessing }
Gt2ClassCommentStrategy >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution"
	<return: #Object>
	^ self classToComment isDefined 
		ifTrue: [ self classToComment realClass ]
		ifFalse: [ self classToComment ]
]

{ #category : #testing }
Gt2ClassCommentStrategy >> exists [
	<return: #Boolean>
	^ self classToComment isDefined
]

{ #category : #accessing }
Gt2ClassCommentStrategy >> name [
	"Return a string representing the stored document"
	<return: #String>
	^ self classToComment name
]

{ #category : #actions }
Gt2ClassCommentStrategy >> read: aGt2Document [ 
	self 
		assert: [ self classToComment notNil ]
		description: [ 'Class to document must be non-nil to read it' ].
	self 
		assert: [ self classToComment isDefined ]
		description: [ 'Class to document must exist in the system' ].
	aGt2Document text: self comment
]

{ #category : #accessing }
Gt2ClassCommentStrategy >> rootDirectory [
	<return: #FileReference>
	^ FileSystem workingDirectory
]

{ #category : #actions }
Gt2ClassCommentStrategy >> store: aGt2Document [ 
	| aNewContent aBackupFile |
	self 
		assert: [ self classToComment notNil ]
		description: [ 'Class to document must be non-nil to store a comment there' ].
	self 
		assert: [ self classToComment isDefined ]
		description: [ 'Class to document must exist in the system to store a comment there' ].
	self classToComment realClass comment: aGt2Document text asString
	
]
