Class {
	#name : 'GtStylerStrategy',
	#superclass : 'Object',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'GToolkit-Documenter-Styler'
}

{ #category : 'cleanup' }
GtStylerStrategy class >> cleanUp [
	self resetUniqueInstance
]

{ #category : 'instance creation' }
GtStylerStrategy class >> displayMarkup [
	^ GtStyleWithMarkupStrategy uniqueInstance
]

{ #category : 'instance creation' }
GtStylerStrategy class >> hideMarkup [
	^ GtStyleWithoutMarkupStrategy uniqueInstance
]

{ #category : 'instance creation' }
GtStylerStrategy class >> noInteractions [
	^ GtStyleWithoutInteractionsStrategy uniqueInstance
]

{ #category : 'cleanup' }
GtStylerStrategy class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : 'accessing' }
GtStylerStrategy class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : 'testing' }
GtStylerStrategy >> isEditing [
	^ false
]

{ #category : 'testing' }
GtStylerStrategy >> isNoInteractions [
	^ false
]

{ #category : 'testing' }
GtStylerStrategy >> isReading [
	^ false
]

{ #category : 'dispatch' }
GtStylerStrategy >> styleText: aBlRope withNode: aPRDocumentItem [
	self subclassResponsibility
]
