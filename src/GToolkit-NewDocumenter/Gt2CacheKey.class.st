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

{ #category : #accessing }
Gt2CacheKey >> counter [
	^ counter
]

{ #category : #accessing }
Gt2CacheKey >> counter: anObject [
	counter := anObject
]
