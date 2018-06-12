example with empty show definition
documentPartWithEmptyShowParameter
	<gtExample>
	<label: 'Document part with an example with an empty show parameter'>
	| aDocument aDocumentPart |
	aDocument := self documentWithEmptyShowParameter.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self assert: aDocumentPart methodName equals: self referencedExampleMethodName.
	self assert: aDocumentPart showMessageName equals: GtDocumenterConstants defaultShowMethodName.
	self assert: aDocumentPart shouldExpandPreview not.
	self assert: aDocumentPart hasResult not.
	^ aDocumentPart