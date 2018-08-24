Class {
	#name : #GtPillarDocumentExecutablePart,
	#superclass : #GtPillarDocumentPart,
	#instVars : [
		'outBindings'
	],
	#category : 'GToolkit-Documenter-Pillar'
}

{ #category : #accessing }
GtPillarDocumentExecutablePart >> document: aGtDocument [
	super document: aGtDocument.
	outBindings bindings: aGtDocument globalBindings.
	aGtDocument addCodeSnippet: self.
]

{ #category : #testing }
GtPillarDocumentExecutablePart >> hasResult [
	^ outBindings hasResult
]

{ #category : #initialization }
GtPillarDocumentExecutablePart >> initialize [
	super initialize.
	outBindings := GtOutBindings new.
]

{ #category : #accessing }
GtPillarDocumentExecutablePart >> outBindings [
	<return: #GtOutBindings>
	^ outBindings
]

{ #category : #accessing }
GtPillarDocumentExecutablePart >> result [
	^ outBindings value
]
