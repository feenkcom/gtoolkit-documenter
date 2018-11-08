Class {
	#name : #Gt2ExamplePreviewAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#instVars : [
		'example',
		'codeExpanded',
		'codeHeight',
		'codeShow',
		'resultShowSelector',
		'resultHeight'
	],
	#category : #'GToolkit-NewDocumenter-Text - Attributes'
}

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> affect: aBrText in: anEditorElement [
	^ Gt2ExamplePreviewStencil new
			example: self example;
			codeExpanded: self codeExpanded;
			codeHeight: self codeHeight;
			codeShow: self codeShow;
			resultShowSelector: self resultShowSelector;
			resultHeight: self resultHeight;
			asElement
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> codeExpanded [
	^ codeExpanded
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> codeExpanded: anObject [
	codeExpanded := anObject
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> codeHeight [
	^ codeHeight
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> codeHeight: anObject [
	codeHeight := anObject
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> codeShow [
	^ codeShow
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> codeShow: anObject [
	codeShow := anObject
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> example [
	^ example
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> example: anObject [
	example := anObject
]

{ #category : #initialization }
Gt2ExamplePreviewAttribute >> initialize [
	super initialize.
	codeExpanded := true.
	codeHeight := self constants defaultPreviewHeight.
	codeShow := true.
	example := (Gt2DocumentExamples >> #documentWithExistingExample) gtExample.
	resultHeight := self constants defaultPreviewHeight.
	resultShowSelector := self constants defaultShowSelector.
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> resultHeight [
	^ resultHeight
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> resultHeight: anObject [
	resultHeight := anObject
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> resultShowSelector [
	^ resultShowSelector
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> resultShowSelector: anObject [
	resultShowSelector := anObject
]
