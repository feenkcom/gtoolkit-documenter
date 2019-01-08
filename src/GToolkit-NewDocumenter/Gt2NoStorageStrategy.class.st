Class {
	#name : #Gt2NoStorageStrategy,
	#superclass : #Gt2StorageStrategy,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #cleanup }
Gt2NoStorageStrategy class >> cleanUp [
	^ self resetUniqueInstance
]

{ #category : #cleanup }
Gt2NoStorageStrategy class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
Gt2NoStorageStrategy class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
Gt2NoStorageStrategy >> basename [
	"Return a string representing the document filename"
	<return: #String>
	^ 'index.', GtFileUtilityConstants pillarExtension
]

{ #category : #accessing }
Gt2NoStorageStrategy >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution"
	<return: #Object>
	^ nil
]

{ #category : #testing }
Gt2NoStorageStrategy >> exists [
	<return: #Boolean>
	^ false
]

{ #category : #accessing }
Gt2NoStorageStrategy >> name [
	"Return a string representing the stored document"
	<return: #String>
	^ ''
]

{ #category : #actions }
Gt2NoStorageStrategy >> read: aGt2Document [ 
	"ignore"
]

{ #category : #accessing }
Gt2NoStorageStrategy >> rootDirectory [
	^ Smalltalk imageDirectory
]

{ #category : #actions }
Gt2NoStorageStrategy >> store: aGt2Document [ 
	"ignore"
]
