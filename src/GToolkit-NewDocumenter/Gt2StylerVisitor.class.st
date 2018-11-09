Class {
	#name : #Gt2StylerVisitor,
	#superclass : #PRVisitor,
	#traits : 'TBlDebug + TGt2DocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait',
	#instVars : [
		'text',
		'document',
		'subscriber'
	],
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #accessing }
Gt2StylerVisitor >> document [
	<return: #Gt2Document>
	^ document
]

{ #category : #accessing }
Gt2StylerVisitor >> document: aGt2Document [
	self 
		assert: [ aGt2Document notNil ]
		description: [ 'Document must be non-nil' ].
	document := aGt2Document
]

{ #category : #accessing }
Gt2StylerVisitor >> subscriber [
	^ subscriber
]

{ #category : #accessing }
Gt2StylerVisitor >> subscriber: anObject [
	subscriber := anObject
]

{ #category : #accessing }
Gt2StylerVisitor >> text [
	<return: #BlRope>
	^ text
]

{ #category : #accessing }
Gt2StylerVisitor >> text: aBlRope [
	self
		assert: [ aBlRope notNil ] 
		description: [ 'Styled text must be non-nil' ].
	text := aBlRope
]

{ #category : #'visiting-annotations' }
Gt2StylerVisitor >> visitAnnotation: anAnnotation [
	anAnnotation 
		gtDocument: self document;
		gtSubscriber: self subscriber;
		styleInText: self text.
	super visitAnnotation: anAnnotation
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitCodeblock: aPRCodeblock [
	aPRCodeblock 
		gtDocument: self document;
		gtSubscriber: self subscriber;
		styleInText: self text.
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitExternalLink: anPRExternalLine [
	anPRExternalLine 
		gtDocument: self document;
		gtSubscriber: self subscriber;
		styleInText: self text.
]
