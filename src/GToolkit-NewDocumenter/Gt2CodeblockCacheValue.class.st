Class {
	#name : #Gt2CodeblockCacheValue,
	#superclass : #Gt2CacheValue,
	#instVars : [
		'result',
		'isException',
		'preview',
		'symbols',
		'hasResult'
	],
	#category : #'GToolkit-NewDocumenter-Cache'
}

{ #category : #accessing }
Gt2CodeblockCacheValue >> hasResult [
	^ hasResult
]

{ #category : #initialization }
Gt2CodeblockCacheValue >> initialize [
	super initialize.
	isException := false.
	result := nil.
	hasResult := false.
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
	result := anObject.
	hasResult := true.
]

{ #category : #'as yet unclassified' }
Gt2CodeblockCacheValue >> symbols [ 
	<return: #Gt2CodeblockSymbols or: nil>
	^ symbols
]

{ #category : #accessing }
Gt2CodeblockCacheValue >> symbols: aGt2CodeblockSymbols [ 
	symbols := aGt2CodeblockSymbols
]
