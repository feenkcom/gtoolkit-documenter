Class {
	#name : #Gt2NullListItemStyler,
	#superclass : #Gt2ListItemStyler,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #cleanup }
Gt2NullListItemStyler class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #cleanup }
Gt2NullListItemStyler class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
Gt2NullListItemStyler class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
Gt2NullListItemStyler >> style: aBlRope at: aPRListItem [ 
]
