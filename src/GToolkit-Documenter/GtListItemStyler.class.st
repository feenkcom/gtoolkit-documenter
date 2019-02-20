Class {
	#name : #GtListItemStyler,
	#superclass : #Object,
	#traits : 'TBlDebug + TGt2DocumentConstants + TGt2DocumentUtility',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait + TGt2DocumentUtility classTrait',
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

{ #category : #accessing }
GtListItemStyler >> constants [
	^ GtDocumentConstants
]

{ #category : #'as yet unclassified' }
GtListItemStyler >> cursorLeftInText: aBlRope forNode: aPRListItem [
]

{ #category : #'as yet unclassified' }
GtListItemStyler >> cursorNearbyInText: aBlRope forNode: aPRListItem [
]

{ #category : #accessing }
GtListItemStyler >> styleTextWithMarkup: aBlRope forNode: aPRListItem [ 
	self subclassResponsibility
]

{ #category : #accessing }
GtListItemStyler >> styleTextWithoutMarkup: aBlRope forNode: aPRListItem [ 
	self styleTextWithMarkup: aBlRope forNode: aPRListItem
]

{ #category : #private }
GtListItemStyler >> utility [
	^ GtDocumentUtility
]
