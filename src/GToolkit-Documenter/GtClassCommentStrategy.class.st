Class {
	#name : #GtClassCommentStrategy,
	#superclass : #GtStorageStrategy,
	#instVars : [
		'classRingDefinition'
	],
	#category : #'GToolkit-Documenter-Storage'
}

{ #category : #accessing }
GtClassCommentStrategy >> basename [
	"Return a string representing the document filename"
	<return: #String>
	^ self name, '.', GtFileUtilityConstants pillarExtension
]

{ #category : #accessing }
GtClassCommentStrategy >> classToComment [
	^ classRingDefinition
]

{ #category : #accessing }
GtClassCommentStrategy >> classToComment: aClass [
	self 
		assert: [ aClass notNil ]
		description: [ 'Class to document must be non-nil' ].
	classRingDefinition := aClass instanceSide asRingDefinition
]

{ #category : #accessing }
GtClassCommentStrategy >> comment [
	<return: #String>
	self classToComment isDefined ifTrue: [ ^ self realClassComment ].
	self classToComment hasComment ifFalse: [ ^ '' ].
	^ self classToComment comment content asString
]

{ #category : #accessing }
GtClassCommentStrategy >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution"
	<return: #Object>
	^ self classToComment isDefined 
		ifTrue: [ self classToComment realClass ]
		ifFalse: [ self classToComment ]
]

{ #category : #testing }
GtClassCommentStrategy >> exists [
	<return: #Boolean>
	^ self classToComment isDefined
]

{ #category : #accessing }
GtClassCommentStrategy >> name [
	"Return a string representing the stored document"
	<return: #String>
	^ self classToComment name
]

{ #category : #actions }
GtClassCommentStrategy >> read: aGt2Document [ 
	self 
		assert: [ self classToComment notNil ]
		description: [ 'Class to document must be non-nil to read it' ].
	self 
		assert: [ self classToComment isDefined ]
		description: [ 'Class to document must exist in the system' ].
	aGt2Document text: self comment
]

{ #category : #accessing }
GtClassCommentStrategy >> realClassComment [
	<return: #String>
	| aClass |
	aClass := self classToComment realClass.
	aClass hasComment ifFalse: [ ^ '' ].
	^ aClass comment.
]

{ #category : #accessing }
GtClassCommentStrategy >> rootDirectory [
	<return: #FileReference>
	^ FileSystem workingDirectory
]

{ #category : #actions }
GtClassCommentStrategy >> save: aGt2Document [ 
	self 
		assert: [ self classToComment notNil ]
		description: [ 'Class to document must be non-nil to store a comment there' ].
	self 
		assert: [ self classToComment isDefined ]
		description: [ 'Class to document must exist in the system to store a comment there' ].
	self classToComment realClass comment: aGt2Document text asString
	
]
