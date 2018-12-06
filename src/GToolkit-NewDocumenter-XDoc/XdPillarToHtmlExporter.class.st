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
XdPillarToHtmlExporter >> export [
	| encoding document writer |
	encoding := [ self sourceFile binaryReadStreamDo: [ :aStream | 
			(ZnCharacterEncoder detectEncoding: aStream upToEnd) identifier ] ]
		on: ZnCharacterEncodingError
		do: [ nil ].
	self sourceFile binaryReadStreamDo: [ :aStream | | parser |
		parser := PRPillarParser new.
		parser sourceFile: self sourceFile.
		document := parser parse: (ZnCharacterReadStream on: aStream encoding: encoding) upToEnd ].
	
	writer := PRHTMLWriter new.
	^ writer write: document.
]
