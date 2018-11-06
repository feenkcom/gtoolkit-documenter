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
