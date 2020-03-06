Class {
	#name : #GtPhlowDocumentView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'textBuilder'
	],
	#category : #'GToolkit-Documenter-Phlow'
}

{ #category : #converting }
GtPhlowDocumentView >> asElementDo: aBlock [
	| aDocument anElement aText |
	aDocument := GtDocument new.
	anElement := aDocument asElementWithoutSaveAction.
	aText := (self textBuilder glamourValueWithArgs: { anElement. aDocument }) asRopedText.
	aDocument text: aText.
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
