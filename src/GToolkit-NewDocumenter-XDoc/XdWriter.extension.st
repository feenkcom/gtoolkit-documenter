Extension { #name : #XdWriter }

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
XdWriter >> document: aDocument [
	| aDocumentContent resources aDocumentBuilder indexContent|
	aDocumentContent := aDocument editor text asString.
	
	aDocumentBuilder := XdPillarToHtmlExporter new.
	aDocumentBuilder sourceFile: aDocument storage file.
	indexContent := aDocumentBuilder export.

	self
		documentType: XdPillarType;
		attachment: aDocument name text: aDocumentContent;
		attachment: 'index.html' text: indexContent.
		
	resources := aDocument resourcer includeFigures; allDepth; compute.
	resources do: [ :eachResource | 
		eachResource resource binaryReadStreamDo: [ :stream | 
			self attachment: (GtFileUtility fileNameOf: eachResource resource relativeTo: aDocument  rootDirectory ) stream: stream size: eachResource resource size ]].
]
