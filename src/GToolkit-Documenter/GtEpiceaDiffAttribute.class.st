Class {
	#name : #GtEpiceaDiffAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#instVars : [
		'text'
	],
	#category : #'GToolkit-Documenter-Epicea'
}

{ #category : #accessing }
GtEpiceaDiffAttribute class >> constants [
	^ GtDocumentConstants
]

{ #category : #accessing }
GtEpiceaDiffAttribute >> affect: aBrText in: anEditorElement [
	^ BrLabel new
		text: self text;
		look: BrGlamorousLabelLook new
]

{ #category : #initialization }
GtEpiceaDiffAttribute >> beInsert [
	self text: self constants insertLineIdentificator asRopedText monospace.
	self text foreground: self constants insertLineColor.
]

{ #category : #initialization }
GtEpiceaDiffAttribute >> beMatch [
	self text: self constants matchLineIdentificator asRopedText monospace.
	self text foreground: self constants matchLineColor.
]

{ #category : #initialization }
GtEpiceaDiffAttribute >> beRemove [
	self text: self constants removeLineIdentificator asRopedText monospace.
	self text foreground: self constants removeLineColor.
]

{ #category : #accessing }
GtEpiceaDiffAttribute >> constants [
	^ GtDocumentConstants
]

{ #category : #initialization }
GtEpiceaDiffAttribute >> initialize [
	super initialize.
	self beMatch.
	self beAppend.
]

{ #category : #accessing }
GtEpiceaDiffAttribute >> text [
	^ text
]

{ #category : #accessing }
GtEpiceaDiffAttribute >> text: anObject [
	text := anObject
]
