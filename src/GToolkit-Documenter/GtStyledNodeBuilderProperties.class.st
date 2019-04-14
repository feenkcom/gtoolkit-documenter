Class {
	#name : #GtStyledNodeBuilderProperties,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'GToolkit-Documenter-Styler Builder'
}

{ #category : #'accessing - document properties' }
GtStyledNodeBuilderProperties >> action [
	^ self at: #action
]

{ #category : #'accessing - document properties' }
GtStyledNodeBuilderProperties >> action: anAction [
	^ self at: #action put: anAction
]

{ #category : #'accessing - basic properties' }
GtStyledNodeBuilderProperties >> at: aSymbol [
	^ self collection 
		at: aSymbol 
		ifAbsent: [ self error: 'Property must be set before using it' ]
]

{ #category : #'accessing - basic properties' }
GtStyledNodeBuilderProperties >> at: aSymbol ifAbsentPut: aValue [
	^ self collection 
		at: aSymbol 
		ifAbsentPut: aValue
]

{ #category : #'accessing - basic properties' }
GtStyledNodeBuilderProperties >> at: aSymbol put: aValue [
	^ self collection 
		at: aSymbol 
		put: aValue
]

{ #category : #accessing }
GtStyledNodeBuilderProperties >> collection [
	^ collection
]

{ #category : #accessing }
GtStyledNodeBuilderProperties >> collection: anObject [
	collection := anObject
]

{ #category : #'accessing - common properties' }
GtStyledNodeBuilderProperties >> cursorEnterAction [
	^ self at: #cursorEnterAction
]

{ #category : #'accessing - common properties' }
GtStyledNodeBuilderProperties >> cursorEnterAction: anAction [
	self at: #cursorEnterAction put: anAction
]

{ #category : #'accessing - common properties' }
GtStyledNodeBuilderProperties >> cursorLeaveAction [
	^ self at: #cursorLeaveAction
]

{ #category : #'accessing - common properties' }
GtStyledNodeBuilderProperties >> cursorLeaveAction: anAction [
	self at: #cursorLeaveAction put: anAction
]

{ #category : #initialization }
GtStyledNodeBuilderProperties >> initialize [
	super initialize.
	collection := Dictionary new.
]

{ #category : #'accessing - document properties' }
GtStyledNodeBuilderProperties >> name [
	^ self at: #name
]

{ #category : #'accessing - document properties' }
GtStyledNodeBuilderProperties >> name: aString [
	^ self at: #name put: aString
]
