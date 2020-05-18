Class {
	#name : #GtCodeblockBrowseClassAction,
	#superclass : #GtCodeblockAction,
	#instVars : [
		'element'
	],
	#category : #'GToolkit-Documenter-Code Snippet'
}

{ #category : #actions }
GtCodeblockBrowseClassAction >> browseClass [
	"Browse a selected class"
	| aBehavior |
	self hasNodeBody ifFalse: [ ^ self ].
	self isCursorPlacedInTheBody ifFalse: [ ^ self ].
	self allConditionsSatisfied ifFalse: [ ^ self ].
	aBehavior := self extractBehavior.
	aBehavior ifNil: [ ^ self ].
	aBehavior isBehavior ifFalse: [ ^ self ].
	self element phlow spawnTool: (GtClassCoderTool observedClass: aBehavior).
]

{ #category : #accessing }
GtCodeblockBrowseClassAction >> element [
	<return: #BlElement>
	self 
		assert: [ element isNotNil ] 
		description: [ 'Element must be initialized before using it' ].
	^ element
]

{ #category : #accessing }
GtCodeblockBrowseClassAction >> element: aBlElement [
	self 
		assert: [ aBlElement isNotNil ] 
		description: [ 'Element must be non-nil' ].
	element := aBlElement
]

{ #category : #execution }
GtCodeblockBrowseClassAction >> execute [
	"Perform a default action"
	self browseClass
]
