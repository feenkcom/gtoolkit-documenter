Extension { #name : #XdWriter }

{ #category : #'*GToolkit-NewDocumenter' }
XdWriter >> pillar: aPillarDocument [
	| aPillarDocumentContent resources |
	aPillarDocumentContent := aPillarDocument text asString.
	
	resources := aPillarDocument collectResources.
	
	self
		documentType: XdPillarType;
		attachment: aPillarDocument storage file entry name text: aPillarDocumentContent.
]
