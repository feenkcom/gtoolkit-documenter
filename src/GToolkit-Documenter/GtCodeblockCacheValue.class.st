Class {
	#name : #GtCodeblockCacheValue,
	#superclass : #GtCacheValue,
	#instVars : [
		'result',
		'isException',
		'preview',
		'symbols',
		'hasResult',
		'evaluatedInterval'
	],
	#category : #'GToolkit-Documenter-Cache'
}

{ #category : #accessing }
GtCodeblockCacheValue >> evaluatedInterval [
	^ evaluatedInterval
]

{ #category : #accessing }
GtCodeblockCacheValue >> evaluatedInterval: anObject [
	evaluatedInterval := anObject
]

{ #category : #accessing }
GtCodeblockCacheValue >> hasResult [
	^ hasResult
]

{ #category : #initialization }
GtCodeblockCacheValue >> initialize [
	super initialize.
	isException := false.
	result := nil.
	hasResult := false.
]

{ #category : #accessing }
GtCodeblockCacheValue >> isException [
	^ isException
]

{ #category : #accessing }
GtCodeblockCacheValue >> isException: anObject [
	isException := anObject
]

{ #category : #accessing }
GtCodeblockCacheValue >> preview [
	^ preview
]

{ #category : #accessing }
GtCodeblockCacheValue >> preview: anObject [
	preview := anObject
]

{ #category : #accessing }
GtCodeblockCacheValue >> result [
	^ result
]

{ #category : #accessing }
GtCodeblockCacheValue >> result: anObject [
	result := anObject.
	hasResult := true.
]

{ #category : #accessing }
GtCodeblockCacheValue >> symbols [ 
	<return: #GtCodeblockSymbols or: nil>
	^ symbols
]

{ #category : #accessing }
GtCodeblockCacheValue >> symbols: aGt2CodeblockSymbols [ 
	symbols := aGt2CodeblockSymbols
]
