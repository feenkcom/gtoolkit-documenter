Class {
	#name : #XdImageToHtmlExporter,
	#superclass : #XdHtmlExporter,
	#category : #'GToolkit-NewDocumenter-XDoc-Exporter'
}

{ #category : #testing }
XdImageToHtmlExporter class >> matchesDocumentType: aXdDocumentTypeClass [ 
	"Return true if an exporter class supports a giver document type"
	<return: #Boolean>
	^ aXdDocumentTypeClass = XdImageType
]

{ #category : #actions }
XdImageToHtmlExporter >> export [
	"TODO Return a stream"
	self outputFile ensureDelete writeStreamDo: [ :writeStream |
		self writeHtmlToStream: writeStream ].
]

{ #category : #private }
XdImageToHtmlExporter >> rootSourceFileName [
	<return: #String>
	^ GtFileUtility 
		fileNameOf: self sourceFile
		relativeTo: self sourceFile parent.
]

{ #category : #private }
XdImageToHtmlExporter >> writeHtmlToStream: aWriteStream [
	aWriteStream 
		nextPutAll: '
	<p>
		<a id="image"></a>
		<figure>
			<img src="'; 
		nextPutAll: self rootSourceFileName;
		nextPutAll: '"/>
			<figcaption>Image</figcaption>
		</figure>
	</p>'
]
