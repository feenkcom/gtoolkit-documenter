Class {
	#name : #GtOldCodeSnippets,
	#superclass : #Object,
	#traits : 'GtAssertingTrait',
	#classTraits : 'GtAssertingTrait classTrait',
	#instVars : [
		'collection'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #adding }
GtOldCodeSnippets >> add: aGtCodeSnippetResult [ 
	self assert: [ aGtCodeSnippetResult notNil ] description: [ 'Code snippet binding cannot be nil' ].
	collection add: aGtCodeSnippetResult
]

{ #category : #binding }
GtOldCodeSnippets >> at: anInteger [ 
	^ (self codeSnippetAt: anInteger) 
		ifNotNil: [ :aCodeSnippet | aCodeSnippet value ]
]

{ #category : #accessing }
GtOldCodeSnippets >> before: aGtCodeSnippetResult [ 
	<return: #LiteralVariable or: nil>
	| anIndex |
	anIndex := collection indexOf: aGtCodeSnippetResult.
	anIndex < 1 ifTrue: [ ^ nil ].
	^ (collection at: anIndex - 1) result
]

{ #category : #accessing }
GtOldCodeSnippets >> codeSnippetAt: anInteger [ 
	^ collection at: anInteger ifAbsent: [ nil ]
]

{ #category : #'gt-inspector-extension' }
GtOldCodeSnippets >> gtInspectorCodeSnippetsIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ (collection gtInspectorItemsIn: composite)
		title: [ 'Code Snippets' translated ]
]

{ #category : #initialization }
GtOldCodeSnippets >> initialize [
	super initialize.
	collection := OrderedCollection new.

]

{ #category : #adding }
GtOldCodeSnippets >> insertScript: aGtCodeSnippetResult at: anInteger [ 
	collection add: aGtCodeSnippetResult beforeIndex: anInteger.
	self assert: (collection at: anInteger) == aGtCodeSnippetResult.
]

{ #category : #removing }
GtOldCodeSnippets >> remove: aGtCodeSnippetResult [ 
	collection remove: aGtCodeSnippetResult.
	aGtCodeSnippetResult index to: collection size do: [ :index | 
		(collection at: index) index: index ]
]

{ #category : #removing }
GtOldCodeSnippets >> removeAllAfterIndex: anInteger [ 
	self assert: [ anInteger isInteger ] description: [ 'Index should be an integer' ].
	self assert: [ anInteger > 0 and: [ anInteger <= collection size ] ] description: [ 'Index has to point to an existing item' ].
	collection removeLast: self size - anInteger.
]

{ #category : #accessing }
GtOldCodeSnippets >> size [
	^ collection size
]
