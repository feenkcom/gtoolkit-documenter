Class {
	#name : #GtNullListItemStyler,
	#superclass : #GtListItemStyler,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #cleanup }
GtNullListItemStyler class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #cleanup }
GtNullListItemStyler class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
GtNullListItemStyler class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #style }
GtNullListItemStyler >> adornListItemSymbolInMarkupViewModeInContext: aGtStyledListItemBuilder [
	"do nothing"
]

{ #category : #style }
GtNullListItemStyler >> adornListItemSymbolInNoMarkupViewModeInContext: aGtStyledListItemBuilder [
	"do nothing"
]
