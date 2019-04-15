Class {
	#name : #GtCodeblockEvaluator,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'node',
		'document',
		'text',
		'selectedCode'
	],
	#category : #'GToolkit-Documenter-Code Snippet'
}

{ #category : #accessing }
GtCodeblockEvaluator >> document [
	<return: #GtDocument>
	self
		assert: [ document isNotNil ] 
		description: [ 'Document instance must be itialized before using it' ].
	^ document
]

{ #category : #accessing }
GtCodeblockEvaluator >> document: aGtDocument [
	self
		assert: [ document isNil ] 
		description: [ 'Document instance must be itialized only once' ].
	self
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document instance must be non-nil' ].
	document := aGtDocument
]

{ #category : #'accessing - document' }
GtCodeblockEvaluator >> editor [
	<return: #BrTextEditor>
	^ self document editor
]

{ #category : #actions }
GtCodeblockEvaluator >> evaluateBody [
	"Evaluate a node's body (code snippet)"
	| aCommand anErrorCatchingCommand |
	self hasNodeBody ifFalse: [ ^ self ].
	aCommand := GtEvaluateSourceCodeCommand new.
	aCommand requestor: self node.
	aCommand sourceCode: self selectionOrNodeBody.
	aCommand variableBindings: self variableBindings.
	aCommand receiver: self evaluationReceiver.
	anErrorCatchingCommand := aCommand asErrorCatchingCommand.
	anErrorCatchingCommand execute.
	self onFinishedEvaluation: anErrorCatchingCommand
]

{ #category : #actions }
GtCodeblockEvaluator >> evaluateSelection [
	"Evaluate a node's body (code snippet)"
	| aString |
	self hasNodeBody ifFalse: [ ^ self ].
	aString := self nodeBodySelection.
	aString ifNotNil: [ self selectedCode: aString ].
	self evaluateBody
]

{ #category : #'accessing - document' }
GtCodeblockEvaluator >> evaluationReceiver [
	<return: #Object>
	^ self document evaluationReceiver
]

{ #category : #testing }
GtCodeblockEvaluator >> hasNodeBody [
	"Return true if the given codeblock has a text body (code snippet to evaluate)"
	^ self nodeBody isNotNil and: [ self nodeBody trimBoth isNotEmpty ]
]

{ #category : #initialization }
GtCodeblockEvaluator >> initialize [
	super initialize.
	document := nil.
	node := nil.
	text := nil.
]

{ #category : #accessing }
GtCodeblockEvaluator >> node [
	<return: #PRDocumentItem>
	self
		assert: [ node isNotNil ]
		description: [ 'Pillar AST node must be initialized' ].
	^ node
]

{ #category : #accessing }
GtCodeblockEvaluator >> node: aPRDocumentItem [
	self
		assert: [ node isNil ] 
		description: [ 'Pillar AST node must be itialized only once' ].
	self
		assert: [ aPRDocumentItem isNotNil ] 
		description: [ 'Pillar AST node must be non-nil' ].
	node := aPRDocumentItem
]

{ #category : #'accessing - node' }
GtCodeblockEvaluator >> nodeBody [
	<return: #String>
	"Return codeblocks's text body (code snippet)"
	| aString |
	aString := self node text.
	self 
		assert: [ aString isString ]
		description: [ 'Node body (code snippet) must be a string' ].
	^ aString
]

{ #category : #'accessing - node' }
GtCodeblockEvaluator >> nodeBodySelection [
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

{ #category : #notifying }
GtCodeblockEvaluator >> onFinishedEvaluation: anErrorCatchingCommand [
	"Cache result and announce the result"
	| aResult |
	aResult := anErrorCatchingCommand result.
	self node cacheResult: aResult asException: anErrorCatchingCommand isException.
	anErrorCatchingCommand isException
		ifFalse: [ 
			self document announce: (GtCodeblockSuccessfulEvaluationAnnouncement new 
				document: self document;
				codeSnippet: self nodeBody; 
				result: aResult) ]
		ifTrue: [  
			self document announce: (GtCodeblockFailedEvaluationAnnouncement new
				document: self document;
				codeSnippet: self nodeBody;
				exception: aResult) ].
]

{ #category : #'accessing - selection' }
GtCodeblockEvaluator >> selectedCode [
	"Return explicitly set selected code snippet part"
	<return: #String or: nil>
	^ selectedCode
]

{ #category : #'accessing - selection' }
GtCodeblockEvaluator >> selectedCode: aString [
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

{ #category : #'accessing - document' }
GtCodeblockEvaluator >> selectedTextInterval [
	"Return selected text interval"
	<return: #Interval or: nil>
	self editor selection do: [ :eachSelection | 
		^ eachSelection from + 1 to: eachSelection to ].
	^ nil
]

{ #category : #'accessing - selection' }
GtCodeblockEvaluator >> selectionOrNodeBody [
	<return: #String>
	^ self selectedCode ifNil: [ self nodeBody ]
]

{ #category : #'accessing - node' }
GtCodeblockEvaluator >> start [
	"Return starting position of a node"
	<return: #Integer>
	^ self node start
]

{ #category : #'accessing - node' }
GtCodeblockEvaluator >> startNodeBody [
	"Return node's body starting position"
	<return: #Integer>
	^ self node scriptStartPositionInText: self text
]

{ #category : #'accessing - node' }
GtCodeblockEvaluator >> stop [
	"Return ending position of a node"
	<return: #Integer>
	^ self node stop
]

{ #category : #'accessing - node' }
GtCodeblockEvaluator >> stopNodeBody [
	"Return node's body stop position"
	<return: #Integer>
	^ self node scriptStopPositionInText: self text
]

{ #category : #accessing }
GtCodeblockEvaluator >> text [
	<return: #BlRope>
	self
		assert: [ text isNotNil ] 
		description: [ 'Document text must be itialized before using it' ].
	^ text
]

{ #category : #accessing }
GtCodeblockEvaluator >> text: aBlRope [
	self
		assert: [ text isNil ] 
		description: [ 'Document text must be itialized only once' ].
	self
		assert: [ aBlRope isNotNil ] 
		description: [ 'Document text must be non-nil' ].
	text := aBlRope
]

{ #category : #'accessing - document' }
GtCodeblockEvaluator >> variableBindings [
	<return: #GtSnippetBindings>
	^ self document variableBindings
]
