Class {
	#name : 'GtDocumenterStyler',
	#superclass : 'BlTextStyler',
	#traits : 'TBlTextStyleable',
	#classTraits : 'TBlTextStyleable classTrait',
	#instVars : [
		'parser',
		'document',
		'editorEventHandler',
		'mode',
		'attributesBuilder'
	],
	#category : 'GToolkit-Documenter-Styler'
}

{ #category : 'accessing' }
GtDocumenterStyler >> attributesBuilder [
	<return: #BlTextAttributesBuilder>
	
	^ attributesBuilder
]

{ #category : 'initialization' }
GtDocumenterStyler >> displayMarkup [
	self mode: GtStylerStrategy displayMarkup
]

{ #category : 'accessing' }
GtDocumenterStyler >> document [
	<return: #GtDocumenter>
	^ document
]

{ #category : 'accessing' }
GtDocumenterStyler >> document: aGt2Document [
	document ifNotNil: [ :anOldDocument | anOldDocument editor removeEventHandler: self ].
	self 
		assert: [ aGt2Document notNil ]
		description: [ 'Document must be non-nil' ].
	document := aGt2Document.
	editorEventHandler document: aGt2Document.
	(aGt2Document editor hasEventHandler: editorEventHandler)
		ifFalse: [ aGt2Document editor addEventHandler: editorEventHandler ]
	
]

{ #category : 'initialization' }
GtDocumenterStyler >> hideMarkup [
	self mode: GtStylerStrategy hideMarkup
]

{ #category : 'initialization' }
GtDocumenterStyler >> initialize [
	super initialize.
	editorEventHandler := GtStylerEventHandler new subscriber: self.
	mode := GtStylerStrategy displayMarkup.

	attributesBuilder := BlTextDelegatedAttributesBuilder new.	
]

{ #category : 'accessing' }
GtDocumenterStyler >> mode [
	<return: #GtStylerStrategy>
	^ mode
]

{ #category : 'accessing' }
GtDocumenterStyler >> mode: aGt2StylerStrategy [
	self 
		assert: [ aGt2StylerStrategy notNil ] 
		description: [ 'Styling strategy must be non-nil' ].
	mode := aGt2StylerStrategy
]

{ #category : 'initialization' }
GtDocumenterStyler >> noInteractions [
	self mode: GtStylerStrategy noInteractions
]

{ #category : 'accessing' }
GtDocumenterStyler >> parser [
	<return: #PRPillarParser>
	^ parser ifNil: [ parser := PRPillarParser new optimize ]
]

{ #category : 'accessing' }
GtDocumenterStyler >> parser: aPRPillarParser [
	self 
		assert: [ aPRPillarParser notNil ]
		description: [ 'Pillar parser for styling text must be non-nil' ].
	parser := aPRPillarParser
]

{ #category : 'private' }
GtDocumenterStyler >> privateStyle: aText [
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
		
	self attributesBuilder applyOn: aText.
	
	aPRDocument accept: (GtStylerVisitor new 
		document: self document;
		mode: self mode;
		subscriber: self;
		text: aText).
	^ aText
]
