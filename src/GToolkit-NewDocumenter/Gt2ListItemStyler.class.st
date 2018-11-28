Class {
	#name : #Gt2ListItemStyler,
	#superclass : #Object,
	#traits : 'TBlDebug + TGt2DocumentConstants + TGt2DocumentUtility',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait + TGt2DocumentUtility classTrait',
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #'as yet unclassified' }
Gt2ListItemStyler >> cursorLeftInText: aBlRope forNode: aPRListItem [
]

{ #category : #'as yet unclassified' }
Gt2ListItemStyler >> cursorNearbyInText: aBlRope forNode: aPRListItem [
]

{ #category : #accessing }
Gt2ListItemStyler >> styleTextWithMarkup: aBlRope forNode: aPRListItem [ 
	self subclassResponsibility
]

{ #category : #accessing }
Gt2ListItemStyler >> styleTextWithoutMarkup: aBlRope forNode: aPRListItem [ 
	self styleTextWithMarkup: aBlRope forNode: aPRListItem
]
