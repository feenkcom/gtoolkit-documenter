Class {
	#name : #GtEpiceaImpactChangedAnnouncement,
	#superclass : #GtCodeSnippetAnnouncement,
	#instVars : [
		'hasImpact'
	],
	#category : 'GToolkit-Documenter-Epicea'
}

{ #category : #'instance creation' }
GtEpiceaImpactChangedAnnouncement class >> document: aGtDocument codeSnippet: aGtDebuggableCodeSnippet withImpact: aBoolean [
	^ (self document: aGtDocument codeSnippet: aGtDebuggableCodeSnippet)
			hasImpact: aBoolean
]

{ #category : #accessing }
GtEpiceaImpactChangedAnnouncement >> hasImpact [
	^ hasImpact
]

{ #category : #accessing }
GtEpiceaImpactChangedAnnouncement >> hasImpact: aBoolean [
	self 
		assert: [ aBoolean = true or: [ aBoolean = false ] ]
		description: 'Value has to be a boolean.'.
	hasImpact := aBoolean
]

{ #category : #initialization }
GtEpiceaImpactChangedAnnouncement >> initialize [
	super initialize.
	hasImpact := false.
]
