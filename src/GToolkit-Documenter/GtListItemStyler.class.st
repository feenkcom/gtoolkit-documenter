Class {
	#name : #GtListItemStyler,
	#superclass : #Object,
	#traits : 'TBlDebug + TLepiterConstants',
	#classTraits : 'TBlDebug classTrait + TLepiterConstants classTrait',
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #accessing }
GtListItemStyler class >> constants [
	^ GtDocumentConstants
]

{ #category : #private }
GtListItemStyler class >> utility [
	^ GtDocumentUtility
]

{ #category : #style }
GtListItemStyler >> adornListItemSymbolInMarkupViewModeInContext: aGtStyledListItemBuilder [
	self subclassResponsibility
]

{ #category : #style }
GtListItemStyler >> adornListItemSymbolInNoMarkupViewModeInContext: aGtStyledListItemBuilder [
	"Style a list item symbol in no-markup view mode 
	(as it should be visible in a VISIWIG editor)"
	self subclassResponsibility
]

{ #category : #'style - cursor' }
GtListItemStyler >> clearAdornmentsInContext: aGtStyledListItemBuilder [
	"Clear all list item symbol adornments"
	(aGtStyledListItemBuilder listItemSymbolText)
			clearAttributes: [ :eachAttribute | 
				eachAttribute class = BrTextAdornmentDynamicAttribute ].
]

{ #category : #accessing }
GtListItemStyler >> constants [
	^ GtDocumentConstants
]

{ #category : #style }
GtListItemStyler >> updateForNewListItem [
	"Update what every is needed to style new list item"
]
