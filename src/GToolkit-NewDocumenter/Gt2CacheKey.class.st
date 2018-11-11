Class {
	#name : #Gt2CacheKey,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'counter'
	],
	#category : #'GToolkit-NewDocumenter-Cache'
}

{ #category : #comparing }
Gt2CacheKey >> = anObject [
	^ self class = anObject class and: [ 
		self counter = anObject counter ]
]

{ #category : #accessing }
Gt2CacheKey >> counter [
	^ counter
]

{ #category : #accessing }
Gt2CacheKey >> counter: anObject [
	counter := anObject
]

{ #category : #comparing }
Gt2CacheKey >> hash [
	^ self class hash bitXor: self counter hash
]
