Class {
	#name : #GtDocument,
	#superclass : #Object,
	#traits : 'GtAssertingTrait',
	#classTraits : 'GtAssertingTrait classTrait',
	#instVars : [
		'globalBindings',
		'systemChangesHandler',
		'documentParts'
	],
	#category : #'GToolkit-Documenter-Core'
}

{ #category : #'as yet unclassified' }
GtDocument >> addCodeSnippet: aGtPillarDocumentExecutablePart [ 
	documentParts 
		insertScript: aGtPillarDocumentExecutablePart 
		at: aGtPillarDocumentExecutablePart index.
	"aGtPillarDocumentExecutablePart index + 1 to: documentParts size do: [ :anIndex | 
		(documentParts codeSnippetAt: anIndex) index: anIndex ]."
]

{ #category : #accessing }
GtDocument >> documentParts [
	^ documentParts
]

{ #category : #accessing }
GtDocument >> globalBindings [
	<return: #GtPlaygroundBindings>
	^ globalBindings
]

{ #category : #'gt-extension' }
GtDocument >> gtDocumentPartsFor: aView [
	<gtView>
	^ (self documentParts gtDocumentPartsFor: aView)
]

{ #category : #initialization }
GtDocument >> initialize [
	super initialize.
	documentParts := GtDocumentParts new.
	globalBindings := GtPlaygroundBindings new.
	globalBindings 
		at: GtDocumenterConstants resultsVariableName 
		put: documentParts.
	systemChangesHandler := GtSystemChangesHandler new.
]

{ #category : #accessing }
GtDocument >> systemChangesHandler [
	^ systemChangesHandler
]
