Class {
	#name : #XdHtmlType,
	#superclass : #XdType,
	#category : #'GToolkit-NewDocumenter-XDoc'
}

{ #category : #testing }
XdHtmlType class >> matchesMimeType: aZnMimeType [
	"Return true if the document type is equivalent to the Zinc MIME type"
	<return: #Boolean>
	^ aZnMimeType matches: ZnMimeType textHtml
]

{ #category : #accessing }
XdHtmlType class >> typeString [
	"Return a unique string that represents the type"
	<return: #String>
	^ 'html'
]
