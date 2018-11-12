Class {
	#name : #Gt2ExamplePreviewStencil,
	#superclass : #BrStencil,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#instVars : [
		'example',
		'exampleWithResult',
		'codeExpanded',
		'codeHeight',
		'noCode',
		'previewExpanded',
		'previewHeight',
		'previewShowSelector'
	],
	#category : #'GToolkit-NewDocumenter-Brick - Stencils'
}

{ #category : #accessing }
Gt2ExamplePreviewStencil >> codeExpanded [
	^ codeExpanded
]

{ #category : #accessing }
Gt2ExamplePreviewStencil >> codeExpanded: anObject [
	codeExpanded := anObject
]

{ #category : #accessing }
Gt2ExamplePreviewStencil >> codeHeight [
	^ codeHeight
]

{ #category : #accessing }
Gt2ExamplePreviewStencil >> codeHeight: anObject [
	codeHeight := anObject
]

{ #category : #'api - instantiation' }
Gt2ExamplePreviewStencil >> create [
	<return: #BlElement>

	| aContainer aPreviewContainerElement |
	aContainer := BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c margin: (BlInsets top: 0 left: 20 bottom: 0 right: 20).
			c horizontal matchParent.
			c vertical fitContent ].
	aPreviewContainerElement := self newContainerWithHeight: self previewHeight.
	self noCode ifFalse: [ 
		| aCodeElement |
		aCodeElement := self newCodeElement.
		"self isCodeHeightDefined ifTrue: [ 
			aCodeElement constraintsDo: [ :c | c vertical exact: self codeHeight ] ]."
		aCodeElement when: GtPhlowObjectToSpawn do: [ :anEvent | 
			anEvent consumed: true.
			self updatePreviewElement: aPreviewContainerElement in: aContainer with: anEvent object ].
		aContainer addChild: aCodeElement ].
	self isPreviewExpected ifTrue: [ 
		self updatePreviewElement: aPreviewContainerElement in: aContainer with: self result ].
	^ aContainer
]

{ #category : #accessing }
Gt2ExamplePreviewStencil >> example [
	^ example
]

{ #category : #accessing }
Gt2ExamplePreviewStencil >> example: anObject [
	example := anObject
]

{ #category : #accessing }
Gt2ExamplePreviewStencil >> exampleWithResult [
	^ exampleWithResult ifNil: [ exampleWithResult := self example run ]
]

{ #category : #initialization }
Gt2ExamplePreviewStencil >> initialize [
	super initialize.
	codeExpanded := true.
	codeHeight := self constants defaultCodeHeight.
	noCode := false.
	example := (Gt2DocumentExamples >> #documentWithExistingExample) gtExample.
	exampleWithResult := nil.
	previewExpanded := self constants defaultPreviewExpanded.
	previewHeight := self constants defaultPreviewHeight.
	previewShowSelector := self constants defaultShowSelector.
]

{ #category : #testing }
Gt2ExamplePreviewStencil >> isCodeHeightDefined [
	^ self codeHeight isZero not
]

{ #category : #testing }
Gt2ExamplePreviewStencil >> isPreviewExpected [
	^ self previewExpanded or: [ self noCode ]
]

{ #category : #'instance creation' }
Gt2ExamplePreviewStencil >> newCodeElement [
	<return: #BlElement>
	^ ((GtMethodCoder forExample: self example) expanded: self codeExpanded) asElement
]

{ #category : #'instance creation' }
Gt2ExamplePreviewStencil >> newContainerWithHeight: aHeightNumber [
	| aContainer |
	aContainer := BlElement new.
	^ aContainer
		layout: BlLinearLayout vertical;
		look: Gt2PreviewLook + BrShadowLook;
		addChild: (BrResizer new
			target: aContainer;
			"addEventHandlerOn: BlDoubleClickEvent do: [ :anEvent |
				aResizableElement constraintsDo: [ :c | c vertical fitContent ] ]; "
			beBottom;
			look: BrGlamorousResizerLook;
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c ignored horizontal weight: 0.5 ]);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: aHeightNumber ]
]

{ #category : #'instance creation' }
Gt2ExamplePreviewStencil >> newPreviewElementFor: anObject [
	<return: #BlElement>
	| aView |
	aView := GtPhlowView on: anObject perform: self previewShowSelector.
	^ aView asElementDo: [ :anElement | anElement ]
]

{ #category : #accessing }
Gt2ExamplePreviewStencil >> noCode [
	^ noCode
]

{ #category : #accessing }
Gt2ExamplePreviewStencil >> noCode: anObject [
	noCode := anObject
]

{ #category : #accessing }
Gt2ExamplePreviewStencil >> previewExpanded [
	^ previewExpanded
]

{ #category : #accessing }
Gt2ExamplePreviewStencil >> previewExpanded: anObject [
	previewExpanded := anObject
]

{ #category : #accessing }
Gt2ExamplePreviewStencil >> previewHeight [
	^ previewHeight
]

{ #category : #accessing }
Gt2ExamplePreviewStencil >> previewHeight: anObject [
	previewHeight := anObject
]

{ #category : #accessing }
Gt2ExamplePreviewStencil >> previewShowSelector [
	^ previewShowSelector
]

{ #category : #accessing }
Gt2ExamplePreviewStencil >> previewShowSelector: anObject [
	previewShowSelector := anObject
]

{ #category : #accessing }
Gt2ExamplePreviewStencil >> result [
	^ self exampleWithResult returnValueOrExampleException
]

{ #category : #private }
Gt2ExamplePreviewStencil >> updatePreviewElement: aPreviewContainerElement in: aWholeContainer with: anObject [
	| aNewPreview |
	aNewPreview := self newPreviewElementFor: anObject.
	aNewPreview constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	aPreviewContainerElement removeChildNamed: #preview.
	aPreviewContainerElement addChild: aNewPreview at: 1 as: #preview.
	aPreviewContainerElement hasParent ifFalse: [ 
		aWholeContainer addChild: aPreviewContainerElement ].
	
]
