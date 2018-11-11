Class {
	#name : #Gt2EpiceaBrickFactory,
	#superclass : #Object,
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'GToolkit-NewDocumenter-Epicea'
}

{ #category : #accessing }
Gt2EpiceaBrickFactory class >> default [
	^ defaultInstance ifNil: [ defaultInstance := self new ]
]

{ #category : #strings }
Gt2EpiceaBrickFactory >> emphasizedStringFor: aString [
	
	^ self stringFor: (aString asRopedText bold)
]

{ #category : #colors }
Gt2EpiceaBrickFactory >> softerTextColor [

	^ self textColor mixed: 0.1 with: Color gray
]

{ #category : #strings }
Gt2EpiceaBrickFactory >> stringFor: aString [

	^ BlTextElement new 
		text: aString asRopedText;
		padding: (BlInsets top: 0 left: 0 bottom: 0 right: 3);
		constraintsDo: [ :c | 
			c linear vertical alignCenter ]
]

{ #category : #strings }
Gt2EpiceaBrickFactory >> stringFor: aString color: aColor [

	^ self stringFor: (aString asRopedText foreground: aColor)
]

{ #category : #colors }
Gt2EpiceaBrickFactory >> textColor [

	^ Smalltalk ui theme textColor
]
