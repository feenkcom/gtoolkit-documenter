Class {
	#name : 'GtDocumentVisitor',
	#superclass : 'PRVisitor',
	#traits : 'TBlDebug + TGtDocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGtDocumentConstants classTrait',
	#instVars : [
		'document',
		'codeblockCounter',
		'figureCounter'
	],
	#category : 'GToolkit-Documenter-Styler'
}

{ #category : 'accessing' }
GtDocumentVisitor >> document [
	<return: #GtDocumenter>
	self
		assert: [ document isNotNil ] 
		description: [ 'Documenter instance must be itialized before using it' ].
	^ document
]

{ #category : 'accessing' }
GtDocumentVisitor >> document: aGtDocument [
	self
		assert: [ document isNil ] 
		description: [ 'Document instance must be initialized only once' ].
	self
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document instance must be non-nil' ].
	document := aGtDocument
]

{ #category : 'initialization' }
GtDocumentVisitor >> initialize [
	super initialize.
	codeblockCounter := 0.
	figureCounter := 0.
]

{ #category : 'visiting-document' }
GtDocumentVisitor >> visitCodeblock: aPRCodeblock [
	codeblockCounter := codeblockCounter + 1.
	aPRCodeblock counter: codeblockCounter.
	super visitCodeblock: aPRCodeblock
]

{ #category : 'visiting-document' }
GtDocumentVisitor >> visitFigure: aPRFigure [
	figureCounter := figureCounter + 1.
	aPRFigure counter: figureCounter.
	super visitFigure: aPRFigure
]
