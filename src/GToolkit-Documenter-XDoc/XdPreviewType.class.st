Class {
	#name : #XdPreviewType,
	#superclass : #XdType,
	#category : #'GToolkit-Documenter-XDoc-Model'
}

{ #category : #testing }
XdPreviewType class >> matchesMimeType: aZnMimeType [
	"Return true if the document type is equivalent to the Zinc MIME type"
	<return: #Boolean>
	^ aZnMimeType matches: (ZnMimeType main: 'image' sub: '*')
]

{ #category : #accessing }
XdPreviewType class >> typeString [
	"Return a unique string that represents the type"
	<return: #String>
	^ 'preview'
]
