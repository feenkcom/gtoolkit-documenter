Class {
	#name : #Gt2CodeblockCacheKey,
	#superclass : #Gt2CacheKey,
	#instVars : [
		'text',
		'caption',
		'counter',
		'parameters'
	],
	#category : #'GToolkit-NewDocumenter-Cache'
}

{ #category : #comparing }
Gt2CodeblockCacheKey >> = anObject [
	^ self class = anObject class and: [ 
		(self parameters = anObject parameters) and: [ 
			(self text = anObject text) and: [ 
				self caption = anObject caption and: [ 
					self counter = anObject counter ] ] ] ]
]

{ #category : #accessing }
Gt2CodeblockCacheKey >> caption [
	^ caption
]

{ #category : #accessing }
Gt2CodeblockCacheKey >> caption: anObject [
	caption := anObject
]

{ #category : #accessing }
Gt2CodeblockCacheKey >> counter [
	^ counter
]

{ #category : #accessing }
Gt2CodeblockCacheKey >> counter: anObject [
	counter := anObject
]

{ #category : #comparing }
Gt2CodeblockCacheKey >> hash [
	^ (((self class hash
		bitXor: self parameters hash)
			bitXor: self text hash)
				bitXor: self caption hash)
					bitXor: self counter hash
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

{ #category : #accessing }
Gt2CodeblockCacheKey >> text [
	^ text
]

{ #category : #accessing }
Gt2CodeblockCacheKey >> text: anObject [
	text := anObject
]
