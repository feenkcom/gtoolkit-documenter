Class {
	#name : #XdDocumentExamples,
	#superclass : #Object,
	#traits : 'TGtDocumentConstants',
	#classTraits : 'TGtDocumentConstants classTrait',
	#instVars : [
		'documentExamples',
		'xdocExamples'
	],
	#category : #'GToolkit-Documenter-XDoc-Examples'
}

{ #category : #accessing }
XdDocumentExamples class >> constants [
	^ GtDocumentConstants
]

{ #category : #accessing }
XdDocumentExamples >> constants [
	^ GtDocumentConstants
]

{ #category : #xdocs }
XdDocumentExamples >> contentWithXDocs [
	<gtExample>
	^ '${', self constants xdocListAnnotationName, '}$'
]

{ #category : #xdocs }
XdDocumentExamples >> documentWithXDocs [
	<gtExample>
	| aDocument |
	aDocument := documentExamples defaultDocument text: self contentWithXDocs.
	aDocument privateStyleText.
	self assert: aDocument string equals: self contentWithXDocs.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #accessing }
XdDocumentExamples >> inMemoryWriter [
	<gtExample>
	^ xdocExamples inMemoryWriter
]

{ #category : #initialization }
XdDocumentExamples >> initialize [
	super initialize.
	documentExamples := GtDocumentExamples new.
	xdocExamples := XdExamples new.
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
		equals: XdConstants htmlIndexFile.
	self assert: aXdFile manifest attachments third fileSize isZero not.

	self assert: aXdFile exists.
	self assert: aXdFile streamingStrategy zip members size equals: 5.
	^ aXdFile
]

{ #category : #examples }
XdDocumentExamples >> writeDocumentWithExamples [
	<gtExample>
	
	|  aXdFile aDocument |
			
	aDocument := documentExamples documentWithExamples.
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
	self assert: aXdFile streamingStrategy zip members size equals: 4.
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
	self assert: aXdFile streamingStrategy zip members size equals: 4.
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
	self assert: aXdFile manifest documents size equals: 3.
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
		equals: XdConstants htmlIndexFile.
	self assert: aXdFile manifest attachments first fileSize isZero not.
	"Example SVG file"
	self assert: aXdFile manifest attachments third id equals: '3'.
	self
		assert: aXdFile manifest attachments third fileName
		equals: self constants exportedResultsDirectoryName, '/', 
			(XdExternalDataWriter initialCounterValue + 1) asString, '.', 
			self constants exportedResultsExtension.
	self assert: aXdFile manifest attachments third fileSize isZero not.

	self assert: aXdFile streamingStrategy notNil.
	self assert: aXdFile exists.
	self assert: aXdFile streamingStrategy zip members size equals: 5.
	^ aXdFile
]

{ #category : #example }
XdDocumentExamples >> writeDocumentWithExistingExampleAndPreviewHeight [
	<gtExample>
	| aXdFile aDocument theMembers theFigure aForm |
	aDocument := documentExamples documentWithExampleHiddenPreview.
	aXdFile := self inMemoryWriter
		document: aDocument;
		documentHtml: aDocument;
		write.
	self assert: aXdFile notNil.
	self assert: aXdFile manifest notNil.
	"Example figure file"
	self assert: aXdFile manifest attachments third id equals: '3'.
	self
		assert: aXdFile manifest attachments third fileName
		equals: self constants exportedResultsDirectoryName, '/', 
			(XdExternalDataWriter initialCounterValue + 1) asString, '.', 
			self constants exportedResultsExtension.
	self assert: aXdFile manifest attachments third fileSize isZero not.

	self assert: aXdFile streamingStrategy notNil.
	self assert: aXdFile exists.
	theMembers := aXdFile streamingStrategy zip members.
	self assert: theMembers size equals: 5.
	
	"Check figure height"
	theFigure := theMembers third.
	self assert: theFigure localFileName equals: aXdFile manifest attachments third fileName.
	aForm := ImageReadWriter gtFormFromBuffer: theFigure gtBytes.
	self assert: aForm height equals: documentExamples previewHeightHudredValue * self constants exportFigureScaleFactor.
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
	self assert: aXdFile streamingStrategy zip members size equals: 4.
	^ aXdFile
]

{ #category : #'iceberg file' }
XdDocumentExamples >> writeDocumentWithIcebergFile [
	<gtExample>
	
	| aXdFile aDocument |
	aDocument := documentExamples documentWithIcebergFile.
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
	self assert: aXdFile streamingStrategy zip members size equals: 4.
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
	self assert: aXdFile streamingStrategy zip members size equals: 5.
	^ aXdFile
]

{ #category : #figure }
XdDocumentExamples >> writeDocumentWithImagesOnPhysicalDisk [
	<gtExample>

	documentExamples initializeUsingPhysicalDisk.
	^ self writeDocumentWithImages
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
	self assert: aXdFile streamingStrategy zip members size equals: 4.
	^ aXdFile
]

{ #category : #accessing }
XdDocumentExamples >> writer [
	<gtExample>
	^ xdocExamples writer
]
