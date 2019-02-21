Class {
	#name : #GtCursorActivityVisitor,
	#superclass : #PRVisitor,
	#traits : 'TBlDebug + TGt2DocumentConstants + TGt2DocumentUtility',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait + TGt2DocumentUtility classTrait',
	#instVars : [
		'text'
	],
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #accessing }
GtCursorActivityVisitor class >> constants [
	^ GtDocumentConstants
]

{ #category : #private }
GtCursorActivityVisitor class >> utility [
	^ GtDocumentUtility
]

{ #category : #accessing }
GtCursorActivityVisitor >> constants [
	^ GtDocumentConstants
]

{ #category : #accessing }
GtCursorActivityVisitor >> text [
	^ text
]

{ #category : #accessing }
GtCursorActivityVisitor >> text: anObject [
	text := anObject
]

{ #category : #private }
GtCursorActivityVisitor >> utility [
	^ GtDocumentUtility
]
