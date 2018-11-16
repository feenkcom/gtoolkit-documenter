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
