Class {
	#name : #XdDocumentBuilder,
	#superclass : #Object,
	#instVars : [
		'outputDirectory',
		'ouputFile',
		'sourceFile'
	],
	#category : #'GToolkit-NewDocumenter-XDoc-Exporter'
}

{ #category : #'instance creation' }
XdDocumentBuilder class >> forDocumentType: aXdDocumentTypeClass [ 
	"Return an instance of a XdHtmlExporter subclass"
	<return: #XdHtmlExporter>
	self allSubclassesDo: [ :eachSubclass | 
		(eachSubclass matchesDocumentType: aXdDocumentTypeClass) ifTrue: [ ^ eachSubclass ] ].
	^ self error: 'Unsupported document type'
]

{ #category : #'instance creation' }
XdDocumentBuilder class >> forRootFileReference: aFileReference [ 
	"Return an instance of a XdHtmlExporter subclass"
	<return: #XdHtmlExporter>
	| mimeType documentType |
	mimeType := GtFileUtility mimeTypeOfExtension: aFileReference extension.
	documentType := XdType typeFromMimeType: mimeType.
	^ self forDocumentType: documentType
]

{ #category : #testing }
XdDocumentBuilder class >> isAbstract [
	^ self name = #XdDocumentBuilder
]

{ #category : #'instance creation' }
XdDocumentBuilder class >> newForRootFileReference: aFileReference [ 
	^ (self forRootFileReference: aFileReference) new
			sourceFile: aFileReference;
			yourself
]

{ #category : #accessing }
XdDocumentBuilder >> outputDirectory [
	^ outputDirectory
]

{ #category : #accessing }
XdDocumentBuilder >> outputDirectory: anObject [
	outputDirectory := anObject
]

{ #category : #accessing }
XdDocumentBuilder >> outputFile [
	^ ouputFile
]

{ #category : #accessing }
XdDocumentBuilder >> outputFile: anObject [
	ouputFile := anObject
]

{ #category : #accessing }
XdDocumentBuilder >> sourceFile [
	^ sourceFile
]

{ #category : #accessing }
XdDocumentBuilder >> sourceFile: aFileReference [
	sourceFile := aFileReference
]
