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
Gt2Styler >> beEditingMode [
	self mode: Gt2StylerStrategy editingMode
]

{ #category : #initialization }
Gt2Styler >> beReadingMode [
	self mode: Gt2StylerStrategy readingMode
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
Gt2Styler >> initialize [
	super initialize.
	parser := PRPillarParser new optimize.
	editorEventHandler := Gt2StylerEventHandler new subscriber: self.
	mode := Gt2StylerStrategy editingMode.
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

{ #category : #private }
Gt2Styler >> privateStyle: aText [
	<return: #BlRope>
	| aPRDocument |
	self document unsubscribe: self.
	PRValidation beSilentDuring: [ 
		aPRDocument := parser parse: aText asString ].
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
