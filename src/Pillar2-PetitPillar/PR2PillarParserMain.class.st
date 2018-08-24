Class {
	#name : #PR2PillarParserMain,
	#superclass : #Object,
	#classVars : [
		'UseCompiledParser'
	],
	#category : 'Pillar2-PetitPillar'
}

{ #category : #'compiled parser' }
PR2PillarParserMain class >> beCompiled [
	UseCompiledParser := true
]

{ #category : #'compiled parser' }
PR2PillarParserMain class >> beNonCompiled [
	UseCompiledParser := false
]

{ #category : #'compiled parser' }
PR2PillarParserMain class >> compileParser [
	PR2PillarParser new compileWithOptions: {#parserName: . self compiledParserName asSymbol}.
	^ Smalltalk classNamed: self compiledParserName
	
]

{ #category : #'compiled parser' }
PR2PillarParserMain class >> compiledParser [
	^ (Smalltalk hasClassNamed: self compiledParserName)
		ifTrue: [ Smalltalk classNamed: self compiledParserName ]
		ifFalse: [ self compileParser ]
]

{ #category : #'compiled parser' }
PR2PillarParserMain class >> compiledParserName [
	^ 'PRPillarCompiled'
]

{ #category : #accessing }
PR2PillarParserMain class >> documentParser [
	^ (self useCompiled and: [ Smalltalk globals hasClassNamed: 'PPCompiledParser' ])
		ifTrue: [ self compiledParser ]
		ifFalse: [ PR2PillarParser ]
]

{ #category : #parsing }
PR2PillarParserMain class >> parse: aStringOrStream [
	| stream ston doc |
	stream := aStringOrStream readStream.
	stream atEnd
		ifTrue: [ ^ PRDocument new ].
	ston := self parseProperties: stream.
	doc := self parseDocument: stream upToEnd.
	ston
		keysAndValuesDo: [ :key :value | doc propertyAt: key put: value ].
	^ doc
]

{ #category : #parsing }
PR2PillarParserMain class >> parse: aString startingAt: aSymbol [
	^ self documentParser parse: aString startingAt: aSymbol
]

{ #category : #parsing }
PR2PillarParserMain class >> parseDocument: stream [
	^ self documentParser parse: stream
]

{ #category : #parsing }
PR2PillarParserMain class >> parseProperties: stream [
	| ston isSton |
	isSton := stream next = ${ and: [ stream peek ~~ ${ ].
	stream skip: -1.
	ston := isSton
		ifTrue: [ (STON reader on: stream) next ]
		ifFalse: [ Dictionary new ].
	^ ston
]

{ #category : #'compiled parser' }
PR2PillarParserMain class >> useCompiled [
	^ UseCompiledParser ifNil: [ self beCompiled. UseCompiledParser ]
]
