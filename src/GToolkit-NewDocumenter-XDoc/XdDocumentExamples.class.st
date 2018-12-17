Class {
	#name : #XdDocumentExamples,
	#superclass : #Object,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#instVars : [
		'documentExamples',
		'xdocExamples'
	],
	#category : #'GToolkit-NewDocumenter-XDoc-Examples'
}

{ #category : #accessing }
XdDocumentExamples >> inMemoryWriter [
	<gtExample>
	^ xdocExamples inMemoryWriter
]

{ #category : #initialization }
XdDocumentExamples >> initialize [
	super initialize.
	documentExamples := Gt2DocumentExamples new.
	xdocExamples := XdReaderWriterExamples new.
]

{ #category : #options }
XdDocumentExamples >> reader [
	<gtExample>
	^ xdocExamples reader
]

{ #category : #changes }
XdDocumentExamples >> writeDocumentWithClassDefinitionChanges [
	<gtExample>
	| aXdFile aDocument |
	aDocument := documentExamples documentWithClassDefinitionChanges.
	aXdFile := self inMemoryWriter
		document: aDocument;
		documentHtml: aDocument;
		write.
	self assert: aXdFile notNil.
	self assert: aXdFile manifest notNil.
	"Pillar raw file (Documenter type)"
	self assert: aXdFile manifest documents size equals: 2.
	self
		assert: aXdFile manifest documents first type
		equals: XdDocumenterType.
	self
		assert: aXdFile manifest documents first components size
		equals: 2.
	self
		assert: aXdFile manifest documents first components first link
		equals: '1'.
	self
		assert: aXdFile manifest documents first components second link
		equals: '2'.
	"HTML export"
	self
		assert: aXdFile manifest documents second type
		equals: XdHtmlType.
	self
		assert: aXdFile manifest documents second components size
		equals: 1.
	self
		assert: aXdFile manifest documents second components first link
		equals: '3'.
	"Pillar source file"
	self assert: aXdFile manifest attachments size equals: 3.
	self assert: aXdFile manifest attachments first id equals: '1'.
	self
		assert: aXdFile manifest attachments first fileName
		equals: aDocument basename.
	self
		assert: aXdFile manifest attachments first fileSize
		equals: aDocument text size.
	"Changes file"
	self assert: aXdFile manifest attachments second id equals: '2'.
	self
		assert: aXdFile manifest attachments second fileName
		equals: documentExamples changesDirectoryName, '/', documentExamples changesFileNameWithClassDefinition.
	self
		assert: aXdFile manifest attachments second fileSize
		equals: documentExamples changesFileReferenceWithClassDefinition size.
	"HTML file"
	self assert: aXdFile manifest attachments third id equals: '3'.
	self
		assert: aXdFile manifest attachments third fileName
		equals: 'index.html'.
	self assert: aXdFile manifest attachments third fileSize isZero not.

	self assert: aXdFile exists.
	self assert: aXdFile streamingStrategy zip members size equals: 4.
	^ aXdFile
]

{ #category : #examples }
XdDocumentExamples >> writeDocumentWithExamples [
	<gtExample>
	
	| aWriter aXdFile |
	aWriter := self writer.
	aXdFile := aWriter
		streamingStrategy: XdStreamingStrategy bytes;
		document: documentExamples documentWithExamples;
		write.
	"self assert: aXdFile notNil.
	self assert: aXdFile manifest notNil.
	self assert: aXdFile manifest documents size equals: 1.
	self
		assert: aXdFile manifest documents first type
		equals: XdPillarType.
	self
		assert: aXdFile manifest documents first components size
		equals: 2.
	self
		assert: aXdFile manifest documents first components first link
		equals: '1'.
	self assert: aXdFile manifest attachments size equals: 2.
	self assert: aXdFile manifest attachments first id equals: '1'.
	self
		assert: aXdFile manifest attachments first fileName
		equals: documentExamples demoFileReference entry name.
	self assert: aXdFile manifest attachments second id equals: '2'.
	self
		assert: aXdFile manifest attachments second fileName
		equals: 'index.html'.
	self
		assert: aXdFile manifest attachments first fileSize
		equals: documentExamples demoFileReference size.
	self assert: aXdFile streamingStrategy notNil.
	self assert: aXdFile exists.
	self assert: aXdFile streamingStrategy zip members size equals: 3."
	^ aXdFile
]

{ #category : #class }
XdDocumentExamples >> writeDocumentWithExistingClass [
	<gtExample>
	
	| aXdFile aDocument |
	aDocument := documentExamples documentWithExistingClass.
	aXdFile := self inMemoryWriter
		document: aDocument;
		documentHtml: aDocument;
		write.
	self assert: aXdFile notNil.
	self assert: aXdFile manifest notNil.
	"Pillar raw file (Documenter type)"
	self assert: aXdFile manifest documents size equals: 2.
	self
		assert: aXdFile manifest documents first type
		equals: XdDocumenterType.
	self
		assert: aXdFile manifest documents first components size
		equals: 1.
	self
		assert: aXdFile manifest documents first components first link
		equals: '1'.
	"HTML export"
	self
		assert: aXdFile manifest documents second type
		equals: XdHtmlType.
	self
		assert: aXdFile manifest documents second components size
		equals: 1.
	self
		assert: aXdFile manifest documents second components first link
		equals: '2'.
	"Pillar source file"
	self assert: aXdFile manifest attachments size equals: 2.
	self assert: aXdFile manifest attachments first id equals: '1'.
	self
		assert: aXdFile manifest attachments first fileName
		equals: aDocument basename.
	self
		assert: aXdFile manifest attachments first fileSize
		equals: aDocument text size.
	"HTML file"
	self assert: aXdFile manifest attachments second id equals: '2'.
	self
		assert: aXdFile manifest attachments second fileName
		equals: XdConstants htmlIndexFile.
	self assert: aXdFile manifest attachments first fileSize isZero not.

	self assert: aXdFile exists.
	self assert: aXdFile streamingStrategy zip members size equals: 3.
	^ aXdFile
]

{ #category : #example }
XdDocumentExamples >> writeDocumentWithExistingExample [
	<gtExample>
	
	| aXdFile aDocument |
	aDocument := documentExamples documentWithExistingExample.
	aXdFile := self inMemoryWriter
		document: aDocument;
		documentHtml: aDocument;
		write.
	self assert: aXdFile notNil.
	self assert: aXdFile manifest notNil.
	"Pillar raw file (Documenter type)"
	self assert: aXdFile manifest documents size equals: 2.
	self
		assert: aXdFile manifest documents first type
		equals: XdDocumenterType.
	self
		assert: aXdFile manifest documents first components size
		equals: 1.
	self
		assert: aXdFile manifest documents first components first link
		equals: '1'.
	"HTML export"
	self
		assert: aXdFile manifest documents second type
		equals: XdHtmlType.
	self
		assert: aXdFile manifest documents second components size
		equals: 2.
	self
		assert: aXdFile manifest documents second components first link
		equals: '2'.
	self
		assert: aXdFile manifest documents second components second link
		equals: '3'.
	"Pillar source file"
	self assert: aXdFile manifest attachments size equals: 3.
	self assert: aXdFile manifest attachments first id equals: '1'.
	self
		assert: aXdFile manifest attachments first fileName
		equals: aDocument basename.
	self
		assert: aXdFile manifest attachments first fileSize
		equals: aDocument text size.
	"HTML file"
	self assert: aXdFile manifest attachments second id equals: '2'.
	self
		assert: aXdFile manifest attachments second fileName
		equals: 'index.html'.
	self assert: aXdFile manifest attachments first fileSize isZero not.
	"Example SVG file"
	self assert: aXdFile manifest attachments third id equals: '3'.
	self
		assert: aXdFile manifest attachments third fileName
		equals: self constants exportedResultsDirectoryName, '/', 
			(Gt2ExternalDataWriter initialCounterValue + 1) asString, '.', 
			self constants exportedResultsExtension.
	self assert: aXdFile manifest attachments third fileSize isZero not.

	self assert: aXdFile streamingStrategy notNil.
	self assert: aXdFile exists.
	self assert: aXdFile streamingStrategy zip members size equals: 4.
	^ aXdFile
]

{ #category : #method }
XdDocumentExamples >> writeDocumentWithExistingMethod [
	<gtExample>
	
	| aXdFile aDocument |
	aDocument := documentExamples documentWithExistingMethod.
	aXdFile := self inMemoryWriter
		document: aDocument;
		documentHtml: aDocument;
		write.
	self assert: aXdFile notNil.
	self assert: aXdFile manifest notNil.
	"Pillar raw file (Documenter type)"
	self assert: aXdFile manifest documents size equals: 2.
	self
		assert: aXdFile manifest documents first type
		equals: XdDocumenterType.
	self
		assert: aXdFile manifest documents first components size
		equals: 1.
	self
		assert: aXdFile manifest documents first components first link
		equals: '1'.
	"HTML export"
	self
		assert: aXdFile manifest documents second type
		equals: XdHtmlType.
	self
		assert: aXdFile manifest documents second components size
		equals: 1.
	self
		assert: aXdFile manifest documents second components first link
		equals: '2'.
	"Pillar source file"
	self assert: aXdFile manifest attachments size equals: 2.
	self assert: aXdFile manifest attachments first id equals: '1'.
	self
		assert: aXdFile manifest attachments first fileName
		equals: aDocument basename.
	self
		assert: aXdFile manifest attachments first fileSize
		equals: aDocument text size.
	"HTML file"
	self assert: aXdFile manifest attachments second id equals: '2'.
	self
		assert: aXdFile manifest attachments second fileName
		equals: XdConstants htmlIndexFile.
	self assert: aXdFile manifest attachments first fileSize isZero not.

	self assert: aXdFile exists.
	self assert: aXdFile streamingStrategy zip members size equals: 3.
	^ aXdFile
]

{ #category : #figure }
XdDocumentExamples >> writeDocumentWithImages [
	<gtExample>

	| aDocument aXdFile |
	aDocument := documentExamples documentWithFigure.
	aXdFile := self inMemoryWriter
		document: documentExamples documentWithFigure;
		documentHtml: documentExamples documentWithFigure;
		write.
	self assert: aXdFile notNil.
	self assert: aXdFile manifest notNil.
	self assert: aXdFile manifest documents size equals: 2.
	"Documenter raw source"
	self
		assert: aXdFile manifest documents first type
		equals: XdDocumenterType.
	self
		assert: aXdFile manifest documents first components size
		equals: 2.
	self
		assert: aXdFile manifest documents first components first link
		equals: '1'.
	self
		assert: aXdFile manifest documents first components second link
		equals: '2'.
	"HTML export"
	self
		assert: aXdFile manifest documents second type
		equals: XdHtmlType.
	self
		assert: aXdFile manifest documents second components size
		equals: 2.
	self
		assert: aXdFile manifest documents second components first link
		equals: '3'.
	self
		assert: aXdFile manifest documents second components second link
		equals: '2'.
	"Attachments"
	self assert: aXdFile manifest attachments size equals: 3.
	"Pillar"
	self assert: aXdFile manifest attachments first id equals: '1'.
	self
		assert: aXdFile manifest attachments first fileName
		equals: aDocument basename.
	self
		assert: aXdFile manifest attachments first fileSize
		equals: aDocument text size.
	"PNG"
	self assert: aXdFile manifest attachments second id equals: '2'.
	self
		assert: aXdFile manifest attachments second fileName
		equals: documentExamples figureFileName.
	self
		assert: aXdFile manifest attachments second fileSize
		equals: documentExamples figureFileReference size.
	"HTML"
	self assert: aXdFile manifest attachments third id equals: '3'.
	self
		assert: aXdFile manifest attachments third fileName
		equals: XdConstants htmlIndexFile.
	self
		assert: aXdFile manifest attachments third fileSize isZero not.

	self assert: aXdFile exists.
	self assert: aXdFile streamingStrategy zip members size equals: 4.
	^ aXdFile
]

{ #category : #writing }
XdDocumentExamples >> writeEmptyDocument [
	<gtExample>
	
	| aDocument aXdFile |
	aDocument := documentExamples emptyDocument.
	aXdFile := self inMemoryWriter
		document: aDocument;
		documentHtml: aDocument;
		write.
	self assert: aXdFile notNil.
	self assert: aXdFile manifest notNil.
	self assert: aXdFile manifest documents size equals: 2.
	"Document source files"
	self
		assert: aXdFile manifest documents first type
		equals: XdDocumenterType.
	self
		assert: aXdFile manifest documents first components size
		equals: 1.
	self
		assert: aXdFile manifest documents first components first link
		equals: '1'.
	"HTML"
	self
		assert: aXdFile manifest documents second type
		equals: XdHtmlType.
	self
		assert: aXdFile manifest documents second components size
		equals: 1.
	self
		assert: aXdFile manifest documents second components first link
		equals: '2'.
	"Attachments"
	self assert: aXdFile manifest attachments size equals: 2.
	"Document source"
	self assert: aXdFile manifest attachments first id equals: '1'.
	self
		assert: aXdFile manifest attachments first fileName
		equals: aDocument basename.
	self
		assert: aXdFile manifest attachments first fileSize
		equals: 0.
	"HTML"
	self assert: aXdFile manifest attachments second id equals: '2'.
	self
		assert: aXdFile manifest attachments second fileName
		equals: XdConstants htmlIndexFile.
	self
		assert: aXdFile manifest attachments second fileSize
		equals: 0.

	self assert: aXdFile exists.
	self assert: aXdFile streamingStrategy zip members size equals: 3.
	^ aXdFile
]

{ #category : #accessing }
XdDocumentExamples >> writer [
	<gtExample>
	^ xdocExamples writer
]
