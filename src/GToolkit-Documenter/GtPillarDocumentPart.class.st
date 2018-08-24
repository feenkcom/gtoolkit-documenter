Class {
	#name : #GtPillarDocumentPart,
	#superclass : #Object,
	#traits : 'GtAssertingTrait + GtAnnouncerTrait',
	#classTraits : 'GtAssertingTrait classTrait + GtAnnouncerTrait classTrait',
	#instVars : [
		'document',
		'announcer',
		'pillarNode'
	],
	#category : 'GToolkit-Documenter-Pillar'
}

{ #category : #'instance creation' }
GtPillarDocumentPart class >> document: aGtDocument pillarNode: aGtPillarExampleAnnotation [ 
	^ self new 
		document: aGtDocument;
		pillarNode: aGtPillarExampleAnnotation
]

{ #category : #accessing }
GtPillarDocumentPart >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #accessing }
GtPillarDocumentPart >> document [
	<return: #GtDocument>
	self
		assert: [ document notNil ]
		description: [ 'Document has to be initialized first' ].
	^ document
]

{ #category : #accessing }
GtPillarDocumentPart >> document: aGtDocument [
	document ifNotNil: [ :anOldDocument | self unsubscribeFromDocument: anOldDocument ].
	self
		assert: [ aGtDocument notNil ]
		description: [ 'Document has to be initialized' ].
	document := aGtDocument.
	self subscribeToDocument: aGtDocument
]

{ #category : #accessing }
GtPillarDocumentPart >> index [
	<return: #Integer>
	| aCollection aResult |
	self
		assert: [ self pillarNode notNil ]
		description: [ 'Pillar node has to be initialized first' ].
	self 
		assert: [ self pillarNode counter notNil ]
		description: [ 'Pillar node counter has to be initialized first' ].
	self 
		assert: [ self pillarNode counter isValidCounter ]
		description: [ 'Pillar node counter has to be a valid counter' ].
	aCollection := self pillarNode counter elements.
	aResult := 0.
	aCollection withIndexDo: [ :aValue :anIndex |
		aResult := aResult + (aValue * (10 raisedTo: (aCollection size - anIndex))) ].
	^ aResult 
]

{ #category : #initialization }
GtPillarDocumentPart >> initialize [
	super initialize.
	announcer := Announcer new.
]

{ #category : #accessing }
GtPillarDocumentPart >> pillarNode [
	<return: #PRDocumentItem>
	self
		assert: [ pillarNode notNil ]
		description: [ 'Pillar node has to be initialized first' ].
	^ pillarNode
]

{ #category : #accessing }
GtPillarDocumentPart >> pillarNode: aPRDocumentItem [
	self
		assert: [ aPRDocumentItem notNil ]
		description: [ 'Pillar node has to be initialized' ].
	pillarNode := aPRDocumentItem
]

{ #category : #printing }
GtPillarDocumentPart >> printOn: aStream [
	super printOn: aStream.
	self pillarNode ifNil: [ ^ self ].
	aStream
		nextPutAll: '[index=';
		print: self index;
		nextPutAll: ']'
]

{ #category : #private }
GtPillarDocumentPart >> subscribeToDocument: aGtDocument [ 
	"Subclasses can register for document and system changes."
	self 
		assert: [ aGtDocument notNil ] 
		description: [ 'Document has to be initialized' ].
]

{ #category : #private }
GtPillarDocumentPart >> unsubscribeFromDocument: aGtDocument [ 
	self 
		assert: [ aGtDocument notNil ] 
		description: [ 'Document has to be initialized' ].
	aGtDocument systemChangesHandler unsubscribe: self.
]
