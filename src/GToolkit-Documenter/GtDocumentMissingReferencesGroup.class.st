Class {
	#name : #GtDocumentMissingReferencesGroup,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'missingReferences'
	],
	#category : #'GToolkit-Documenter-Validation'
}

{ #category : #adding }
GtDocumentMissingReferencesGroup >> addMissingReferences: aMissingReferencesResult [
	missingReferences add: aMissingReferencesResult
]

{ #category : #enumerating }
GtDocumentMissingReferencesGroup >> collect: aBlock [
	^ missingReferences collect: aBlock
]

{ #category : #ui }
GtDocumentMissingReferencesGroup >> gtItemsFor: aView [
	<gtView>
	^ aView list 
		title: 'Documents';
		items: [ missingReferences ];
		itemFormat: [ :aResult | aResult documentSource ];
		send: [:aResult | aResult documentSource ]
]

{ #category : #initialization }
GtDocumentMissingReferencesGroup >> initialize [
	super initialize.
	missingReferences := OrderedCollection new.
]

{ #category : #testing }
GtDocumentMissingReferencesGroup >> isEmpty [
	^ missingReferences isEmpty
]

{ #category : #accessing }
GtDocumentMissingReferencesGroup >> size [
	^ missingReferences size
]
