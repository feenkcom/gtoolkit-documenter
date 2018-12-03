Extension { #name : #XdWriter }

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
XdWriter >> document: aDocument [
	| aDocumentContent resources |
	aDocumentContent := aDocument editor text asString.
	
	self
		documentType: XdPillarType;
		attachment: aDocument name text: aDocumentContent.
		
	resources := aDocument resourcer includeFigures; allDepth; compute.
	resources do: [ :eachResource | 
		eachResource resource binaryReadStreamDo: [ :stream | 
			self attachment: (GtFileUtility fileNameOf: eachResource resource relativeTo: aDocument  rootDirectory ) stream: stream size: eachResource resource size ]].
]
