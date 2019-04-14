Class {
	#name : #GtStyledNodeBuilderProperties,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'GToolkit-Documenter-Styler Builder'
}

{ #category : #'accessing - common properties' }
GtStyledNodeBuilderProperties >> action [
	^ self at: #action
]

{ #category : #'accessing - common properties' }
GtStyledNodeBuilderProperties >> action: anAction [
	^ self at: #action put: anAction
]

{ #category : #'accessing - properties' }
GtStyledNodeBuilderProperties >> at: aSymbol [
	^ self collection 
		at: aSymbol 
		ifAbsent: [ self error: 'Property must be set before using it' ]
]

{ #category : #'accessing - properties' }
GtStyledNodeBuilderProperties >> at: aSymbol ifAbsentPut: aValue [
	^ self collection 
		at: aSymbol 
		ifAbsentPut: aValue
]

{ #category : #'accessing - properties' }
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

{ #category : #initialization }
GtStyledNodeBuilderProperties >> initialize [
	super initialize.
	collection := Dictionary new.
]

{ #category : #'accessing - common properties' }
GtStyledNodeBuilderProperties >> name [
	^ self at: #name
]

{ #category : #'accessing - common properties' }
GtStyledNodeBuilderProperties >> name: aString [
	^ self at: #name put: aString
]
