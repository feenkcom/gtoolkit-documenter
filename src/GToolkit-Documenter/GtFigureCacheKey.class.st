Class {
	#name : 'GtFigureCacheKey',
	#superclass : 'GtCacheKey',
	#instVars : [
		'fileName'
	],
	#category : 'GToolkit-Documenter-Cache'
}

{ #category : 'comparing' }
GtFigureCacheKey >> = anObject [
	^ super = anObject and: [
		self fileName = anObject fileName ]
]

{ #category : 'accessing' }
GtFigureCacheKey >> fileName [
	^ fileName
]

{ #category : 'accessing' }
GtFigureCacheKey >> fileName: anObject [
	fileName := anObject
]

{ #category : 'comparing' }
GtFigureCacheKey >> hash [
	^ super hash
		bitXor: self fileName hash
]

{ #category : 'printing' }
GtFigureCacheKey >> printOn: aStream [
	aStream 
		nextPutAll: 'figure key';
		nextPutAll: ' (';
		print: self counter;
		nextPut: $)
]
