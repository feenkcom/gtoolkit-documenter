Class {
	#name : #XdDocumenterExamples,
	#superclass : #Object,
	#instVars : [
		'documentExamples',
		'xdocExamples'
	],
	#category : #'GToolkit-Documenter-XDoc-Examples'
}

{ #category : #'examples - xdoc ui' }
XdDocumenterExamples >> basicDocumenter [
	<gtExample>
	| aDoc |
	aDoc := XdDocumenter new.
	self assert: aDoc childrenCount equals: 2.
	^ aDoc
]

{ #category : #'examples - header' }
XdDocumenterExamples >> basicHeader [
	<gtExample>
	| aHeader |
	aHeader := XdDocumenterHeader new.
	aHeader aptitude: GtCoderExpanderWithoutShadowAptitude.
	aHeader hMatchParent; vFitContent.
	self assert: aHeader xdFile equals: XdFile null.
	^ aHeader
]

{ #category : #'examples - xdoc ui' }
XdDocumenterExamples >> documenter [
	<gtExample>
	| aDoc aXdFile |
	aDoc := self basicDocumenter.
	aXdFile := self xdocDocumenterWithExistingClass.
	aDoc xdFile: aXdFile.
	self assert: aDoc xdFile equals: aXdFile.
	self assert: aDoc childrenCount equals: 3.
	^ aDoc
]

{ #category : #'examples - header' }
XdDocumenterExamples >> header [
	<gtExample>
	| aHeader aXdFile |
	aHeader := self basicHeader.
	aXdFile := self xdocDocumenterWithExistingClass.
	aHeader xdFile: aXdFile.
	self assert: aHeader xdFile equals: aXdFile.
	^ aHeader
]

{ #category : #initialization }
XdDocumenterExamples >> initialize [
	super initialize.
	documentExamples := XdDocumentExamples new.
]

{ #category : #'examples - xdoc documents' }
XdDocumenterExamples >> xdocDocumenterWithExistingClass [
	<gtExample>
	| aFile |
	aFile := documentExamples writeDocumentWithExistingClass.
	aFile 
		publicationDate: DateAndTime now;
		publicUrl: 'https://example.com/article.html'.
	^ aFile
]
