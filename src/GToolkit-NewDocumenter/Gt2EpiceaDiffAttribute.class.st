Class {
	#name : #Gt2EpiceaDiffAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#instVars : [
		'text'
	],
	#category : #'GToolkit-NewDocumenter-Epicea'
}

{ #category : #accessing }
Gt2EpiceaDiffAttribute >> affect: aBrText in: anEditorElement [
	^ BrLabel new text: self text
]

{ #category : #initialization }
Gt2EpiceaDiffAttribute >> beInsert [
	self text: self constants insertLineIdentificator asRopedText monospace.
	self text foreground: self constants insertLineColor.
]

{ #category : #initialization }
Gt2EpiceaDiffAttribute >> beMatch [
	self text: self constants matchLineIdentificator asRopedText monospace.
	self text foreground: self constants matchLineColor.
]

{ #category : #initialization }
Gt2EpiceaDiffAttribute >> beRemove [
	self text: self constants removeLineIdentificator asRopedText monospace.
	self text foreground: self constants removeLineColor.
]

{ #category : #initialization }
Gt2EpiceaDiffAttribute >> initialize [
	super initialize.
	self beMatch.
	self beAppend.
]

{ #category : #accessing }
Gt2EpiceaDiffAttribute >> text [
	^ text
]

{ #category : #accessing }
Gt2EpiceaDiffAttribute >> text: anObject [
	text := anObject
]
