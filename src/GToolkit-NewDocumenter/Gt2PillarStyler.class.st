Class {
	#name : #Gt2PillarStyler,
	#superclass : #BlTextStyler,
	#instVars : [
		'parser',
		'document'
	],
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #accessing }
Gt2PillarStyler >> document [
	<return: #Gt2Document>
	^ document
]

{ #category : #accessing }
Gt2PillarStyler >> document: aGt2Document [
	self 
		assert: [ aGt2Document notNil ]
		description: [ 'Document must be non-nil' ].
	document := aGt2Document
]

{ #category : #initialization }
Gt2PillarStyler >> initialize [
	super initialize.
	parser := PRPillarParser new optimize.
]

{ #category : #private }
Gt2PillarStyler >> privateStyle: aText [
	<return: #BlRope>
	| aPRDocument |
	PRValidation beSilentDuring: [ 
		aPRDocument := parser parse: aText asString ].
	self
		assert: [ aPRDocument notNil ] 
		description: [ 'Parsing text should return a Pillar document' ].
	self
		assert: [ aPRDocument isPetit2Failure not ] 
		description: [ 'Target text should be a valid Pillar format' ].
	aPRDocument accept: (Gt2PillarStylerVisitor new document: self document; text: aText).
	^ aText
]
