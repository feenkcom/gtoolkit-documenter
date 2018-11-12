Class {
	#name : #Gt2ExamplePreviewAttribute,
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
		'previewShowSelector'
	],
	#category : #'GToolkit-NewDocumenter-Text - Attributes'
}

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> affect: aBrText in: anEditorElement [
	^ Gt2ExamplePreviewStencil new
			example: self example;
			codeExpanded: self codeExpanded;
			codeHeight: self codeHeight;
			noCode: self noCode;
			previewExpanded: self previewExpanded;
			previewShowSelector: self previewShowSelector;
			previewHeight: self previewHeight;
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
	noCode := true.
	example := (Gt2DocumentExamples >> #documentWithExistingExample) gtExample.
	previewExpanded := self constants defaultPreviewExpanded.
	previewHeight := self constants defaultPreviewHeight.
	previewShowSelector := self constants defaultShowSelector.
	
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> noCode [
	^ noCode
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> noCode: anObject [
	noCode := anObject
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> previewExpanded [
	^ previewExpanded
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> previewExpanded: anObject [
	previewExpanded := anObject
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> previewHeight [
	^ previewHeight
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> previewHeight: anObject [
	previewHeight := anObject
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> previewShowSelector [
	^ previewShowSelector
]

{ #category : #accessing }
Gt2ExamplePreviewAttribute >> previewShowSelector: anObject [
	previewShowSelector := anObject
]
