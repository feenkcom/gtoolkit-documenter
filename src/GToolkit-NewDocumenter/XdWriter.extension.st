Extension { #name : #XdWriter }

{ #category : #'*GToolkit-NewDocumenter' }
XdWriter >> pillar: aPillarDocument [
	| aPillarDocumentContent |
	aPillarDocumentContent := aPillarDocument text asString.
	self
		documentType: XdPillarType;
		attachment: aPillarDocument storage file entry name text: aPillarDocumentContent.
]
