Class {
	#name : #GtCodeblockBrowseImplementorsAction,
	#superclass : #GtCodeblockAction,
	#instVars : [
		'element'
	],
	#category : 'GToolkit-Documenter-Code Snippet'
}

{ #category : #actions }
GtCodeblockBrowseImplementorsAction >> browseImplementors [
	"Browse a selected implementors"
	| aSymbol |
	self hasNodeBody ifFalse: [ ^ self ].
	self isCursorPlacedInTheBody ifFalse: [ ^ self ].
	self allConditionsSatisfied ifFalse: [ ^ self ].
	aSymbol := self extractSelectorSymbol.
	aSymbol ifNil: [ ^ self ].
	self element phlow spawnObject: (GtSearchImplementorsFilter selector: aSymbol).
]

{ #category : #accessing }
GtCodeblockBrowseImplementorsAction >> element [
	<return: #BlElement>
	self 
		assert: [ element isNotNil ] 
		description: [ 'Element must be initialized before using it' ].
	^ element
]

{ #category : #accessing }
GtCodeblockBrowseImplementorsAction >> element: aBlElement [
	self 
		assert: [ aBlElement isNotNil ] 
		description: [ 'Element must be non-nil' ].
	element := aBlElement
]

{ #category : #execution }
GtCodeblockBrowseImplementorsAction >> execute [
	"Perform a default action"
	self browseImplementors
]
