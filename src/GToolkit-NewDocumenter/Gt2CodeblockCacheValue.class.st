Class {
	#name : #Gt2CodeblockCacheValue,
	#superclass : #Gt2CacheValue,
	#instVars : [
		'result',
		'isException',
		'preview'
	],
	#category : #'GToolkit-NewDocumenter-Cache'
}

{ #category : #initialization }
Gt2CodeblockCacheValue >> initialize [
	super initialize.
	isException := false.
	result := nil.
]

{ #category : #accessing }
Gt2CodeblockCacheValue >> isException [
	^ isException
]

{ #category : #accessing }
Gt2CodeblockCacheValue >> isException: anObject [
	isException := anObject
]

{ #category : #accessing }
Gt2CodeblockCacheValue >> preview [
	^ preview
]

{ #category : #accessing }
Gt2CodeblockCacheValue >> preview: anObject [
	preview := anObject
]

{ #category : #accessing }
Gt2CodeblockCacheValue >> result [
	^ result
]

{ #category : #accessing }
Gt2CodeblockCacheValue >> result: anObject [
	result := anObject
]
