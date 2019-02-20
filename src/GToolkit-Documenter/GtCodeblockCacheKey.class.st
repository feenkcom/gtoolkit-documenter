Class {
	#name : #GtCodeblockCacheKey,
	#superclass : #GtCacheKey,
	#instVars : [
		'text',
		'caption',
		'parameters'
	],
	#category : #'GToolkit-Documenter-Cache'
}

{ #category : #comparing }
GtCodeblockCacheKey >> = anObject [
	^ super = anObject and: [ 
		(self parameters = anObject parameters) and: [ 
			(self text = anObject text) and: [ 
				self caption = anObject caption ] ] ]
]

{ #category : #accessing }
GtCodeblockCacheKey >> caption [
	^ caption
]

{ #category : #accessing }
GtCodeblockCacheKey >> caption: anObject [
	caption := anObject
]

{ #category : #comparing }
GtCodeblockCacheKey >> hash [
	^ ((super hash
		bitXor: self parameters hash)
			bitXor: self text hash)
				bitXor: self caption hash
]

{ #category : #accessing }
GtCodeblockCacheKey >> parameters [
	^ parameters
]

{ #category : #accessing }
GtCodeblockCacheKey >> parameters: anObject [
	parameters := anObject
]

{ #category : #printing }
GtCodeblockCacheKey >> printOn: aStream [
	aStream 
		nextPutAll: 'codeblock key';
		nextPutAll: ' (';
		print: self counter;
		nextPut: $)
]

{ #category : #accessing }
GtCodeblockCacheKey >> text [
	^ text
]

{ #category : #accessing }
GtCodeblockCacheKey >> text: anObject [
	text := anObject
]
