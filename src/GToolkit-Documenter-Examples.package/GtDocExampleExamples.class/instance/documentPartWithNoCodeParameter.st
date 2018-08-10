example with noCode parameter
documentPartWithNoCodeParameter
	<gtExample>
	<label: 'Code snippet of a document with an example'>
	| aDocument aDocumentPart |
	aDocument := self documentWithNoCodeParameter.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: aDocumentPart methodName 
		equals: self referencedExampleMethodName.
	self assert: aDocumentPart showMessageName equals: GtDocumenterConstants defaultShowMethodName.
	self assert: aDocumentPart shouldExpandPreview.
	self assert: aDocumentPart shouldDisplaySourceCode not.
	self assert: aDocumentPart hasResult not.
	^ aDocumentPart