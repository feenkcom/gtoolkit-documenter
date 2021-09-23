Class {
	#name : 'GtCodeblockSymbols',
	#superclass : 'Object',
	#instVars : [
		'messages',
		'variables'
	],
	#category : 'GToolkit-Documenter-Utility'
}

{ #category : 'adding' }
GtCodeblockSymbols >> addSelector: aSymbol [
	self messages add: aSymbol
]

{ #category : 'adding' }
GtCodeblockSymbols >> addVariable: aVariableName [
	(#( 'self' 'super' ) includes: aVariableName) ifTrue: [ ^ self ].
	self variables add: aVariableName
]

{ #category : 'testing' }
GtCodeblockSymbols >> includesMessage: aSymbol [
	^ self messages includes: aSymbol
]

{ #category : 'testing' }
GtCodeblockSymbols >> includesVariable: aString [
	^ self variables includes: aString
]

{ #category : 'initialization' }
GtCodeblockSymbols >> initialize [
	super initialize.
	messages := Set new.
	variables := Set new.
]

{ #category : 'accessing' }
GtCodeblockSymbols >> messages [
	^ messages
]

{ #category : 'accessing' }
GtCodeblockSymbols >> messages: anObject [
	messages := anObject
]

{ #category : 'accessing' }
GtCodeblockSymbols >> variables [
	^ variables
]

{ #category : 'accessing' }
GtCodeblockSymbols >> variables: anObject [
	variables := anObject
]
