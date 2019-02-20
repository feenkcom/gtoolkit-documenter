Class {
	#name : #GtCacheKey,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'counter'
	],
	#category : #'GToolkit-Documenter-Cache'
}

{ #category : #comparing }
GtCacheKey >> = anObject [
	^ self class = anObject class and: [ 
		self counter = anObject counter ]
]

{ #category : #accessing }
GtCacheKey >> counter [
	^ counter
]

{ #category : #accessing }
GtCacheKey >> counter: anObject [
	counter := anObject
]

{ #category : #comparing }
GtCacheKey >> hash [
	^ self class hash bitXor: self counter hash
]
