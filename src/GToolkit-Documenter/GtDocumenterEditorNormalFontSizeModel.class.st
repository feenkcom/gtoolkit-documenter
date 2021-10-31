"
I hold normal font size of a document. The font size can be changed while reading and editing a document.
I am used by ${class:GtDocumenterEditor}$.

"
Class {
	#name : #GtDocumenterEditorNormalFontSizeModel,
	#superclass : #BrWidgetModel,
	#instVars : [
		'normalFontSize'
	],
	#category : 'GToolkit-Documenter-! Editor - Model'
}

{ #category : #'api - font size' }
GtDocumenterEditorNormalFontSizeModel >> decreaseNormalFontSize [
	self resizeNormalFontSizeBy: -2
]

{ #category : #defaults }
GtDocumenterEditorNormalFontSizeModel >> defaultFontSize [
	^ 16
]

{ #category : #'api - font size' }
GtDocumenterEditorNormalFontSizeModel >> increaseNormalFontSize [
	self resizeNormalFontSizeBy: 2
]

{ #category : #initialization }
GtDocumenterEditorNormalFontSizeModel >> initialize [
	super initialize.
	normalFontSize := self defaultFontSize.
]

{ #category : #initialization }
GtDocumenterEditorNormalFontSizeModel >> initializeListeners [
	super initializeListeners.
	
	self 
		when: GtDocumenterNormalFontSizeRequest 
		reply: [ :aResponse | aResponse normalFontSize: self normalFontSize ].
]

{ #category : #'api - font size' }
GtDocumenterEditorNormalFontSizeModel >> normalFontSize [
	"Return a normal text font size"
	^ normalFontSize
]

{ #category : #'api - font size' }
GtDocumenterEditorNormalFontSizeModel >> normalFontSize: aNumber [
	self 
		assert: [ aNumber isNotNil ] 
		description: [ 'Normal font size must be non-nil' ].
	self 
		assert: [ aNumber isNumber ] 
		description: [ 'Normal font size must be a number' ].
	normalFontSize = aNumber ifTrue: [ ^ self ].
	normalFontSize := aNumber.
	self notifyNormalFontSizeChanged.
]

{ #category : #notifying }
GtDocumenterEditorNormalFontSizeModel >> notifyNormalFontSizeChanged [
	self dispatchEvent: (GtDocumenterNormalFontSizeChanged new 
		normalFontSize: self normalFontSize)
]

{ #category : #'api - font size' }
GtDocumenterEditorNormalFontSizeModel >> resizeNormalFontSizeBy: anInteger [
	| aNewFontSize |
	self 
		assert: [ anInteger isInteger ] 
		description: [ 'Font size resize number must be an integer' ].
	aNewFontSize := (self normalFontSize + anInteger) max: 5.
	self normalFontSize: aNewFontSize
]
