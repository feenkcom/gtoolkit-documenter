Class {
	#name : #Gt2FigureCacheKey,
	#superclass : #Gt2CacheKey,
	#instVars : [
		'fileName'
	],
	#category : #'GToolkit-NewDocumenter-Cache'
}

{ #category : #comparing }
Gt2FigureCacheKey >> = anObject [
	^ super = anObject and: [
		self fileName = anObject fileName ]
]

{ #category : #accessing }
Gt2FigureCacheKey >> fileName [
	^ fileName
]

{ #category : #accessing }
Gt2FigureCacheKey >> fileName: anObject [
	fileName := anObject
]

{ #category : #comparing }
Gt2FigureCacheKey >> hash [
	^ super hash
		bitXor: self fileName hash
]

{ #category : #printing }
Gt2FigureCacheKey >> printOn: aStream [
	aStream 
		nextPutAll: 'figure key';
		nextPutAll: ' (';
		print: self counter;
		nextPut: $)
]
