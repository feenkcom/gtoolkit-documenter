Class {
	#name : #Gt2CodeblockSymbols,
	#superclass : #Object,
	#instVars : [
		'messages',
		'variables'
	],
	#category : #'GToolkit-NewDocumenter-Utility'
}

{ #category : #adding }
Gt2CodeblockSymbols >> addSelector: aSymbol [
	self messages add: aSymbol
]

{ #category : #adding }
Gt2CodeblockSymbols >> addVariable: aVariableName [
	(#( 'self' 'super' ) includes: aVariableName) ifTrue: [ ^ self ].
	self variables add: aVariableName
]

{ #category : #testing }
Gt2CodeblockSymbols >> includesMessage: aSymbol [
	^ self messages includes: aSymbol
]

{ #category : #testing }
Gt2CodeblockSymbols >> includesVariable: aString [
	^ self variables includes: aString
]

{ #category : #initialization }
Gt2CodeblockSymbols >> initialize [
	super initialize.
	messages := Set new.
	variables := Set new.
]

{ #category : #accessing }
Gt2CodeblockSymbols >> messages [
	^ messages
]

{ #category : #accessing }
Gt2CodeblockSymbols >> messages: anObject [
	messages := anObject
]

{ #category : #accessing }
Gt2CodeblockSymbols >> variables [
	^ variables
]

{ #category : #accessing }
Gt2CodeblockSymbols >> variables: anObject [
	variables := anObject
]
