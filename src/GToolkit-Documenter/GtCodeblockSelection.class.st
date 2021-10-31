Class {
	#name : #GtCodeblockSelection,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'text',
		'interval'
	],
	#category : 'GToolkit-Documenter-Code Snippet'
}

{ #category : #accessing }
GtCodeblockSelection >> asString [
	^ self text asString
]

{ #category : #accessing }
GtCodeblockSelection >> interval [
	<return: #Interval>
	self 
		assert: [ interval isNotNil ] 
		description: [ 'Selected interval must be initialized before using it' ].
	^ interval
]

{ #category : #accessing }
GtCodeblockSelection >> interval: anInterval [
	self 
		assert: [ interval isNil ] 
		description: [ 'Selected interval must be initialized only once' ].
	self 
		assert: [ anInterval isNotNil ] 
		description: [ 'Selected interval must be non-nil' ].
	self 
		assert: [ anInterval isNotEmpty ] 
		description: [ 'Selected text must be non-empty' ].
	interval := anInterval
]

{ #category : #testing }
GtCodeblockSelection >> isNotEmpty [
	"Return true if there is a non-empty text"
	<return: #Boolean>
	^ text isNotNil and: [ text isNotEmpty ]
]

{ #category : #accessing }
GtCodeblockSelection >> text [
	<return: #String>
	self 
		assert: [ text isNotNil ] 
		description: [ 'Selected text must be initialized before using it' ].
	^ text
]

{ #category : #accessing }
GtCodeblockSelection >> text: aString [
	self 
		assert: [ text isNil ] 
		description: [ 'Selected text must be initialized only once' ].
	self 
		assert: [ aString isNotNil ] 
		description: [ 'Selected text must be non-nil' ].
	self 
		assert: [ aString isString ] 
		description: [ 'Selected text must be a string' ].
	self 
		assert: [ aString isNotEmpty ] 
		description: [ 'Selected text must be non-empty' ].
	text := aString
]
