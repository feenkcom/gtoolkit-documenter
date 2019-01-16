Class {
	#name : #Gt2Styler,
	#superclass : #BlTextStyler,
	#instVars : [
		'parser',
		'document',
		'editorEventHandler',
		'mode'
	],
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #initialization }
Gt2Styler >> displayMarkup [
	self mode: Gt2StylerStrategy displayMarkup
]

{ #category : #accessing }
Gt2Styler >> document [
	<return: #Gt2Document>
	^ document
]

{ #category : #accessing }
Gt2Styler >> document: aGt2Document [
	document ifNotNil: [ :anOldDocument | anOldDocument editor removeEventHandler: self ].
	self 
		assert: [ aGt2Document notNil ]
		description: [ 'Document must be non-nil' ].
	document := aGt2Document.
	editorEventHandler document: aGt2Document.
	aGt2Document editor addEventHandler: editorEventHandler.
]

{ #category : #initialization }
Gt2Styler >> hideMarkup [
	self mode: Gt2StylerStrategy hideMarkup
]

{ #category : #initialization }
Gt2Styler >> initialize [
	super initialize.
	editorEventHandler := Gt2StylerEventHandler new subscriber: self.
	mode := Gt2StylerStrategy displayMarkup.
]

{ #category : #accessing }
Gt2Styler >> mode [
	<return: #Gt2StylerStrategy>
	^ mode
]

{ #category : #accessing }
Gt2Styler >> mode: aGt2StylerStrategy [
	self 
		assert: [ aGt2StylerStrategy notNil ] 
		description: [ 'Styling strategy must be non-nil' ].
	mode := aGt2StylerStrategy
]

{ #category : #accessing }
Gt2Styler >> parser [
	<return: #PRPillarParser>
	^ parser ifNil: [ parser := PRPillarParser new optimize ]
]

{ #category : #accessing }
Gt2Styler >> parser: aPRPillarParser [
	self 
		assert: [ aPRPillarParser notNil ]
		description: [ 'Pillar parser for styling text must be non-nil' ].
	parser := aPRPillarParser
]

{ #category : #private }
Gt2Styler >> privateStyle: aText [
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
	aPRDocument accept: (Gt2StylerVisitor new 
		document: self document;
		mode: self mode;
		subscriber: self;
		text: aText).
	^ aText
]
