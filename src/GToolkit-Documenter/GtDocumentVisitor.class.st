Class {
	#name : #GtDocumentVisitor,
	#superclass : #PRVisitor,
	#traits : 'TBlDebug + TGtDocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGtDocumentConstants classTrait',
	#instVars : [
		'document',
		'codeblockCounter'
	],
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #accessing }
GtDocumentVisitor >> document [
	<return: #GtDocument>
	self
		assert: [ document isNotNil ] 
		description: [ 'Document instance must be itialized before using it' ].
	^ document
]

{ #category : #accessing }
GtDocumentVisitor >> document: aGtDocument [
	self
		assert: [ document isNil ] 
		description: [ 'Document instance must be initialized only once' ].
	self
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document instance must be non-nil' ].
	document := aGtDocument
]

{ #category : #initialization }
GtDocumentVisitor >> initialize [
	super initialize.
	codeblockCounter := 0.
]

{ #category : #'visiting-document' }
GtDocumentVisitor >> visitCodeblock: aPRCodeblock [
	codeblockCounter := codeblockCounter + 1.
	aPRCodeblock counter: codeblockCounter.
	super visitCodeblock: aPRCodeblock
]
