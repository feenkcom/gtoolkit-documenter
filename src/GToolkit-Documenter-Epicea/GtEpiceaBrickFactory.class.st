Class {
	#name : #GtEpiceaBrickFactory,
	#superclass : #Object,
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'GToolkit-Documenter-Epicea'
}

{ #category : #accessing }
GtEpiceaBrickFactory class >> default [
	^ defaultInstance ifNil: [ defaultInstance := self new ]
]

{ #category : #strings }
GtEpiceaBrickFactory >> emphasizedStringFor: aString [
	
	^ BlTextElement new
		text: (aString asRopedText bold)
]

{ #category : #colors }
GtEpiceaBrickFactory >> softerTextColor [

	^ self textColor mixed: 0.1 with: Color gray
]

{ #category : #strings }
GtEpiceaBrickFactory >> stringFor: aString [

	^ BlTextElement new
		text: aString asRopedText
]

{ #category : #strings }
GtEpiceaBrickFactory >> stringFor: aString color: aColor [

	^ BlTextElement new
		text: (aString asRopedText foreground: aColor)
]

{ #category : #colors }
GtEpiceaBrickFactory >> textColor [

	^ Smalltalk ui theme textColor
]
