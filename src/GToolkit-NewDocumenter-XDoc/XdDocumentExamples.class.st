Class {
	#name : #XdDocumentExamples,
	#superclass : #Object,
	#instVars : [
		'documentExamples'
	],
	#category : #'GToolkit-NewDocumenter-XDoc-Examples'
}

{ #category : #initialization }
XdDocumentExamples >> initialize [
	super initialize.
	documentExamples := Gt2DocumentExamples new.
]

{ #category : #options }
XdDocumentExamples >> reader [
	<gtExample>
	^ XdReaderWriterExamples new reader
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

{ #category : #example }
XdDocumentExamples >> writeDocumentWithExistingExample [
	<gtExample> <noTest>
	
	| aWriter aXdFile aDocument |
	aDocument := documentExamples documentWithExistingExample.
	aWriter := self writer.
	aXdFile := aWriter
		streamingStrategy: XdStreamingStrategy bytes;
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
		equals: 'gt-figures/file.svg'.
	self assert: aXdFile manifest attachments third fileSize isZero not.

	self assert: aXdFile streamingStrategy notNil.
	self assert: aXdFile exists.
	self assert: aXdFile streamingStrategy zip members size equals: 4.
	^ aXdFile
]

{ #category : #writing }
XdDocumentExamples >> writeDocumentWithImages [
	<gtExample>

	| aWriter aXdFile |
	aWriter := self writer.
	aXdFile := aWriter
		streamingStrategy: XdStreamingStrategy bytes;
		document: documentExamples documentWithFigure;
		write.
	self assert: aXdFile notNil.
	self assert: aXdFile manifest notNil.
	self assert: aXdFile manifest documents size equals: 1.
	self
		assert: aXdFile manifest documents first type
		equals: XdDocumenterType.
	self
		assert: aXdFile manifest documents first components size
		equals: 3.
	self
		assert: aXdFile manifest documents first components first link
		equals: '1'.
	self assert: aXdFile manifest attachments size equals: 3.
	self assert: aXdFile manifest attachments first id equals: '1'.
	self assert: aXdFile manifest attachments second id equals: '2'.
	self assert: aXdFile manifest attachments third id equals: '3'.
	self
		assert: aXdFile manifest attachments first fileName
		equals: documentExamples fileReferenceWithFigure entry name.
	self
		assert: aXdFile manifest attachments first fileSize
		equals: documentExamples fileReferenceWithFigure size.
	self assert: aXdFile streamingStrategy notNil.
	self assert: aXdFile exists.
	self assert: aXdFile streamingStrategy zip members size equals: 4.
	^ aXdFile
]

{ #category : #writing }
XdDocumentExamples >> writeEmptyDocument [
	<gtExample>
	
	| aWriter aXdFile |
	aWriter := self writer.
	aXdFile := aWriter
		streamingStrategy: XdStreamingStrategy bytes;
		document: documentExamples emptyDocument;
		write.
	self assert: aXdFile notNil.
	self assert: aXdFile manifest notNil.
	self assert: aXdFile manifest documents size equals: 1.
	self
		assert: aXdFile manifest documents first type
		equals: XdDocumenterType.
	self
		assert: aXdFile manifest documents first components size
		equals: 2.
	self
		assert: aXdFile manifest documents first components first link
		equals: '1'.
	self assert: aXdFile manifest attachments size equals: 2.
	self assert: aXdFile manifest attachments first id equals: '1'.
	self
		assert: aXdFile manifest attachments second fileName
		equals: 'index.html'.
	self
		assert: aXdFile manifest attachments first fileSize
		equals: 0.
	self assert: aXdFile streamingStrategy notNil.
	self assert: aXdFile exists.
	self assert: aXdFile streamingStrategy zip members size equals: 3.
	^ aXdFile
]

{ #category : #writing }
XdDocumentExamples >> writePlainDocument [
	<gtExample>
	
	| aWriter aXdFile |
	aWriter := self writer.
	aXdFile := aWriter
		streamingStrategy: XdStreamingStrategy bytes;
		document: documentExamples demoDocument;
		write.
	self assert: aXdFile notNil.
	self assert: aXdFile manifest notNil.
	self assert: aXdFile manifest documents size equals: 1.
	self
		assert: aXdFile manifest documents first type
		equals: XdDocumenterType.
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
	self assert: aXdFile streamingStrategy zip members size equals: 3.
	^ aXdFile
]

{ #category : #accessing }
XdDocumentExamples >> writer [
	<gtExample>
	^ XdReaderWriterExamples new writer
]
