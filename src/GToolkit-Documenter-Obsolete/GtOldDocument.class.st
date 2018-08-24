Class {
	#name : #GtOldDocument,
	#superclass : #Object,
	#traits : 'GtOldDocumentTrait + GtBindingsTrait + GtAssertingTrait',
	#classTraits : 'GtOldDocumentTrait classTrait + GtBindingsTrait classTrait + GtAssertingTrait classTrait',
	#instVars : [
		'bindings',
		'codeSnippets',
		'systemChangesHandler'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #adding }
GtOldDocument >> addCodeSnippet: aGtCodeSnippetResult [ 
	"outs add: aGtCodeSnippetResult"
	codeSnippets insertScript: aGtCodeSnippetResult at: aGtCodeSnippetResult index.
	aGtCodeSnippetResult index + 1 to: codeSnippets size do: [ :anIndex | 
		(self outs codeSnippetAt: anIndex) index: anIndex ].
]

{ #category : #adding }
GtOldDocument >> addNamed: aString value: anObject [ 
	bindings addNamed: aString value: anObject 
]

{ #category : #binding }
GtOldDocument >> bindingOf: aSymbol [
	self 
		assert: [ aSymbol notNil ]
		description: [ 'The argument should be a symbol' ].
	^ bindings bindingOf: aSymbol
]

{ #category : #accessing }
GtOldDocument >> bindings [
	^ bindings
]

{ #category : #accessing }
GtOldDocument >> codeSnippetAt: anInteger [ 
	<return: #GtOldCodeSnippetResult>
	self flag: 'remove it'.
	self assert: [ anInteger <= (codeSnippets size + 1) ] description: [ 'A code snippet was skipped' ].
	(codeSnippets size + 1) = anInteger ifTrue: [ | newScript |
		newScript := GtOldCodeSnippetResult new.
		newScript document: self ].
	^ codeSnippets codeSnippetAt: anInteger
]

{ #category : #accessing }
GtOldDocument >> codeSnippets [
	<return: #GtOldCodeSnippets>
	^ codeSnippets
]

{ #category : #'gt-inspector-extension' }
GtOldDocument >> gtInspectorBindingsIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ bindings gtInspectorBindingsIn: composite
]

{ #category : #'gt-inspector-extension' }
GtOldDocument >> gtInspectorBindingsTreeIn: composite [
	<gtInspectorPresentationOrder: 5>
	^ composite fastTree
		title: [ 'Bindings tree' ];
		display: [ { self } ];
		children: [ :anItem | 
			anItem 
				ifNil: [ #() ] 
				ifNotNil: [ { anItem bindings } ] ];
		yourself
]

{ #category : #'gt-inspector-extension' }
GtOldDocument >> gtInspectorOutsIn: composite [
	<gtInspectorPresentationOrder: 2>
	^ (codeSnippets gtInspectorCodeSnippetsIn: composite)
		title: [ 'Code Snippets' translated ]
]

{ #category : #initialization }
GtOldDocument >> initialize [
	super initialize.
	codeSnippets := GtOldCodeSnippets new.
	bindings := GtDocumentBindings new.
	bindings 
		addNamed: GtDocumenterConstants resultsVariableName 
		value: codeSnippets.
	systemChangesHandler := GtSystemChangesHandler new.
]

{ #category : #accessing }
GtOldDocument >> outs [
	<return: #GtOldCodeSnippets>
	^ self codeSnippets
]

{ #category : #accessing }
GtOldDocument >> systemChangesHandler [
	<return: #GtSystemChangesHandler>
	^ systemChangesHandler
]

{ #category : #initialization }
GtOldDocument >> unsubscribeFromSystem [
	systemChangesHandler unsubscribeFromSystem
]
