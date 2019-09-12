Class {
	#name : #GtExamplePreviewAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#instVars : [
		'example',
		'codeExpanded',
		'codeHeight',
		'noCode',
		'previewExpanded',
		'previewHeight',
		'previewShowSelector',
		'resultVariableName',
		'document'
	],
	#category : #'GToolkit-Documenter-Text - Attributes'
}

{ #category : #accessing }
GtExamplePreviewAttribute class >> constants [
	^ GtDocumentConstants
]

{ #category : #accessing }
GtExamplePreviewAttribute >> codeExpanded [
	^ codeExpanded
]

{ #category : #accessing }
GtExamplePreviewAttribute >> codeExpanded: anObject [
	codeExpanded := anObject
]

{ #category : #accessing }
GtExamplePreviewAttribute >> codeHeight [
	^ codeHeight
]

{ #category : #accessing }
GtExamplePreviewAttribute >> codeHeight: anObject [
	codeHeight := anObject
]

{ #category : #accessing }
GtExamplePreviewAttribute >> constants [
	^ GtDocumentConstants
]

{ #category : #accessing }
GtExamplePreviewAttribute >> doAffect: aBrText in: anEditorElement [
	^ self newExamplePreviewStencil asElement
]

{ #category : #accessing }
GtExamplePreviewAttribute >> document [
	^ document
]

{ #category : #accessing }
GtExamplePreviewAttribute >> document: anObject [
	self traceCr.
	document := anObject
]

{ #category : #accessing }
GtExamplePreviewAttribute >> example [
	^ example
]

{ #category : #accessing }
GtExamplePreviewAttribute >> example: aGtExample [
	self 
		assert: [ aGtExample isNotNil ] 
		description: [ 'Gt Example must be non-nil' ].
	example := aGtExample
]

{ #category : #'instance creation' }
GtExamplePreviewAttribute >> examplePreviewStencilClass [
	^ GtExamplePreviewStencil
]

{ #category : #initialization }
GtExamplePreviewAttribute >> initialize [
	super initialize.
	self beLazy.
	codeExpanded := true.
	codeHeight := self constants defaultPreviewHeight.
	noCode := true.
	example := (GtDocumentExamples >> #documentWithExistingExample) gtExample.
	previewExpanded := self constants defaultPreviewExpanded.
	previewHeight := self constants defaultPreviewHeight.
	previewShowSelector := self constants defaultShowSelector.
	
]

{ #category : #initialization }
GtExamplePreviewAttribute >> initializeLazyElement: aBlLazyElement [
	aBlLazyElement 
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c margin: (BlInsets top: 0 left: 20 bottom: 0 right: 20).
			c horizontal matchParent.
			c vertical fitContent ];
		addChild: (BrLabel new 
			look: BrLabelLook; 
			text: ('Preparing example...' asRopedText glamorousRegularFont; italic; foreground: BrGlamorousColors lightBorderColor);
			alignCenter;
			hMatchParent;
			vFitContent)
]

{ #category : #'instance creation' }
GtExamplePreviewAttribute >> newExamplePreviewStencil [
	^ self examplePreviewStencilClass new
		example: self example;
		codeExpanded: self codeExpanded;
		codeHeight: self codeHeight;
		noCode: self noCode;
		previewExpanded: self previewExpanded;
		previewShowSelector: self previewShowSelector;
		previewHeight: self previewHeight
]

{ #category : #accessing }
GtExamplePreviewAttribute >> noCode [
	^ noCode
]

{ #category : #accessing }
GtExamplePreviewAttribute >> noCode: anObject [
	noCode := anObject
]

{ #category : #accessing }
GtExamplePreviewAttribute >> previewExpanded [
	^ previewExpanded
]

{ #category : #accessing }
GtExamplePreviewAttribute >> previewExpanded: anObject [
	previewExpanded := anObject
]

{ #category : #accessing }
GtExamplePreviewAttribute >> previewHeight [
	^ previewHeight
]

{ #category : #accessing }
GtExamplePreviewAttribute >> previewHeight: anObject [
	previewHeight := anObject
]

{ #category : #accessing }
GtExamplePreviewAttribute >> previewShowSelector [
	^ previewShowSelector
]

{ #category : #accessing }
GtExamplePreviewAttribute >> previewShowSelector: anObject [
	previewShowSelector := anObject
]

{ #category : #accessing }
GtExamplePreviewAttribute >> resultVariableName [
	^ resultVariableName
]

{ #category : #accessing }
GtExamplePreviewAttribute >> resultVariableName: anObject [
	resultVariableName := anObject
]
