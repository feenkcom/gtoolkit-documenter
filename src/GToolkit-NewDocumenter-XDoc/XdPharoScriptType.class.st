Class {
	#name : #XdPharoScriptType,
	#superclass : #XdType,
	#category : #'GToolkit-NewDocumenter-XDoc'
}

{ #category : #testing }
XdPharoScriptType class >> matchesMimeType: aZnMimeType [
	"Return true if the document type is equivalent to the Zinc MIME type"
	<return: #Boolean>
	^ aZnMimeType matches: GtFilePharoScriptMimeTypeResolver mimeType
]

{ #category : #accessing }
XdPharoScriptType class >> typeString [
	"Return a unique string that represents the type"
	<return: #String>
	^ 'pharo-script'
]
