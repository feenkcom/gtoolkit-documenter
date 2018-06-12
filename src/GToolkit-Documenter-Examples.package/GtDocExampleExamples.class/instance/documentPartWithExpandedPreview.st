example with expanded preview
documentPartWithExpandedPreview
	<gtExample>
	<label: 'Code snippet of a document with an example with expanded preview'>
	| aDocument aDocumentPart |
	aDocument := self documentWithExpandedPreview.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: aDocumentPart methodName 
		equals: self referencedExampleMethodName.
	self assert: aDocumentPart showMessageName equals: GtDocumenterConstants defaultShowMethodName.
	self assert: aDocumentPart shouldExpandPreview.
	self assert: aDocumentPart hasResult not.
	^ aDocumentPart