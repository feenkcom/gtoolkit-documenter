Class {
	#name : #GtResourceVisitor,
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
		'includeClasses',
		'includeExampleAnnotations',
		'includeChanges'
	],
	#category : #'GToolkit-Documenter-Resourcer'
}

{ #category : #'private - adding' }
GtResourceVisitor >> addDocumentResource: aGt2DocumentResource [
	(self addToVisitedDocumentResources: aGt2DocumentResource) ifTrue: [ ^ self ].
	self addResource: aGt2DocumentResource.
	maxDepth = 0 ifTrue: [ ^ self ].
	self computeResources: aGt2DocumentResource
]

{ #category : #'private - adding' }
GtResourceVisitor >> addResource: aGt2Resource [
	self documentResource addResource: aGt2Resource.
]

{ #category : #'private - adding' }
GtResourceVisitor >> addResource: aFileReference named: aString as: aDocumentResourceClass or: aResourceClass [
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
GtResourceVisitor >> addResource: aFileReference named: aString asDocument: aDocumentResourceClass [
	| aResource |
	aResource := aDocumentResourceClass new 
			source: self document;
			document: (GtDocumenter forFile: aFileReference);
			name: aString.
	self addDocumentResource: aResource.
]

{ #category : #'private - adding' }
GtResourceVisitor >> addResource: aFileReference named: aString asResource: aResourceClass [
	| aResource |
	aResource := aResourceClass new 
			source: self document;
			resource: aFileReference;
			name: aString.
	self addResource: aResource.
]

{ #category : #'private - adding' }
GtResourceVisitor >> addToVisitedDocumentResources: aGt2DocumentResource [
	"Return true if the resource was already visited"
	<return: #Boolean>
	(visitedDocumentResources includes: aGt2DocumentResource) ifTrue: [ ^ true ].
	visitedDocumentResources add: aGt2DocumentResource.
	^ false

]

{ #category : #initialization }
GtResourceVisitor >> allDepth [
	self maxDepth: self meaningfulMaxDepth.
]

{ #category : #building }
GtResourceVisitor >> compute [
	self start: self document parse.
	^ self resources
]

{ #category : #private }
GtResourceVisitor >> computeResources: aGt2NodeReference [
	| aVisitor |
	aVisitor := self class new.
	aVisitor visitedDocumentResources: visitedDocumentResources.
	aVisitor documentResource: aGt2NodeReference.
	includeFigures ifTrue: [ aVisitor includeFigures ].
	includeInputFiles ifTrue: [ aVisitor includeInputFiles ].
	includeIcebergFiles ifTrue: [ aVisitor includeIcebergFiles ].
	includeClasses ifTrue: [ aVisitor includeClasses ].
	includeChanges ifTrue: [ aVisitor includeChanges ].
	aVisitor maxDepth: maxDepth - 1.
	aVisitor get
]

{ #category : #accessing }
GtResourceVisitor >> document [
	<return: #GtDocumenter>
	^ documentResource document
]

{ #category : #accessing }
GtResourceVisitor >> document: aGtDocument [
	self 
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document must be non-nil' ].
	self documentResource: (GtNodeResource new 
		document: aGtDocument;
		name: aGtDocument name)
]

{ #category : #accessing }
GtResourceVisitor >> documentResource [
	<return: #GtNodeResource>
	^ documentResource
]

{ #category : #accessing }
GtResourceVisitor >> documentResource: aGt2NodeResource [
	self 
		assert: [ aGt2NodeResource isNotNil ] 
		description: [ 'Document resource must be non-nil' ].
	documentResource := aGt2NodeResource.
	self addToVisitedDocumentResources: aGt2NodeResource
]

{ #category : #building }
GtResourceVisitor >> get [
	self start: self document parse.
	^ documentResource
]

{ #category : #initialization }
GtResourceVisitor >> includeAll [
	self 
		includeFigures;
		includeDocuments.
]

{ #category : #initialization }
GtResourceVisitor >> includeChanges [
	includeChanges := true
]

{ #category : #initialization }
GtResourceVisitor >> includeClasses [
	includeClasses := true
]

{ #category : #initialization }
GtResourceVisitor >> includeDocuments [
	self 
		includeIcebergFiles;
		includeInputFiles;
		includeClasses.
]

{ #category : #initialization }
GtResourceVisitor >> includeFigures [
	includeFigures := true
]

{ #category : #initialization }
GtResourceVisitor >> includeIcebergFiles [
	includeIcebergFiles := true
]

{ #category : #initialization }
GtResourceVisitor >> includeInputFiles [
	includeInputFiles := true
]

{ #category : #initialization }
GtResourceVisitor >> initialize [
	super initialize.
	includeFigures := false.
	includeInputFiles := false.
	includeIcebergFiles := false.
	includeClasses := false.
	includeChanges := false.
	maxDepth := 0.
	visitedDocumentResources := OrderedCollection new.
]

{ #category : #initialization }
GtResourceVisitor >> maxDepth: anInteger [
	self 
		assert: [ anInteger isNumber ] 
		description: [ 'Resource max depth must be a number' ].
	self 
		assert: [ anInteger >= 0 ] 
		description: [ 'Resource max depth must be a positive number' ].
	maxDepth := anInteger
]

{ #category : #initialization }
GtResourceVisitor >> meaningfulMaxDepth [
	^ 20
]

{ #category : #accessing }
GtResourceVisitor >> resources [
	<return: #OrderedCollection of: #GtResource>
	^ self documentResource allResources
]

{ #category : #visiting }
GtResourceVisitor >> visit: anObject [
	anObject gtDocument: self document.
	super visit: anObject.
]

{ #category : #'visiting-document' }
GtResourceVisitor >> visitFigure: aPRFigure [ 
	| aFileReferenceOrNil aFigure aFileName |
	includeFigures ifFalse: [ ^ super visitFigure: aPRFigure ].
	aPRFigure gtDocument: self document.
	aFileReferenceOrNil := aPRFigure figureFileReference.
	aFileReferenceOrNil ifNil: [ ^ super visitFigure: aPRFigure ].
	aFileName := GtFileUtility fileNameOfUri: aPRFigure reference.
	aFigure := GtFigure new 
			source: self document;
			resource: aFileReferenceOrNil;
			name: aFileName.
	self addResource: aFigure.
	super visitFigure: aPRFigure.
]

{ #category : #'visiting-annotations' }
GtResourceVisitor >> visitGt2ChangesAnnotation: aGt2ChangesAnnotation [
	| aFileReferenceOrNil aResource |
	includeChanges ifFalse: [ ^ super visitGt2ChangesAnnotation: aGt2ChangesAnnotation ].
	aGt2ChangesAnnotation changeFileExists ifFalse: [ ^ self ].
	aGt2ChangesAnnotation gtDocument: self document.
	aFileReferenceOrNil := aGt2ChangesAnnotation changeFile.
	aResource := GtChangesResource new 
			source: self document;
			resource: aFileReferenceOrNil;
			name: aFileReferenceOrNil basename.
	self addDocumentResource: aResource.
	super visitGt2ChangesAnnotation: aGt2ChangesAnnotation
]

{ #category : #'visiting-annotations' }
GtResourceVisitor >> visitGt2ClassAnnotation: aGt2ClassAnnotation [
	| aRGClassDefinitionOrNil aResource |
	includeClasses ifFalse: [ ^ super visitGt2ClassAnnotation: aGt2ClassAnnotation ].
	aGt2ClassAnnotation gtDocument: self document.
	aRGClassDefinitionOrNil := aGt2ClassAnnotation referencedClass.
	aRGClassDefinitionOrNil ifNil: [ ^ super visitGt2ClassAnnotation: aGt2ClassAnnotation ].
	aRGClassDefinitionOrNil isDefined 
		ifFalse: [ ^ super visitGt2ClassAnnotation: aGt2ClassAnnotation ].
	aResource := GtClassResource new 
			source: self document;
			document: (GtDocumenter forClass: aRGClassDefinitionOrNil realClass);
			name: aRGClassDefinitionOrNil name.
	self addDocumentResource: aResource.
	super visitGt2ClassAnnotation: aGt2ClassAnnotation
]

{ #category : #'visiting-annotations' }
GtResourceVisitor >> visitGt2IcebergFileAnnotation: aGt2IcebergFileAnnotation [
	| aFileReferenceOrNil |
	includeIcebergFiles ifFalse: [ ^ super visitGt2IcebergFileAnnotation: aGt2IcebergFileAnnotation ].
	aGt2IcebergFileAnnotation gtDocument: self document.
	aFileReferenceOrNil := aGt2IcebergFileAnnotation fileReference.
	aFileReferenceOrNil ifNil: [ ^ super visitGt2IcebergFileAnnotation: aGt2IcebergFileAnnotation ].
	self 
		addResource: aFileReferenceOrNil 
		named: aGt2IcebergFileAnnotation path
		as: GtIcebergFileDocument
		or: GtIcebergFile.
	super visitGt2IcebergFileAnnotation: aGt2IcebergFileAnnotation
]

{ #category : #'visiting-annotations' }
GtResourceVisitor >> visitInputFileAnnotation: anInputFileAnnotation [
	| aFileReferenceOrNil |
	includeInputFiles ifFalse: [ ^ super visitInputFileAnnotation: anInputFileAnnotation ].
	anInputFileAnnotation gtDocument: self document.
	aFileReferenceOrNil := anInputFileAnnotation fileReference.
	aFileReferenceOrNil ifNil: [ ^ super visitInputFileAnnotation: anInputFileAnnotation ].
	self 
		addResource: aFileReferenceOrNil 
		named: anInputFileAnnotation path
		as: GtInputFileDocument
		or: GtInputFile.
	super visitInputFileAnnotation: anInputFileAnnotation
]

{ #category : #initialization }
GtResourceVisitor >> visitedDocumentResources: aCollection [
	visitedDocumentResources := aCollection
]
