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

{ #category : #accessing }
XdDocumenterType class >> typeString [
	"Return a unique string that represents the type"
	<return: #String>
	^ 'documenter'
]
