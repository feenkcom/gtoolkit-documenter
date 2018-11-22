Class {
	#name : #Gt2Resourcer,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'document',
		'includeFigures',
		'ast'
	],
	#category : #'GToolkit-NewDocumenter-Resourcer'
}

{ #category : #accessing }
Gt2Resourcer >> ast [
	<return: #PRDocument>
	^ ast ifNil: [ ast := self document parse ].
]

{ #category : #accessing }
Gt2Resourcer >> document [
	<return: #Gt2Document>
	^ document
]

{ #category : #accessing }
Gt2Resourcer >> document: aGtDocument [
	self 
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document must be non-nil' ].
	document := aGtDocument
]

{ #category : #initialization }
Gt2Resourcer >> figures [
	includeFigures := true
]

{ #category : #enumerating }
Gt2Resourcer >> maybeFiguresIn: aPRDocument into: aWriteStream [ 
	includeFigures ifFalse: [ ^ self ].
	(PRImageDependencies new start: aPRDocument) do: [ :eachFileName | 
		| aFigure |
		aFigure := Gt2Figure new 
			document: self document;
			resource: (GtFileUtility 
				fileReferenceOfFileName: eachFileName 
				relativeTo: self document rootDirectory);
			name: eachFileName.
		aWriteStream nextPut: aFigure ]
]

{ #category : #private }
Gt2Resourcer >> maybeFiguresInto: aWriteStream [ 
	self shouldBeImplemented.
]

{ #category : #building }
Gt2Resourcer >> resources [
	^ OrderedCollection streamContents: [ :aStream |
		self maybeFiguresIn: self ast into: aStream ]
]
