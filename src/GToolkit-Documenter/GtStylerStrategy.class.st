Class {
	#name : #GtStylerStrategy,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #'instance creation' }
GtStylerStrategy class >> displayMarkup [
	^ GtStyleWithMarkupStrategy uniqueInstance
]

{ #category : #'instance creation' }
GtStylerStrategy class >> hideMarkup [
	^ GtStyleWithoutMarkupStrategy uniqueInstance
]

{ #category : #testing }
GtStylerStrategy >> isEditing [
	^ false
]

{ #category : #testing }
GtStylerStrategy >> isReading [
	^ false
]

{ #category : #dispatch }
GtStylerStrategy >> styleText: aBlRope withNode: aPRDocumentItem [
	self subclassResponsibility
]
