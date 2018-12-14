Extension { #name : #XdWriter }

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
XdWriter >> document: aDocument [
	| aDocumentContent resources indexContent|
	
	aDocumentContent := aDocument text asString.
	indexContent := XdPillarToHtmlExporter new export: aDocumentContent.

	self
		documentType: XdDocumenterType;
		attachment: aDocument basename text: aDocumentContent;
		attachment: 'index.html' text: indexContent.
		
	resources := aDocument resourcer includeFigures; allDepth; compute.
	resources do: [ :eachResource | 
		eachResource resource binaryReadStreamDo: [ :stream | 
			self attachment: (GtFileUtility fileNameOf: eachResource resource relativeTo: aDocument  rootDirectory ) stream: stream size: eachResource resource size ]].
]
