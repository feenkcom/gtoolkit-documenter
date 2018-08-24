Class {
	#name : #GtDocumentParts,
	#superclass : #Object,
	#traits : 'GtAssertingTrait',
	#classTraits : 'GtAssertingTrait classTrait',
	#instVars : [
		'collection'
	],
	#category : 'GToolkit-Documenter-Core'
}

{ #category : #adding }
GtDocumentParts >> add: aGtPillarDocumentExecutablePart [ 
	self 
		assert: [ aGtPillarDocumentExecutablePart notNil ] 
		description: [ 'Code snippet binding cannot be nil' ].
	collection add: aGtPillarDocumentExecutablePart
]

{ #category : #binding }
GtDocumentParts >> at: anInteger [ 
	"I am used as (outs at: index) in a Pillar codeblock.
	I return a result of a codeblock execution."
	^ (self documentPartAt: anInteger) 
		ifNotNil: [ :aGtPillarDocumentExecutablePart | 
			aGtPillarDocumentExecutablePart result ]
]

{ #category : #accessing }
GtDocumentParts >> before: aGtPillarDocumentExecutablePart [ 
	<return: #LiteralVariable or: nil>
	| anIndex |
	anIndex := collection indexOf: aGtPillarDocumentExecutablePart.
	anIndex < 1 ifTrue: [ ^ nil ].
	^ (collection at: anIndex - 1) result
]

{ #category : #accessing }
GtDocumentParts >> documentPartAt: anInteger [ 
	^ collection at: anInteger ifAbsent: [ nil ]
]

{ #category : #'gt-inspector-extension' }
GtDocumentParts >> gtInspectorDocumentPartsIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ (collection gtInspectorItemsIn: composite)
		title: [ 'Parts' translated ]
]

{ #category : #initialization }
GtDocumentParts >> initialize [
	super initialize.
	collection := OrderedCollection new.

]

{ #category : #adding }
GtDocumentParts >> insertScript: aGtCodeSnippetResult at: anInteger [ 
	collection add: aGtCodeSnippetResult beforeIndex: anInteger.
	self assert: (collection at: anInteger) == aGtCodeSnippetResult.
]

{ #category : #removing }
GtDocumentParts >> remove: aGtCodeSnippetResult [ 
	collection remove: aGtCodeSnippetResult.
	aGtCodeSnippetResult index to: collection size do: [ :index | 
		(collection at: index) index: index ]
]

{ #category : #removing }
GtDocumentParts >> removeAllAfterIndex: anInteger [ 
	self assert: [ anInteger isInteger ] description: [ 'Index should be an integer' ].
	self assert: [ anInteger > 0 and: [ anInteger <= collection size ] ] description: [ 'Index has to point to an existing item' ].
	collection removeLast: self size - anInteger.
]

{ #category : #accessing }
GtDocumentParts >> size [
	^ collection size
]
