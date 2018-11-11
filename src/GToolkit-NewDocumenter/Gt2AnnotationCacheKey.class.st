Class {
	#name : #Gt2AnnotationCacheKey,
	#superclass : #Gt2CacheKey,
	#instVars : [
		'name',
		'parameters'
	],
	#category : #'GToolkit-NewDocumenter-Cache'
}

{ #category : #comparing }
Gt2AnnotationCacheKey >> = anObject [
	^ super = anObject and: [ 
		self name = anObject name and: [ 
			self parameters = anObject parameters ] ]
]

{ #category : #comparing }
Gt2AnnotationCacheKey >> hash [
	^ (super hash bitXor: self name hash)
		bitXor: self parameters hash
]

{ #category : #accessing }
Gt2AnnotationCacheKey >> name [
	^ name
]

{ #category : #accessing }
Gt2AnnotationCacheKey >> name: anObject [
	name := anObject
]

{ #category : #accessing }
Gt2AnnotationCacheKey >> parameters [
	^ parameters
]

{ #category : #accessing }
Gt2AnnotationCacheKey >> parameters: anObject [
	parameters := anObject
]

{ #category : #printing }
Gt2AnnotationCacheKey >> printOn: aStream [
	aStream 
		nextPutAll: 'annotation key: ';
		print: self name.
]
