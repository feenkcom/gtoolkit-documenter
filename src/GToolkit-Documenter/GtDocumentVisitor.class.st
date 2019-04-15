Class {
	#name : #GtDocumentVisitor,
	#superclass : #PRVisitor,
	#traits : 'TBlDebug + TGt2DocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait',
	#instVars : [
		'document',
		'codeblockCounter'
	],
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #accessing }
GtDocumentVisitor >> document [
	<return: #GtDocument>
	^ document
]

{ #category : #accessing }
GtDocumentVisitor >> document: aGt2Document [
	self 
		assert: [ aGt2Document notNil ]
		description: [ 'Document must be non-nil' ].
	document := aGt2Document
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
