Extension { #name : #XdWriter }

{ #category : #'*GToolkit-NewDocumenter' }
XdWriter >> pillar: aPillarDocument [
	| aPillarDocumentContent resources |
	aPillarDocumentContent := aPillarDocument text asString.
	
	self
		documentType: XdPillarType;
		attachment: aPillarDocument storage file basename text: aPillarDocumentContent.
		
	resources := aPillarDocument resourcer includeFigures; allDepth; compute.
	resources do: [ :eachResource | 
		eachResource resource binaryReadStreamDo: [ :stream | 
			self attachment: (GtFileUtility fileNameOf: eachResource resource relativeTo: aPillarDocument  rootDirectory ) stream: stream size: eachResource resource size ]]. 
]
