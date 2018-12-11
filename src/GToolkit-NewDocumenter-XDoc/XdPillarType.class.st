Class {
	#name : #XdPillarType,
	#superclass : #XdType,
	#category : #'GToolkit-NewDocumenter-XDoc'
}

{ #category : #testing }
XdPillarType class >> matchesMimeType: aZnMimeType [
	"Return true if the document type is equivalent to the Zinc MIME type"
	<return: #Boolean>
	^ aZnMimeType matches: GtFilePillarMimeTypeResolver mimeType
]

{ #category : #accessing }
XdPillarType class >> typeString [
	"Return a unique string that represents the type"
	<return: #String>
	^ 'pillar'
]
