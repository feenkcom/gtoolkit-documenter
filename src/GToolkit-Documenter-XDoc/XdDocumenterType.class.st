Class {
	#name : #XdDocumenterType,
	#superclass : #XdType,
	#category : #'GToolkit-Documenter-XDoc-Model'
}

{ #category : #accessing }
XdDocumenterType class >> mainDocument: aXdDocument ofXdFileInPharo: aXdFile [
	"Return an Bloc elemment or an object that understands #asElement."
	<return: #GtDocument>
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
	^ aFileSystem root files 
		detect: [ :eachFile | eachFile basename = theAttachments first fileName ] 
		ifFound: [ :aFileReference | GtDocument forFile: aFileReference ] 
		ifNone: [ nil ]
]

{ #category : #testing }
XdDocumenterType class >> matchesMimeType: aZnMimeType [
	"Return true if the document type is equivalent to the Zinc MIME type"
	<return: #Boolean>
	^ aZnMimeType matches: GtFilePillarMimeTypeResolver mimeType
]

{ #category : #actions }
XdDocumenterType class >> openDocument: aXdDocument ofXdFileInPharo: aXdFile [ 
	| aDocument |
	aDocument := self mainDocument: aXdDocument ofXdFileInPharo: aXdFile.
	aDocument ifNil: [ ^ self ].
	^ GtInspector openOn: aDocument title: 'Documenter'.
]

{ #category : #accessing }
XdDocumenterType class >> toolForDocument: aXdDocument ofXdFileInPharo: aXdFile [
	"Return an Bloc elemment or an object that understands #asElement."
	<return: #GtDocument>
	| aDocument |
	aDocument := self mainDocument: aXdDocument ofXdFileInPharo: aXdFile.
	^ aDocument ifNil: [ GtDocument new ].
]

{ #category : #accessing }
XdDocumenterType class >> typeString [
	"Return a unique string that represents the type"
	<return: #String>
	^ 'documenter'
]
