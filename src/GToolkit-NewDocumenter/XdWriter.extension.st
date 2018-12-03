Extension { #name : #XdWriter }

{ #category : #'*GToolkit-NewDocumenter' }
XdWriter >> document: aPillarDocument [
	| aPillarDocumentContent resources |
	aPillarDocumentContent := aPillarDocument editor text asString.
	
	self
		documentType: XdPillarType;
		attachment: aPillarDocument name text: aPillarDocumentContent.
		
	resources := aPillarDocument resourcer includeAll; allDepth; compute.
	resources do: [ :eachResource | 
		eachResource resource binaryReadStreamDo: [ :stream | 
			self attachment: (GtFileUtility fileNameOf: eachResource resource relativeTo: aPillarDocument  rootDirectory ) stream: stream size: eachResource resource size ]]. 
]
