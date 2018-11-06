Class {
	#name : #Gt2PillarStylerVisitor,
	#superclass : #PRVisitor,
	#traits : 'TBlDebug + TGt2DocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait',
	#instVars : [
		'text',
		'document'
	],
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #accessing }
Gt2PillarStylerVisitor >> document [
	<return: #Gt2Document>
	^ document
]

{ #category : #accessing }
Gt2PillarStylerVisitor >> document: aGt2Document [
	self 
		assert: [ aGt2Document notNil ]
		description: [ 'Document must be non-nil' ].
	document := aGt2Document
]

{ #category : #accessing }
Gt2PillarStylerVisitor >> text [
	<return: #BlRope>
	^ text
]

{ #category : #accessing }
Gt2PillarStylerVisitor >> text: aBlRope [
	self
		assert: [ aBlRope notNil ] 
		description: [ 'Styled text must be non-nil' ].
	text := aBlRope
]

{ #category : #'visiting-annotations' }
Gt2PillarStylerVisitor >> visitAnnotation: anAnnotation [
	anAnnotation gtDocument: self document.
	anAnnotation styleInText: self text.
	super visitAnnotation: anAnnotation
]
