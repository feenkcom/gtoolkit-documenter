Class {
	#name : #GtAnnotationCacheKey,
	#superclass : #GtCacheKey,
	#instVars : [
		'name',
		'parameters'
	],
	#category : 'GToolkit-Documenter-Cache'
}

{ #category : #comparing }
GtAnnotationCacheKey >> = anObject [
	^ super = anObject and: [ 
		self name = anObject name and: [ 
			self parameters = anObject parameters ] ]
]

{ #category : #comparing }
GtAnnotationCacheKey >> hash [
	^ (super hash bitXor: self name hash)
		bitXor: self parameters hash
]

{ #category : #accessing }
GtAnnotationCacheKey >> name [
	^ name
]

{ #category : #accessing }
GtAnnotationCacheKey >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtAnnotationCacheKey >> parameters [
	^ parameters
]

{ #category : #accessing }
GtAnnotationCacheKey >> parameters: anObject [
	parameters := anObject
]

{ #category : #printing }
GtAnnotationCacheKey >> printOn: aStream [
	aStream 
		nextPutAll: 'annotation key: ';
		print: self name;
		nextPutAll: ' (';
		print: self counter;
		nextPut: $)
]
