Class {
	#name : #XdDocumenterType,
	#superclass : #XdType,
	#category : #'GToolkit-NewDocumenter-XDoc-Model'
}

{ #category : #testing }
XdDocumenterType class >> matchesMimeType: aZnMimeType [
	"Return true if the document type is equivalent to the Zinc MIME type"
	<return: #Boolean>
	^ aZnMimeType matches: GtFilePillarMimeTypeResolver mimeType
]

{ #category : #actions }
XdDocumenterType class >> openDocument: aXdDocument ofXdFileInPharo: aXdFile [ 
	| aFileSystem theAttachments |
	self
		assert: [ aXdDocument notNil ] 
		description: [ 'XDoc document must be non-nil' ].
	self
		assert: [ aXdFile notNil ] 
		description: [ 'XDoc file must be non-nil' ].
	self
		assert: [ aXdFile exists ] 
		description: [ 'XDoc file must exist' ].
	aFileSystem := FileSystem zip: aXdFile streamingStrategy.
	aFileSystem open.
	theAttachments := aXdFile manifest attachmentsForDocument: aXdDocument.
	aFileSystem root files 
		detect: [ :eachFile | eachFile basename = theAttachments first fileName ] 
		ifFound: [ :aFileReference | ^ GtInspector openOn: (Gt2Document forFile: aFileReference) title: 'Documenter' ] 
		ifNone: [ "ignore" ]
]

{ #category : #accessing }
XdDocumenterType class >> typeString [
	"Return a unique string that represents the type"
	<return: #String>
	^ 'documenter'
]
