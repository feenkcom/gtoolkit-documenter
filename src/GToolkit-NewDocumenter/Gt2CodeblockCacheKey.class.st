Class {
	#name : #Gt2CodeblockCacheKey,
	#superclass : #Gt2CacheKey,
	#instVars : [
		'parameters'
	],
	#category : #'GToolkit-NewDocumenter-Cache'
}

{ #category : #comparing }
Gt2CodeblockCacheKey >> = anObject [
	^ self class = anObject class and: [ 
			self parameters = anObject parameters ]
]

{ #category : #comparing }
Gt2CodeblockCacheKey >> hash [
	^ self class hash
		bitXor: self parameters hash
]

{ #category : #accessing }
Gt2CodeblockCacheKey >> parameters [
	^ parameters
]

{ #category : #accessing }
Gt2CodeblockCacheKey >> parameters: anObject [
	parameters := anObject
]

{ #category : #printing }
Gt2CodeblockCacheKey >> printOn: aStream [
	aStream 
		nextPutAll: 'codeblock key'
]
