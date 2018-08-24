Class {
	#name : #GtOldCodeSnippetResult,
	#superclass : #GtOutBindings,
	#instVars : [
		'index',
		'sourceCode'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #accessing }
GtOldCodeSnippetResult >> document [
	<return: #GtOldDocument>
	^ self bindings
]

{ #category : #accessing }
GtOldCodeSnippetResult >> document: aGtDocument [ 
	bindings ifNotNil: [ :anOldDocument | self unsubscribeFromDocument: anOldDocument ].
	bindings := aGtDocument.
	aGtDocument addCodeSnippet: self.
	self subscribeToDocument: aGtDocument
]

{ #category : #accessing }
GtOldCodeSnippetResult >> documentClass [
	^ self bindings class
]

{ #category : #'gt-inspector-extension' }
GtOldCodeSnippetResult >> gtInspectorSourceCodeIn: composite [
	<gtInspectorPresentationOrder: -4>
	^ composite text
		title: [ 'Source code' ];
		display: [ self sourceCode ];
		when: [ self sourceCode notNil ]
]

{ #category : #accessing }
GtOldCodeSnippetResult >> index [
	^ index
]

{ #category : #accessing }
GtOldCodeSnippetResult >> index: anObject [
	index := anObject
]

{ #category : #initialization }
GtOldCodeSnippetResult >> initializeFromTokens: aGtPillarScriptTokens [
	"Initialize code snippet using an information from a Pillar document"
	self 
		assert: [ aGtPillarScriptTokens isNotNil ]
		description: [ 'Pillar script tokens should be initialized' ]
]

{ #category : #printing }
GtOldCodeSnippetResult >> printOn: aStream [
	super printOn: aStream.
	index ifNil: [ ^ self ].
	aStream 
		nextPut: $[;
		print: index;
		nextPut: $].
	sourceCode ifNil: [ ^ self ].
	aStream nextPut: $[.
	aStream nextPutAll: (
		sourceCode lines 
			ifNotEmpty: [ :aCollection | aCollection first printStringLimitedTo: 10 ]
			ifEmpty: [ sourceCode ]).
	aStream nextPut: $].
	
	
]

{ #category : #accessing }
GtOldCodeSnippetResult >> sourceCode [
	^ sourceCode
]

{ #category : #accessing }
GtOldCodeSnippetResult >> sourceCode: anObject [
	sourceCode := anObject
]

{ #category : #private }
GtOldCodeSnippetResult >> subscribeToDocument: aGtDocument [ 
	"Subclasses can register for document and system changes."
	self 
		assert: [ aGtDocument notNil ] 
		description: [ 'Document has to be initialized' ].
]

{ #category : #private }
GtOldCodeSnippetResult >> unsubscribeFromDocument: aGtDocument [ 
	self 
		assert: [ aGtDocument notNil ] 
		description: [ 'Document has to be initialized' ].
	aGtDocument isBinding ifFalse: [ ^ self ].
	aGtDocument systemChangesHandler unsubscribe: self.
]
