Class {
	#name : 'GtResource',
	#superclass : 'Object',
	#instVars : [
		'source',
		'name'
	],
	#category : 'GToolkit-Documenter-Resourcer'
}

{ #category : 'comparing' }
GtResource >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	(anObject isKindOf: GtResource) ifFalse: [ ^ false ].
	^ name = anObject name
]

{ #category : 'comparing' }
GtResource >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ name hash
]

{ #category : 'testing' }
GtResource >> isDocument [
	^ false
]

{ #category : 'testing' }
GtResource >> isFigure [
	^ false
]

{ #category : 'testing' }
GtResource >> isFile [
	^ false
]

{ #category : 'accessing' }
GtResource >> name [
	^ name
]

{ #category : 'accessing' }
GtResource >> name: aString [
	self 
		assert: [ aString notNil ]
		description: [ 'Resource name must be non-nil' ].
	name := aString
]

{ #category : 'printing' }
GtResource >> printOn: aStream [
	super printOn: aStream.
	self name ifNil: [ ^ self ].
	aStream 
		nextPut: $(;
		print: self name;
		nextPut: $)
]

{ #category : 'accessing' }
GtResource >> source [
	<return: #GtDocumenter>
	^ source
]

{ #category : 'accessing' }
GtResource >> source: aGtDocument [
	self 
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document must be non-nil' ].
	source := aGtDocument
]
