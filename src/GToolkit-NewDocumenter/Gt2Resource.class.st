Class {
	#name : #Gt2Resource,
	#superclass : #Object,
	#instVars : [
		'source',
		'name'
	],
	#category : #'GToolkit-NewDocumenter-Resourcer'
}

{ #category : #comparing }
Gt2Resource >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	(anObject isKindOf: Gt2Resource) ifFalse: [ ^ false ].
	^ name = anObject name
]

{ #category : #comparing }
Gt2Resource >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ name hash
]

{ #category : #accessing }
Gt2Resource >> name [
	^ name
]

{ #category : #accessing }
Gt2Resource >> name: aString [
	self 
		assert: [ aString notNil ]
		description: [ 'Resource name must be non-nil' ].
	name := aString
]

{ #category : #printing }
Gt2Resource >> printOn: aStream [
	super printOn: aStream.
	self name ifNil: [ ^ self ].
	aStream 
		nextPut: $(;
		print: self name;
		nextPut: $)
]

{ #category : #accessing }
Gt2Resource >> source [
	<return: #Gt2Document>
	^ source
]

{ #category : #accessing }
Gt2Resource >> source: aGtDocument [
	self 
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document must be non-nil' ].
	source := aGtDocument
]
