Class {
	#name : 'GtNoStorageStrategy',
	#superclass : 'GtStorageStrategy',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'GToolkit-Documenter-Storage'
}

{ #category : 'cleanup' }
GtNoStorageStrategy class >> cleanUp [
	^ self resetUniqueInstance
]

{ #category : 'cleanup' }
GtNoStorageStrategy class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : 'accessing' }
GtNoStorageStrategy class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'accessing' }
GtNoStorageStrategy >> basename [
	"Return a string representing the document filename"
	<return: #String>
	^ 'index.', GtFileUtilityConstants pillarExtension
]

{ #category : 'accessing' }
GtNoStorageStrategy >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution"
	<return: #Object>
	^ nil
]

{ #category : 'testing' }
GtNoStorageStrategy >> exists [
	<return: #Boolean>
	^ false
]

{ #category : 'accessing' }
GtNoStorageStrategy >> name [
	"Return a string representing the stored document"
	<return: #String>
	^ ''
]

{ #category : 'actions' }
GtNoStorageStrategy >> read: aGt2Document [ 
	"ignore"
]

{ #category : 'accessing' }
GtNoStorageStrategy >> rootDirectory [
	^ Smalltalk imageDirectory
]

{ #category : 'actions' }
GtNoStorageStrategy >> save: aGt2Document [ 
	"ignore"
]
