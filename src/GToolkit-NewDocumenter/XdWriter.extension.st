Extension { #name : #XdWriter }

{ #category : #'*GToolkit-NewDocumenter' }
XdWriter >> pillar: aPillarDocument [
	| aPillarDocumentContent resources |
	aPillarDocumentContent := aPillarDocument text asString.
	
	resources := aPillarDocument resourcer includeFigures; allDepth; compute.
	
	self
		documentType: XdPillarType;
		attachment: aPillarDocument storage file entry name text: aPillarDocumentContent.
]
