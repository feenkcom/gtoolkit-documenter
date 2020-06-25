Class {
	#name : #GtDocumenterEditorLook,
	#superclass : #BrGlamorousEditorLook,
	#instVars : [
		'normalFontSize'
	],
	#category : #'GToolkit-Documenter-! Editor - Look'
}

{ #category : #defaults }
GtDocumenterEditorLook >> defaultFontSize [
	^ 16
]

{ #category : #initialization }
GtDocumenterEditorLook >> initialize [
	super initialize.
	normalFontSize := self defaultFontSize.
	self 
		glamorousRegularFont;
		fontSize: self normalFontSize.
	self add: BrLayoutResizerLook inherit.
]

{ #category : #initialization }
GtDocumenterEditorLook >> initializeListeners [
	super initializeListeners.
	
	self 
		when: GtDocumenterNormalFontSizeChanged 
		do: [ :anEvent | self normalFontSize: anEvent normalFontSize ].
]

{ #category : #initialization }
GtDocumenterEditorLook >> initializeRequests [
	super initializeRequests.

	self request: GtDocumenterNormalFontSizeRequest new.
]

{ #category : #accessing }
GtDocumenterEditorLook >> normalFontSize [
	^ normalFontSize
]

{ #category : #accessing }
GtDocumenterEditorLook >> normalFontSize: aNumber [
	normalFontSize := aNumber.
	self onNormalFontSizeChanged.
]

{ #category : #hooks }
GtDocumenterEditorLook >> onNormalFontSizeChanged [
	self widgetDo: [ :aWidget | 
		aWidget styler fontSize: self normalFontSize.
		aWidget styleTextRequest ]
]
