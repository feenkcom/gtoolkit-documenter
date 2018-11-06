Class {
	#name : #Gt2Styler,
	#superclass : #BlTextStyler,
	#instVars : [
		'parser',
		'document',
		'editorEventHandler'
	],
	#category : #'GToolkit-NewDocumenter-Styler'
}

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
		subscriber: self;
		text: aText).
	^ aText
]
