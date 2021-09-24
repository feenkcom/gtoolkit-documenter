"
I am a ${class:BrGlamorousEditorLook}$ look.
I set a normal font size in ${class:GtDocumenterStyler}$ when changed.
I am used by ${class:GtDocumenterEditor}$.

"
Class {
	#name : 'GtDocumenterEditorAptitude',
	#superclass : 'BrGlamorousEditorAptitude',
	#instVars : [
		'normalFontSize'
	],
	#category : 'GToolkit-Documenter-! Editor - Look'
}

{ #category : 'defaults' }
GtDocumenterEditorAptitude >> defaultFontSize [
	^ 16
]

{ #category : 'initialization' }
GtDocumenterEditorAptitude >> initialize [
	super initialize.
	normalFontSize := self defaultFontSize.
	self 
		glamorousRegularFont;
		fontSize: self normalFontSize.
	self add: BrLayoutResizerAptitude inherit.
]

{ #category : 'initialization' }
GtDocumenterEditorAptitude >> initializeListeners [
	super initializeListeners.
	
	self 
		when: GtDocumenterNormalFontSizeChanged 
		do: [ :anEvent | self normalFontSize: anEvent normalFontSize ].
]

{ #category : 'initialization' }
GtDocumenterEditorAptitude >> initializeRequests [
	super initializeRequests.

	self request: GtDocumenterNormalFontSizeRequest new.
]

{ #category : 'accessing' }
GtDocumenterEditorAptitude >> normalFontSize [
	^ normalFontSize
]

{ #category : 'accessing' }
GtDocumenterEditorAptitude >> normalFontSize: aNumber [
	normalFontSize := aNumber.
	self onNormalFontSizeChanged.
]

{ #category : 'hooks' }
GtDocumenterEditorAptitude >> onNormalFontSizeChanged [
	self widgetDo: [ :aWidget | 
		aWidget styler fontSize: self normalFontSize.
		aWidget styleTextRequest ]
]
