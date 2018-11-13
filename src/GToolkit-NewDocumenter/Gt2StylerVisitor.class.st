Class {
	#name : #Gt2StylerVisitor,
	#superclass : #PRVisitor,
	#traits : 'TBlDebug + TGt2DocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait',
	#instVars : [
		'text',
		'document',
		'subscriber',
		'codeblockCounter',
		'annotationCounter'
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

{ #category : #initialization }
Gt2StylerVisitor >> initialize [
	super initialize.
	codeblockCounter := 0.
	annotationCounter := 0.
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
	annotationCounter := annotationCounter + 1.
	anAnnotation 
		counter: annotationCounter;
		gtDocument: self document;
		gtSubscriber: self subscriber;
		styleInText: self text.
	super visitAnnotation: anAnnotation
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitBoldFormat: aPRBoldFormat [
	(self text
		from: aPRBoldFormat start
		to: aPRBoldFormat stop)
			bold
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitCodeblock: aPRCodeblock [
	codeblockCounter := codeblockCounter + 1.
	aPRCodeblock 
		counter: codeblockCounter;
		gtDocument: self document;
		gtSubscriber: self subscriber;
		styleInText: self text.
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitCommentedLine: aPRCommentedLine [
	aPRCommentedLine 
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

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitHeader: aPRHeader [
	(self text
		from: aPRHeader start
		to: aPRHeader stop)
			fontSize: 20 - aPRHeader level
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitItalicFormat: aPRItalicFormat [
	(self text
		from: aPRItalicFormat start
		to: aPRItalicFormat stop)
			italic
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitMonospaceFormat: aPRMonospaceFormat [
	(self text
		from: aPRMonospaceFormat start
		to: aPRMonospaceFormat stop)
			monospace";
			foreground: Color darkGray"
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitRaw: aPRRaw [
	aPRRaw start ifNil: [ ^ self ].
	self flag: 'fix Pillar'.
	(self text
		from: aPRRaw start
		to: aPRRaw stop)
			monospace
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitStrikethroughFormat: aPRStrikethroughFormat [
	(self text
		from: aPRStrikethroughFormat start
		to: aPRStrikethroughFormat stop)
			foreground: self constants subtleColor
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitSubscriptFormat: aPRSubscriptFormat [
	(self text
		from: aPRSubscriptFormat start
		to: aPRSubscriptFormat stop)
			foreground: self constants subtleColor
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitSuperscriptFormat: aPRSuperscriptFormat [
	(self text
		from: aPRSuperscriptFormat start
		to: aPRSuperscriptFormat stop)
			foreground: self constants subtleColor;
			fontSize: 9
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitUndefinedAnnotation: anAnnotation [
	(self text
		from: anAnnotation start 
		to: anAnnotation stop)
			foreground: Color red
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitUnderlineFormat: aPRUnderlineFormat [
	(self text
		from: aPRUnderlineFormat start
		to: aPRUnderlineFormat stop)
			underline
]
