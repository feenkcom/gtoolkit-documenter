Class {
	#name : #XdPillarToHtmlExporter,
	#superclass : #XdHtmlExporter,
	#category : #'GToolkit-NewDocumenter-XDoc-Exporter'
}

{ #category : #testing }
XdPillarToHtmlExporter class >> matchesDocumentType: aXdDocumentTypeClass [ 
	"Return true if an exporter class supports a giver document type"
	<return: #Boolean>
	^ aXdDocumentTypeClass = XdPillarType
]

{ #category : #actions }
XdPillarToHtmlExporter >> export: aStream [
	| document |
	
	document := PRPillarParser new parse: aStream.
	^ PRHTMLWriter new write: document.
]
