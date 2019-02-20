Class {
	#name : #GtStyler,
	#superclass : #BlTextStyler,
	#instVars : [
		'parser',
		'document',
		'editorEventHandler',
		'mode'
	],
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #initialization }
GtStyler >> displayMarkup [
	self mode: GtStylerStrategy displayMarkup
]

{ #category : #accessing }
GtStyler >> document [
	<return: #GtDocument>
	^ document
]

{ #category : #accessing }
GtStyler >> document: aGt2Document [
	document ifNotNil: [ :anOldDocument | anOldDocument editor removeEventHandler: self ].
	self 
		assert: [ aGt2Document notNil ]
		description: [ 'Document must be non-nil' ].
	document := aGt2Document.
	editorEventHandler document: aGt2Document.
	aGt2Document editor addEventHandler: editorEventHandler.
]

{ #category : #initialization }
GtStyler >> hideMarkup [
	self mode: GtStylerStrategy hideMarkup
]

{ #category : #initialization }
GtStyler >> initialize [
	super initialize.
	editorEventHandler := GtStylerEventHandler new subscriber: self.
	mode := GtStylerStrategy displayMarkup.
]

{ #category : #accessing }
GtStyler >> mode [
	<return: #GtStylerStrategy>
	^ mode
]

{ #category : #accessing }
GtStyler >> mode: aGt2StylerStrategy [
	self 
		assert: [ aGt2StylerStrategy notNil ] 
		description: [ 'Styling strategy must be non-nil' ].
	mode := aGt2StylerStrategy
]

{ #category : #accessing }
GtStyler >> parser [
	<return: #PRPillarParser>
	^ parser ifNil: [ parser := PRPillarParser new optimize ]
]

{ #category : #accessing }
GtStyler >> parser: aPRPillarParser [
	self 
		assert: [ aPRPillarParser notNil ]
		description: [ 'Pillar parser for styling text must be non-nil' ].
	parser := aPRPillarParser
]

{ #category : #private }
GtStyler >> privateStyle: aText [
	<return: #BlRope>
	| aPRDocument |
	self document unsubscribe: self.
	PRValidation beSilentDuring: [ 
		aPRDocument := self parser parse: aText asString ].
	self
		assert: [ aPRDocument notNil ] 
		description: [ 'Parsing text should return a Pillar document' ].
	self
		assert: [ aPRDocument isPetit2Failure not ] 
		description: [ 'Target text should be a valid Pillar format' ].
	aPRDocument accept: (GtStylerVisitor new 
		document: self document;
		mode: self mode;
		subscriber: self;
		text: aText).
	^ aText
]
