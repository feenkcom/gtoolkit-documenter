Class {
	#name : #XdPharoScriptToHtmlExporter,
	#superclass : #XdHtmlExporter,
	#category : #'GToolkit-NewDocumenter-XDoc-Exporter'
}

{ #category : #testing }
XdPharoScriptToHtmlExporter class >> matchesDocumentType: aXdDocumentTypeClass [ 
	"Return true if an exporter class supports a giver document type"
	<return: #Boolean>
	^ aXdDocumentTypeClass = XdPharoScriptType
]

{ #category : #actions }
XdPharoScriptToHtmlExporter >> export [
	"TODO Return a stream"
	self outputFile ensureDelete writeStreamDo: [ :writeStream | | html |
		html := ZnHtmlOutputStream on: writeStream.
		self writeHtmlToStream: html ].
]

{ #category : #private }
XdPharoScriptToHtmlExporter >> writeHtmlToStream: html [ 
	html tag: 'p' do: [ 
		html tag: 'a' attributes: #( 'id' 'pharo-script' ).
		html tag: 'figure' attributes: #( 'class' 'xdoc-pharo-script' ) do: [ 
			html tag: 'pre' do: [ 
				html tag: 'code' attributes: #( 'class' 'smalltalk' ) with: self sourceFile contents ] ] ].
]
