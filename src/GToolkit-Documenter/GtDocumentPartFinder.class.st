Class {
	#name : #GtDocumentPartFinder,
	#superclass : #Object,
	#traits : 'GtAssertingTrait',
	#classTraits : 'GtAssertingTrait classTrait',
	#instVars : [
		'document',
		'pillarNode',
		'documentPartClass'
	],
	#category : 'GToolkit-Documenter-Utility'
}

{ #category : #accessing }
GtDocumentPartFinder >> document [
	^ document
]

{ #category : #accessing }
GtDocumentPartFinder >> document: anObject [
	document := anObject
]

{ #category : #accessing }
GtDocumentPartFinder >> documentPartAtSameIndex [
	<return: #GtPillarDocumentPart>
	| aDocumentPart |
	aDocumentPart := self document documentParts documentPartAt: self pillarNodeIndex.
	aDocumentPart pillarNode: self pillarNode.
	^ aDocumentPart
]

{ #category : #accessing }
GtDocumentPartFinder >> documentPartClass [
	^ documentPartClass
]

{ #category : #accessing }
GtDocumentPartFinder >> documentPartClass: aClass [
	self 
		assert: [ aClass notNil ] 
		description: [ 'Document part class has to be initialized' ].
	self 
		assert: [ aClass isClass ] 
		description: [ 'Document part class has to be a lass that instantiates objects' ].
	documentPartClass := aClass
]

{ #category : #actions }
GtDocumentPartFinder >> find [
	<return: #GtPillarDocumentPart>
	self 
		assert: [ self pillarNodeIndex <= (self numberOfDocumentParts + 1) ] 
		description: [ 'A code snippet was skipped' ].
	(self pillarNodeIndex = (self numberOfDocumentParts + 1))
		ifTrue: [ ^ self newDocumentPartAtSameIndex ].
	self hasSimilarSourceCodeAtSameIndex
		ifTrue: [ ^ self documentPartAtSameIndex ].
	self hasSimilarSourceCodeAtFollowingIndex
		ifTrue: [
			self removeScriptAtSameIndex. 
			^ self documentPartAtSameIndex ]. 
	^ self newDocumentPartAtSameIndex
]

{ #category : #testing }
GtDocumentPartFinder >> hasSimilarSourceCodeAtFollowingIndex [
	^ self numberOfDocumentParts > self pillarNodeIndex and: [ 
		(self pillarNodeAtFollowingIndex text = self pillarNode text) or: [ 
			self pillarNode text endsWith: self pillarNodeAtFollowingIndex text ] ]
]

{ #category : #testing }
GtDocumentPartFinder >> hasSimilarSourceCodeAtSameIndex [
	^ (self pillarNodeAtSameIndex text = self pillarNode text) or: [ 
		self pillarNode text endsWith: self pillarNodeAtSameIndex text ]
]

{ #category : #'instance creation' }
GtDocumentPartFinder >> newDocumentPartAtSameIndex [
	| aNewDocumentPart |
	aNewDocumentPart := self documentPartClass new.
	aNewDocumentPart 
		pillarNode: self pillarNode;
		document: self document.
	^ aNewDocumentPart
]

{ #category : #accessing }
GtDocumentPartFinder >> numberOfDocumentParts [
	<return: #Integer>
	^ self document documentParts size
]

{ #category : #accessing }
GtDocumentPartFinder >> pillarNode [
	^ pillarNode
]

{ #category : #accessing }
GtDocumentPartFinder >> pillarNode: anObject [
	pillarNode := anObject
]

{ #category : #accessing }
GtDocumentPartFinder >> pillarNodeAtFollowingIndex [
	<return: #PRDocumentItem>
	^ self document documentPartAt: self pillarNodeIndex + 1
]

{ #category : #accessing }
GtDocumentPartFinder >> pillarNodeAtSameIndex [
	<return: #PRDocumentItem>
	^ self documentPartAtSameIndex pillarNode
]

{ #category : #accessing }
GtDocumentPartFinder >> pillarNodeIndex [
	<return: #Integer>
	| aCollection aResult |
	aCollection := self pillarNode counter elements.
	aResult := 0.
	aCollection withIndexDo: [ :aValue :anIndex |
		aResult := aResult + (aValue * (10 raisedTo: (aCollection size - anIndex))) ].
	^ aResult 
]

{ #category : #removing }
GtDocumentPartFinder >> removeScriptAtSameIndex [
	self document documentParts remove: self documentPartAtSameIndex
]
