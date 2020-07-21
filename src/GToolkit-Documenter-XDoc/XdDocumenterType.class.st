Class {
	#name : #XdDocumenterType,
	#superclass : #XdType,
	#category : #'GToolkit-Documenter-XDoc-Model'
}

{ #category : #accessing }
XdDocumenterType class >> mainDocument: aXdDocument ofXdFileInPharo: aXdFile [
	"Return an Bloc elemment or an object that understands #asElement."
	<return: #GtDocumenter>
	| theAttachments |
	self
		assert: [ aXdDocument notNil ] 
		description: [ 'XDoc document must be non-nil' ].
	self
		assert: [ aXdFile notNil ] 
		description: [ 'XDoc file must be non-nil' ].
	self
		assert: [ aXdFile exists ] 
		description: [ 'XDoc file must exist' ].
	self flag: 'XDoc API proposeal [feenkcom/gtoolkit#888]'.
	"^ aXdFile navigator
		onErrorReturnNil;
		document: aXdDocument;
		mainAttachment;
		string;
		as: [ :aString | GtDocument new text: aString ]
		find."
	aXdFile extract.

	theAttachments := aXdFile manifest attachmentsForDocument: aXdDocument.
	^ aXdFile streamingStrategy extracted allFiles 
		detect: [ :eachFile | eachFile basename = theAttachments first fileName ] 
		ifFound: [ :aFileReference | GtDocumenter forFile: aFileReference ] 
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
	^ GtPager openWrappedOn: aDocument title: 'Documenter'.
]

{ #category : #accessing }
XdDocumenterType class >> toolForDocument: aXdDocument ofXdFileInPharo: aXdFile [
	"Return an Bloc elemment or an object that understands #asElement."
	<return: #GtDocumenter>
	| aDocument |
	aDocument := self mainDocument: aXdDocument ofXdFileInPharo: aXdFile.
	^ aDocument ifNil: [ GtDocumenter new ].
]

{ #category : #accessing }
XdDocumenterType class >> typeString [
	"Return a unique string that represents the type"
	<return: #String>
	^ 'documenter'
]
