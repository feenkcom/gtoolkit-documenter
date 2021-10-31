Class {
	#name : #GtPhlowDocumentView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'textBuilder'
	],
	#category : 'GToolkit-Documenter-Phlow'
}

{ #category : #converting }
GtPhlowDocumentView >> asElementDo: aBlock [
	| anElement aText |
	anElement := GtDocumenter new.
	aText := (self textBuilder glamourValueWithArgs: { anElement }) asRopedText.
	anElement text: aText.
	^ aBlock value: anElement
]

{ #category : #initialization }
GtPhlowDocumentView >> initialize [
	super initialize.
	textBuilder := [ :anElement :anDocument | '' ].
]

{ #category : #accessing }
GtPhlowDocumentView >> text: aValuable [
	textBuilder := aValuable
]

{ #category : #accessing }
GtPhlowDocumentView >> textBuilder [
	^ textBuilder
]
