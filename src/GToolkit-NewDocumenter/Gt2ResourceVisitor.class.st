Class {
	#name : #Gt2ResourceVisitor,
	#superclass : #PRVisitor,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'resources',
		'includeFigures',
		'includeInputFiles',
		'includeIcebergFiles',
		'maxDepth',
		'documentResource',
		'visitedDocumentResources',
		'includeClasses'
	],
	#category : #'GToolkit-NewDocumenter-Resourcer'
}

{ #category : #'private - adding' }
Gt2ResourceVisitor >> addDocumentResource: aGt2DocumentResource [
	(self addToVisitedDocumentResources: aGt2DocumentResource) ifTrue: [ ^ self ].
	self addResource: aGt2DocumentResource.
	maxDepth = 0 ifTrue: [ ^ self ].
	self computeResources: aGt2DocumentResource
]

{ #category : #'private - adding' }
Gt2ResourceVisitor >> addResource: aGt2Resource [
	self documentResource addResource: aGt2Resource.
]

{ #category : #'private - adding' }
Gt2ResourceVisitor >> addResource: aFileReference named: aString as: aDocumentResourceClass or: aResourceClass [
	(GtFileUtility mimeTypeOfFileReference: aFileReference) 
		= GtFileUtilityConstants pillarMimeType 
				ifTrue: [ self 
					addResource: aFileReference 
					named: aString 
					asDocument: aDocumentResourceClass ]
				ifFalse: [ self 
					addResource: aFileReference 
					named: aString 
					asResource: aResourceClass ]
]

{ #category : #'private - adding' }
Gt2ResourceVisitor >> addResource: aFileReference named: aString asDocument: aDocumentResourceClass [
	| aResource |
	aResource := aDocumentResourceClass new 
			source: self document;
			document: (Gt2Document forFile: aFileReference);
			name: aString.
	self addDocumentResource: aResource.
]

{ #category : #'private - adding' }
Gt2ResourceVisitor >> addResource: aFileReference named: aString asResource: aResourceClass [
	| aResource |
	aResource := aResourceClass new 
			source: self document;
			resource: aFileReference;
			name: aString.
	self addResource: aResource.
]

{ #category : #'private - adding' }
Gt2ResourceVisitor >> addToVisitedDocumentResources: aGt2DocumentResource [
	"Return true if the resource was already visited"
	<return: #Boolean>
	(visitedDocumentResources includes: aGt2DocumentResource) ifTrue: [ ^ true ].
	visitedDocumentResources add: aGt2DocumentResource.
	^ false

]

{ #category : #initialization }
Gt2ResourceVisitor >> allDepth [
	self maxDepth: self meaningfulMaxDepth.
]

{ #category : #building }
Gt2ResourceVisitor >> compute [
	self start: self document parse.
	^ self resources
]

{ #category : #private }
Gt2ResourceVisitor >> computeResources: aGt2NodeReference [
	| aVisitor |
	aVisitor := self class new.
	aVisitor visitedDocumentResources: visitedDocumentResources.
	aVisitor documentResource: aGt2NodeReference.
	includeFigures ifTrue: [ aVisitor includeFigures ].
	includeInputFiles ifTrue: [ aVisitor includeInputFiles ].
	includeIcebergFiles ifTrue: [ aVisitor includeIcebergFiles ].
	includeClasses ifTrue: [ aVisitor includeClasses ].
	aVisitor maxDepth: maxDepth - 1.
	aVisitor get
]

{ #category : #accessing }
Gt2ResourceVisitor >> document [
	<return: #Gt2Document>
	^ documentResource document
]

{ #category : #accessing }
Gt2ResourceVisitor >> document: aGtDocument [
	self 
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document must be non-nil' ].
	self documentResource: (Gt2NodeResource new 
		document: aGtDocument;
		name: aGtDocument name)
]

{ #category : #accessing }
Gt2ResourceVisitor >> documentResource [
	<return: #Gt2NodeResource>
	^ documentResource
]

{ #category : #accessing }
Gt2ResourceVisitor >> documentResource: aGt2NodeResource [
	self 
		assert: [ aGt2NodeResource isNotNil ] 
		description: [ 'Document resource must be non-nil' ].
	documentResource := aGt2NodeResource.
	self addToVisitedDocumentResources: aGt2NodeResource
]

{ #category : #building }
Gt2ResourceVisitor >> get [
	self start: self document parse.
	^ documentResource
]

{ #category : #initialization }
Gt2ResourceVisitor >> includeAll [
	self 
		includeFigures;
		includeIcebergFiles;
		includeInputFiles.
]

{ #category : #initialization }
Gt2ResourceVisitor >> includeClasses [
	includeClasses := true
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
	includeFigures := false.
	includeInputFiles := false.
	includeIcebergFiles := false.
	includeClasses := false.
	maxDepth := 0.
	visitedDocumentResources := OrderedCollection new.
]

{ #category : #initialization }
Gt2ResourceVisitor >> maxDepth: anInteger [
	self 
		assert: [ anInteger isNumber ] 
		description: [ 'Resource max depth must be a number' ].
	self 
		assert: [ anInteger >= 0 ] 
		description: [ 'Resource max depth must be a positive number' ].
	maxDepth := anInteger
]

{ #category : #initialization }
Gt2ResourceVisitor >> meaningfulMaxDepth [
	^ 20
]

{ #category : #accessing }
Gt2ResourceVisitor >> resources [
	<return: #OrderedCollection of: #Gt2Resource>
	^ self documentResource allResources
]

{ #category : #'visiting-document' }
Gt2ResourceVisitor >> visitFigure: aPRFigure [ 
	| aFileReferenceOrNil aFigure aFileName |
	includeFigures ifFalse: [ ^ super visitFigure: aPRFigure ].
	aPRFigure gtDocument: self document.
	aFileReferenceOrNil := aPRFigure figureFileReference.
	aFileReferenceOrNil ifNil: [ ^ super visitFigure: aPRFigure ].
	aFileName := GtFileUtility fileNameOfUri: aPRFigure reference.
	aFigure := Gt2Figure new 
			source: self document;
			resource: aFileReferenceOrNil;
			name: aFileName.
	self addResource: aFigure.
	super visitFigure: aPRFigure.
]

{ #category : #'visiting-annotations' }
Gt2ResourceVisitor >> visitGt2ClassAnnotation: aGt2ClassAnnotation [
	| aRGClassDefinitionOrNil aResource |
	includeClasses ifFalse: [ ^ super visitGt2ClassAnnotation: aGt2ClassAnnotation ].
	aGt2ClassAnnotation gtDocument: self document.
	aRGClassDefinitionOrNil := aGt2ClassAnnotation referencedClass.
	aRGClassDefinitionOrNil ifNil: [ ^ super visitGt2ClassAnnotation: aGt2ClassAnnotation ].
	aRGClassDefinitionOrNil isDefined 
		ifFalse: [ ^ super visitGt2ClassAnnotation: aGt2ClassAnnotation ].
	aResource := Gt2ClassResource new 
			source: self document;
			document: (Gt2Document forClass: aRGClassDefinitionOrNil realClass);
			name: aRGClassDefinitionOrNil name.
	self addDocumentResource: aResource.
	super visitGt2ClassAnnotation: aGt2ClassAnnotation
]

{ #category : #'visiting-annotations' }
Gt2ResourceVisitor >> visitGt2IcebergFileAnnotation: aGt2IcebergFileAnnotation [
	| aFileReferenceOrNil |
	includeIcebergFiles ifFalse: [ ^ super visitGt2IcebergFileAnnotation: aGt2IcebergFileAnnotation ].
	aGt2IcebergFileAnnotation gtDocument: self document.
	aFileReferenceOrNil := aGt2IcebergFileAnnotation fileReference.
	aFileReferenceOrNil ifNil: [ ^ super visitGt2IcebergFileAnnotation: aGt2IcebergFileAnnotation ].
	self 
		addResource: aFileReferenceOrNil 
		named: aGt2IcebergFileAnnotation path
		as: Gt2IcebergFileDocument
		or: Gt2IcebergFile.
	super visitGt2IcebergFileAnnotation: aGt2IcebergFileAnnotation
]

{ #category : #'visiting-annotations' }
Gt2ResourceVisitor >> visitInputFileAnnotation: anInputFileAnnotation [
	| aFileReferenceOrNil |
	includeInputFiles ifFalse: [ ^ super visitInputFileAnnotation: anInputFileAnnotation ].
	anInputFileAnnotation gtDocument: self document.
	aFileReferenceOrNil := anInputFileAnnotation fileReference.
	aFileReferenceOrNil ifNil: [ ^ super visitInputFileAnnotation: anInputFileAnnotation ].
	self 
		addResource: aFileReferenceOrNil 
		named: anInputFileAnnotation path
		as: Gt2InputFileDocument
		or: Gt2InputFile.
	super visitInputFileAnnotation: anInputFileAnnotation
]

{ #category : #initialization }
Gt2ResourceVisitor >> visitedDocumentResources: aCollection [
	visitedDocumentResources := aCollection
]
