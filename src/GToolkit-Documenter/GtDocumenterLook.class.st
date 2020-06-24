Class {
	#name : #GtDocumenterLook,
	#superclass : #BrGlamorousEditorLook,
	#instVars : [
		'normalFontSize'
	],
	#category : #'GToolkit-Documenter-! Core'
}

{ #category : #defaults }
GtDocumenterLook >> defaultFontSize [
	^ 16
]

{ #category : #initialization }
GtDocumenterLook >> initialize [
	super initialize.
	normalFontSize := self defaultFontSize.
	self 
		glamorousRegularFont;
		fontSize: self normalFontSize.
]

{ #category : #initialization }
GtDocumenterLook >> initializeListeners [
	super initializeListeners.
	
	self 
		when: GtDocumenterNormalFontSizeChanged 
		do: [ :anEvent | self normalFontSize: anEvent normalFontSize ].
]

{ #category : #initialization }
GtDocumenterLook >> initializeRequests [
	super initializeRequests.

	self request: GtDocumenterNormalFontSizeRequest new.
]

{ #category : #accessing }
GtDocumenterLook >> normalFontSize [
	^ normalFontSize
]

{ #category : #accessing }
GtDocumenterLook >> normalFontSize: aNumber [
	normalFontSize := aNumber.
	self onNormalFontSizeChanged.
]

{ #category : #hooks }
GtDocumenterLook >> onNormalFontSizeChanged [
	self widgetDo: [ :aWidget | aWidget styleTextRequest ]
]
