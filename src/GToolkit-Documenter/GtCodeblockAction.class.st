Class {
	#name : #GtCodeblockAction,
	#superclass : #Object,
	#instVars : [
		'selectedCode',
		'text',
		'node',
		'document',
		'conditions'
	],
	#category : #'GToolkit-Documenter-Code Snippet'
}

{ #category : #testing }
GtCodeblockAction >> allConditionsSatisfied [
	<return: #Boolean>
	^ self conditions allSatisfy: [ :eachCondition | eachCondition cull: self ]
]

{ #category : #accessing }
GtCodeblockAction >> condition: aBlock [
	"Add condition that must be satisfied to evaluate a code snippet"
	conditions addLast: aBlock
]

{ #category : #accessing }
GtCodeblockAction >> conditions [
	"Return conditions that must be satisfied to evaluate a code snippet"
	<return: #OrderedCollection>
	^ conditions
]

{ #category : #'accessing - cursor' }
GtCodeblockAction >> cursorPositionDo: aBlock [
	self editor cursors do: [ :eachCursor | ^ aBlock value: eachCursor position ]
]

{ #category : #accessing }
GtCodeblockAction >> document [
	<return: #GtDocument>
	self
		assert: [ document isNotNil ] 
		description: [ 'Document instance must be itialized before using it' ].
	^ document
]

{ #category : #accessing }
GtCodeblockAction >> document: aGtDocument [
	self
		assert: [ document isNil ] 
		description: [ 'Document instance must be itialized only once' ].
	self
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document instance must be non-nil' ].
	document := aGtDocument
]

{ #category : #'accessing - document' }
GtCodeblockAction >> editor [
	<return: #BrTextEditor>
	^ self document editor
]

{ #category : #execution }
GtCodeblockAction >> execute [
	"Perform a default action"
	self subclassResponsibility
]

{ #category : #testing }
GtCodeblockAction >> hasNodeBody [
	"Return true if the given codeblock has a text body (code snippet to evaluate)"
	^ self nodeBody isNotNil and: [ self nodeBody trimBoth isNotEmpty ]
]

{ #category : #initialization }
GtCodeblockAction >> initialize [
	super initialize.
	document := nil.
	node := nil.
	text := nil.
	conditions := OrderedCollection new: 1.
]

{ #category : #'accessing - cursor' }
GtCodeblockAction >> isCursorPlacedInTheBody [
	"Return true if a editor cursor is placed inside of the node body (code snippet)"
	<return: #Boolean>
	^ self nodeBodyCursor isNotNil
]

{ #category : #accessing }
GtCodeblockAction >> node [
	<return: #PRDocumentItem>
	self
		assert: [ node isNotNil ]
		description: [ 'Pillar AST node must be initialized' ].
	^ node
]

{ #category : #accessing }
GtCodeblockAction >> node: aPRDocumentItem [
	self
		assert: [ aPRDocumentItem isNotNil ] 
		description: [ 'Pillar AST node must be non-nil' ].
	node := aPRDocumentItem
]

{ #category : #'accessing - node' }
GtCodeblockAction >> nodeBody [
	<return: #String>
	"Return codeblocks's text body (code snippet)"
	| aString |
	aString := self node text.
	self 
		assert: [ aString isString ]
		description: [ 'Node body (code snippet) must be a string' ].
	^ aString
]

{ #category : #'accessing - cursor' }
GtCodeblockAction >> nodeBodyCursor [
	"Return node cursor position if inside of the node body (code snippet) or nil"
	<return: #BrTextEditorSingleCursor or: nil>
	| aStart aStop |
	aStart := self startNodeBody.
	aStop := self stopNodeBody.
	^ self editor cursors 
		detect: [ :eachCursor |  
			eachCursor position between: aStart and: aStop ]
		ifFound: [ :aCursor | aCursor ] 
		ifNone: [ nil ]
]

{ #category : #'accessing - selection' }
GtCodeblockAction >> nodeBodySelection [
	"Return node body (code snippet) selection or nil"
	<return: #String or: nil>
	| aStart aStop |
	aStart := self startNodeBody.
	aStop := self stopNodeBody.
	self selectedTextInterval ifNotNil: [ :anInterval | 
		((aStart <= anInterval first) and: [ anInterval last <= aStop ]) ifTrue: [ 
			^ (self text 
					from: anInterval first 
					to: anInterval last) asString ] ].
	^ nil
]

{ #category : #'accessing - selection' }
GtCodeblockAction >> selectedCode [
	"Return explicitly set selected code snippet part"
	<return: #String or: nil>
	^ selectedCode
]

{ #category : #'accessing - selection' }
GtCodeblockAction >> selectedCode: aString [
	"Explicitly set selected code snippet part"
	self 
		assert: [ aString isNotNil ] 
		description: [ 'Selected code snippet part must be non-nil' ].
	self 
		assert: [ aString isString ] 
		description: [ 'Selected code snippet part must be a string' ].
	self 
		assert: [ aString isNotEmpty ] 
		description: [ 'Selected code snippet part must be non-empty string' ].
	selectedCode := aString
]

{ #category : #'accessing - selection' }
GtCodeblockAction >> selectedTextInterval [
	"Return selected text interval"
	<return: #Interval or: nil>
	self editor selection do: [ :eachSelection | 
		^ eachSelection from + 1 to: eachSelection to ].
	^ nil
]

{ #category : #'accessing - selection' }
GtCodeblockAction >> selectionOrNodeBody [
	<return: #String>
	^ self selectedCode ifNil: [ self nodeBody ]
]

{ #category : #'accessing - node' }
GtCodeblockAction >> start [
	"Return starting position of a node"
	<return: #Integer>
	^ self node start
]

{ #category : #'accessing - node' }
GtCodeblockAction >> startNodeBody [
	"Return node's body starting position"
	<return: #Integer>
	^ self node scriptStartPositionInText: self text
]

{ #category : #'accessing - node' }
GtCodeblockAction >> stop [
	"Return ending position of a node"
	<return: #Integer>
	^ self node stop
]

{ #category : #'accessing - node' }
GtCodeblockAction >> stopNodeBody [
	"Return node's body stop position"
	<return: #Integer>
	^ self node scriptStopPositionInText: self text
]

{ #category : #accessing }
GtCodeblockAction >> text [
	<return: #BlRope>
	self
		assert: [ text isNotNil ] 
		description: [ 'Document text must be itialized before using it' ].
	^ text
]

{ #category : #accessing }
GtCodeblockAction >> text: aBlRope [
	self
		assert: [ text isNil ] 
		description: [ 'Document text must be itialized only once' ].
	self
		assert: [ aBlRope isNotNil ] 
		description: [ 'Document text must be non-nil' ].
	text := aBlRope
]

{ #category : #execution }
GtCodeblockAction >> value [
	self execute
]
