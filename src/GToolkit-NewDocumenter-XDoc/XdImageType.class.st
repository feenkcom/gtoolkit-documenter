Class {
	#name : #XdImageType,
	#superclass : #XdType,
	#category : #'GToolkit-NewDocumenter-XDoc'
}

{ #category : #testing }
XdImageType class >> matchesMimeType: aZnMimeType [
	"Return true if the document type is equivalent to the Zinc MIME type"
	<return: #Boolean>
	^ aZnMimeType matches: (ZnMimeType main: 'image' sub: '*')
]

{ #category : #accessing }
XdImageType class >> typeString [
	"Return a unique string that represents the type"
	<return: #String>
	^ 'image'
]
