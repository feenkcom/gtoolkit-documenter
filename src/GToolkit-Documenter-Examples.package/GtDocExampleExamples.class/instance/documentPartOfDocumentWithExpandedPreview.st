example with expanded preview
documentPartOfDocumentWithExpandedPreview
	<gtExample>
	<label: 'Code snippet of a document with an example with expanded preview'>
	| aDocument adocumentPart |
	aDocument := self documentWithExpandedPreview.
	adocumentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: adocumentPart methodName 
		equals: self referencedExampleMethodName.
	self assert: adocumentPart showMessageName equals: GtDocumenterConstants defaultShowMethodName.
	self assert: adocumentPart shouldExpandPreview.
	self assert: adocumentPart hasResult not.
	^ adocumentPart