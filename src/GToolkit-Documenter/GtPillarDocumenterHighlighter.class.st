Class {
	#name : #GtPillarDocumenterHighlighter,
	#superclass : #PRVisitor,
	#traits : 'GtAssertingTrait',
	#classTraits : 'GtAssertingTrait classTrait',
	#instVars : [
		'targetText',
		'listItemCounter',
		'outsCounter',
		'document',
		'fileReference',
		'parser'
	],
	#category : #'GToolkit-Documenter-Pillar - Highlighter'
}

{ #category : #protocol }
GtPillarDocumenterHighlighter class >> highlight: aBrRopedText [ 
	self 
		assert: [ aBrRopedText notNil ] 
		description: [ 'The target text should be initialized' ].
	^ self new
		targetText: aBrRopedText;
		highlight
]

{ #category : #testing }
GtPillarDocumenterHighlighter class >> isAbstract [
	^ false
]

{ #category : #accessing }
GtPillarDocumenterHighlighter >> document [
	<return: #GtDocument>
	^ document
]

{ #category : #accessing }
GtPillarDocumenterHighlighter >> document: aGtDocument [ 
	self
		assert: [ aGtDocument notNil ] 
		description: [ 'Document has to be initialized' ].
	document := aGtDocument
]

{ #category : #accessing }
GtPillarDocumenterHighlighter >> fileReference [
	^ fileReference
]

{ #category : #accessing }
GtPillarDocumenterHighlighter >> fileReference: aFileReference [
	self 
		assert: [ aFileReference notNil ] 
		description: [ 'The file reference should be initialized' ].
	self 
		assert: [ aFileReference exists ] 
		description: [ 'The file reference should exist' ].
	fileReference := aFileReference
]

{ #category : #protocol }
GtPillarDocumenterHighlighter >> highlight [
	"Highlight a given Pillar text.
	It modifies the given target text."
	| aPRDocument |
	PRValidation beSilentDuring: [ 
		aPRDocument := parser parse: self targetText asString ].
	self
		assert: [ aPRDocument notNil ] 
		description: [ 'Parsing text should return a Pillar document' ].
	self
		assert: [ aPRDocument isPetit2Failure not ] 
		description: [ 'Target text should be a valid Pillar format' ].
	self resetOutCounter.
	aPRDocument accept: self.
	^ self targetText
]

{ #category : #initialization }
GtPillarDocumenterHighlighter >> initialize [
	super initialize.
	document := GtDocument new.
	parser := PRPillarParser new optimize.
	self resetOutCounter.
	self resetListItemCounter.
]

{ #category : #initialization }
GtPillarDocumenterHighlighter >> resetListItemCounter [
	listItemCounter := PRCascadingCounter maxLevel: 1
]

{ #category : #initialization }
GtPillarDocumenterHighlighter >> resetOutCounter [
	outsCounter := 0.
]

{ #category : #accessing }
GtPillarDocumenterHighlighter >> targetText [
	self 
		assert: [ targetText notNil ] 
		description: [ 'The target text should be initialized before using it' ].
	^ targetText
]

{ #category : #accessing }
GtPillarDocumenterHighlighter >> targetText: aBrRopedText [
	self 
		assert: [ aBrRopedText notNil ] 
		description: [ 'The target text should be initialized' ].
	targetText := aBrRopedText
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitAnnotatedParagraph: aPRAnnotatedParagraph [
	(self targetText
		from: aPRAnnotatedParagraph start
		to: aPRAnnotatedParagraph stop)
			foreground: Color red muchDarker
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitAnnotation: anAnnotation [
	(self targetText 
		from: anAnnotation start 
		to: anAnnotation stop)
			foreground: Color gray.

	super visitAnnotation: anAnnotation
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitBoldFormat: aPRBoldFormat [
	(self targetText
		from: aPRBoldFormat start
		to: aPRBoldFormat stop)
			bold;
			foreground: Color black
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitCodeblock: aPRCodeblock [
	| aDocumentPart |
	outsCounter := outsCounter + 1.
	aPRCodeblock counter: outsCounter.
	aDocumentPart := GtDocumentPartFinder new
		document: self document;
		pillarNode: aPRCodeblock;
		documentPartClass: GtPillarCodeblock;
		find.
	GtPillarCodeblockHighlighter highlight: aDocumentPart using: self.
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitCommentedLine: aPRCommentedLine [
	(self targetText
		from: aPRCommentedLine start
		to: aPRCommentedLine stop)
			foreground: Color gray
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitExternalLink: anPRExternalLine [
	(self targetText
		from: anPRExternalLine start
		to: anPRExternalLine stop)
			foreground: BrGlamorousColors linkColor;
			attributes: { 
				BrTextHoverAttribute new 
					beNotOverwritableByStyler;
					removableTextAttribute: (BlTextBackgroundAttribute paint: (Color gray alpha: 0.2)).
				BrTextClickAttribute new 
					beNotOverwritableByStyler;
					action: [ :aText :aTarget :anEvent | 
						WebBrowser openOn: anPRExternalLine url  ] 
			 }
			
]

{ #category : #'visiting-document' }
GtPillarDocumenterHighlighter >> visitFigure: aFigure [
	GtPillarFigureHighlighter highlight: aFigure using: self.
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitGtPillarEpiceaChangesAnnotation: aGtPillarEpiceaChangesAnnotation [
	| aPillarDocumentPart |
	aPillarDocumentPart := GtEpiceaChanges new
		document: self document;
		sourceFileReference: self fileReference;
		pillarNode: aGtPillarEpiceaChangesAnnotation.
	GtPillarEpiceaChangesHighlighter highlight: aPillarDocumentPart using: self.
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitGtPillarExampleAnnotation: aGtPillarExampleAnnotation [
	aGtPillarExampleAnnotation document: self document.
	self document systemChangesHandler
		subscribe: MethodAdded, MethodModified, MethodRemoved
		send: #handleMethodAnnouncement:
		to: aGtPillarExampleAnnotation
		for: aGtPillarExampleAnnotation.
	self document systemChangesHandler
		subscribe: ClassAdded, ClassRemoved
		send: #handleClassAddedOrRemovedAnnouncement:
		to: aGtPillarExampleAnnotation
		for: aGtPillarExampleAnnotation.
	self document systemChangesHandler
		subscribe: ClassRenamed
		send: #handleClassRenamedAnnouncement:
		to: aGtPillarExampleAnnotation
		for: aGtPillarExampleAnnotation.
	GtPillarExampleHighlighter highlight: aGtPillarExampleAnnotation using: self.
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitGtPillarExamplesAnnotation: aGtPillarExamplesAnnotation [
	GtPillarExamplesAnnotationHighlighter highlight: aGtPillarExamplesAnnotation using: self.
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitGtPillarIcebergFileAnnotation: aGtPillarIcebergFileAnnotation [
	GtPillarIcebergFileAnnotationHighlighter highlight: aGtPillarIcebergFileAnnotation using: self.
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitHeader: aPRHeader [
	(self targetText
		from: aPRHeader start
		to: aPRHeader stop)
			fontSize: 20 - aPRHeader level
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitInputFileAnnotation: aPRInputFileAnnotation [ 
	GtPillarInputFileAnnotationHighlighter highlight: aPRInputFileAnnotation using: self.
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitList: aPRList [
	self resetListItemCounter.
	super visitList: aPRList
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitListItem: aPRListItem [
	| anItemIndex |
	listItemCounter incrementAt: 1.
	anItemIndex := listItemCounter printString asString.
	(self targetText
		from: aPRListItem start
		to: aPRListItem start)
			attributes: {
				BrTextAdornmentDynamicAttribute new 
					beAppend; 
					stencil: [
						| indexText |
						indexText := anItemIndex asRopedText.
						indexText fontSize: 9.
						indexText foreground: Color lightGray.
						BlTextElement new text: indexText ] }.
	super visitListItem: aPRListItem
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitMonospaceFormat: aPRMonospaceFormat [
	(self targetText
		from: aPRMonospaceFormat start
		to: aPRMonospaceFormat stop)
			monospace;
			foreground: Color darkGray
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitParameter: aParameter [
	aParameter isValid ifFalse: [ 
		(self targetText
			from: aParameter start 
			to: aParameter stop)
				foreground: Color red ].
	super visitParameter: aParameter
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitPillarClassAnnotation: aGtPillarClassAnnotation [ 
	GtPillarClassAnnotationHighlighter highlight: aGtPillarClassAnnotation using: self.
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitPillarMethodAnnotation: aGtPillarMethodAnnotation [ 
	GtPillarMethodAnnotationHighlighter highlight: aGtPillarMethodAnnotation using: self.
]

{ #category : #visiting }
GtPillarDocumenterHighlighter >> visitUndefinedAnnotation: anAnnotation [
	(self targetText
		from: anAnnotation start 
		to: anAnnotation stop)
			foreground: Color red
]
