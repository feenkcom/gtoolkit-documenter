Class {
	#name : #Gt2ExamplePreviewStencil,
	#superclass : #BrStencil,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#instVars : [
		'example',
		'codeExpanded',
		'codeHeight',
		'exampleWithResult',
		'noCode',
		'previewHeight',
		'previewShowSelector'
	],
	#category : #'GToolkit-NewDocumenter-Brick - Stencils'
}

{ #category : #private }
Gt2ExamplePreviewStencil >> codeElement [
	<return: #BlElement>
	^ ((GtMethodCoder forExample: self example) expanded: self codeExpanded) asElement
]

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

	| aContainer |
	aContainer := BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c margin: (BlInsets top: 0 left: 20 bottom: 0 right: 20).
			c horizontal matchParent.
			c vertical fitContent ].
	self noCode ifFalse: [ aContainer addChild: self codeElement ].
	aContainer addChild: self resultElement.
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
	codeHeight := self constants defaultPreviewHeight.
	noCode := true.
	example := (Gt2DocumentExamples >> #documentWithExistingExample) gtExample.
	exampleWithResult := nil.
	previewHeight := self constants defaultPreviewHeight.
	previewShowSelector := self constants defaultShowSelector.
]

{ #category : #'instance creation' }
Gt2ExamplePreviewStencil >> newContainerFor: aWrappedElement height: aHeightNumber [
	| aContainer aResizableElement |
	aContainer := BlElement new.
	aResizableElement := BlElement new.
	^ aContainer
		layout: BlLinearLayout vertical;
		look: Gt2PreviewLook + BrShadowLook;
		addChild: (aResizableElement 
			addChild: aWrappedElement;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical exact: aHeightNumber ]);
		addChild: (BrResizer new
			target: aResizableElement;
			"addEventHandlerOn: BlDoubleClickEvent do: [ :anEvent |
				aResizableElement constraintsDo: [ :c | c vertical fitContent ] ]; "
			beBottom;
			look: BrGlamorousResizerLook;
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c ignored horizontal weight: 0.5 ]);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ]
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
Gt2ExamplePreviewStencil >> resultElement [
	<return: #BlElement>
	| aView |
	aView := GtPhlowView on: self result perform: self previewShowSelector.
	^ aView asElementDo:
		[ :anElement | self newContainerFor: anElement height: self previewHeight ]
]
