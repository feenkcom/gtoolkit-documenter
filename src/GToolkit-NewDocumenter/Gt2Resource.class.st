Class {
	#name : #Gt2Resource,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'document',
		'name',
		'resource'
	],
	#category : #'GToolkit-NewDocumenter-Resourcer'
}

{ #category : #accessing }
Gt2Resource >> document [
	<return: #Gt2Document>
	^ document
]

{ #category : #accessing }
Gt2Resource >> document: aGtDocument [
	self 
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document must be non-nil' ].
	document := aGtDocument
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
Gt2Resource >> resource [
	^ resource
]

{ #category : #accessing }
Gt2Resource >> resource: anObject [
	self 
		assert: [ anObject notNil ]
		description: [ 'Resource must be non-nil' ].
	resource := anObject
]
