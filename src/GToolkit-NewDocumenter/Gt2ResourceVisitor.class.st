Class {
	#name : #Gt2ResourceVisitor,
	#superclass : #PRVisitor,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'resources',
		'document',
		'includeFigures',
		'includeInputFiles',
		'includeIcebergFiles'
	],
	#category : #'GToolkit-NewDocumenter-Resourcer'
}

{ #category : #adding }
Gt2ResourceVisitor >> addResource: aPRDocumentItem [
	self resources add: aPRDocumentItem
]

{ #category : #building }
Gt2ResourceVisitor >> compute [
	self start: self document parse.
	^ self resources
]

{ #category : #accessing }
Gt2ResourceVisitor >> document [
	<return: #Gt2Document>
	^ document
]

{ #category : #accessing }
Gt2ResourceVisitor >> document: aGtDocument [
	self 
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document must be non-nil' ].
	document := aGtDocument
]

{ #category : #initialization }
Gt2ResourceVisitor >> includeFigures [
	includeFigures := true
]

{ #category : #initialization }
Gt2ResourceVisitor >> includeIcebergFiles [
	includeIcebergFiles := true
]

{ #category : #initialization }
Gt2ResourceVisitor >> includeInputFiles [
	includeInputFiles := true
]

{ #category : #initialization }
Gt2ResourceVisitor >> initialize [
	super initialize.
	resources := OrderedCollection new.
	includeFigures := false.
	includeInputFiles := false.
	includeIcebergFiles := false.
]

{ #category : #accessing }
Gt2ResourceVisitor >> resources [
	<return: #OrderedCollection of: #Gt2Resource>
	^ resources
]

{ #category : #'visiting-document' }
Gt2ResourceVisitor >> visitFigure: aPRFigure [ 
	| aFileReferenceOrNil aFigure |
	includeFigures ifFalse: [ ^ super visitFigure: aPRFigure ].
	aPRFigure gtDocument: self document.
	aFileReferenceOrNil := aPRFigure figureFileReference.
	aFileReferenceOrNil ifNil: [ ^ super visitFigure: aPRFigure ].
	aFigure := Gt2Figure new 
			document: self document;
			resource: aFileReferenceOrNil;
			name: aPRFigure reference.
	self addResource: aFigure.
	super visitFigure: aPRFigure.
]

{ #category : #'visiting-annotations' }
Gt2ResourceVisitor >> visitGt2IcebergFileAnnotation: aGt2IcebergFileAnnotation [
	| aFileReferenceOrNil aInputFile |
	includeIcebergFiles ifFalse: [ ^ super visitGt2IcebergFileAnnotation: aGt2IcebergFileAnnotation ].
	aGt2IcebergFileAnnotation gtDocument: self document.
	aFileReferenceOrNil := aGt2IcebergFileAnnotation fileReference.
	aFileReferenceOrNil ifNil: [ ^ super visitGt2IcebergFileAnnotation: aGt2IcebergFileAnnotation ].
	aInputFile := Gt2IcebergFile new 
			document: self document;
			resource: (Gt2Document forFile: aFileReferenceOrNil);
			name: aGt2IcebergFileAnnotation path.
	self addResource: aInputFile.
	super visitGt2IcebergFileAnnotation: aGt2IcebergFileAnnotation
]

{ #category : #'visiting-annotations' }
Gt2ResourceVisitor >> visitInputFileAnnotation: anInputFileAnnotation [
	| aFileReferenceOrNil aInputFile |
	includeInputFiles ifFalse: [ ^ super visitInputFileAnnotation: anInputFileAnnotation ].
	anInputFileAnnotation gtDocument: self document.
	aFileReferenceOrNil := anInputFileAnnotation fileReference.
	aFileReferenceOrNil ifNil: [ ^ super visitInputFileAnnotation: anInputFileAnnotation ].
	aInputFile := Gt2InputFile new 
			document: self document;
			resource: (Gt2Document forFile: aFileReferenceOrNil);
			name: anInputFileAnnotation path.
	self addResource: aInputFile.
	super visitInputFileAnnotation: anInputFileAnnotation
]
