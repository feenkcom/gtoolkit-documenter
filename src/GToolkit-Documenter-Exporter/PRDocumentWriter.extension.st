Extension { #name : #PRDocumentWriter }

{ #category : #'*GToolkit-Documenter-Exporter' }
PRDocumentWriter >> exportGtPillarExampleFigureFrom: aGtPillarExampleScript toFile: aFileReference [ 
	| anExampleReturnValue aContainer |
	
	anExampleReturnValue := aGtPillarExampleScript exampleCompiledMethod gtExample returnValue.
	
	aContainer := GtPillarExporterContainerElement new.
	"recommended size"
	aContainer size: 500@300.

	anExampleReturnValue
		perform: aGtPillarExampleScript show
		withArguments: { aContainer }.
	
	aContainer forceLayout.

	aFileReference ensureDelete.
	BlSvgExporter new element: aContainer; fileName: aFileReference; export.

]

{ #category : #'*GToolkit-Documenter-Exporter' }
PRDocumentWriter >> visitGtPillarExampleCodeblock: aGtPillarExampleScript [
	| fileName directory fileReference |
	fileName := super visitGtPillarExampleCodeblock: aGtPillarExampleScript.
	fileName ifNil: [ ^ nil ].
	directory := self configuration outputDirectory asFileReference / 'gt-figures'.
	directory ensureCreateDirectory.
	fileReference := directory / fileName.
	self
		exportGtPillarExampleFigureFrom: aGtPillarExampleScript
		toFile: fileReference
]
