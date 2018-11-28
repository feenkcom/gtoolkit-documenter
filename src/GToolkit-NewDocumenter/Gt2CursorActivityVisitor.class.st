Class {
	#name : #Gt2CursorActivityVisitor,
	#superclass : #PRVisitor,
	#traits : 'TBlDebug + TGt2DocumentConstants + TGt2DocumentUtility',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait + TGt2DocumentUtility classTrait',
	#instVars : [
		'text'
	],
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #accessing }
Gt2CursorActivityVisitor >> text [
	^ text
]

{ #category : #accessing }
Gt2CursorActivityVisitor >> text: anObject [
	text := anObject
]
