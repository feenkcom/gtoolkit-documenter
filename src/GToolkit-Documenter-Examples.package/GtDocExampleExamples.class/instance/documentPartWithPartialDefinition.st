partial example definition
documentPartWithPartialDefinition
	<gtExample>
	<label: 'Document part with an example with partial definition'>
	| aDocument aDocumentPart |
	aDocument := self documentWithPartialDefinition.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self assert: aDocumentPart methodName equals: self className, '>>#'''''.
	self assert: aDocumentPart shouldDisplayResult.
	self assert: aDocumentPart shouldExpandPreview not.
	self assert: aDocumentPart isMethodDefined not.
	self assert: aDocumentPart isMethodClassDefined.
	self assert: aDocumentPart hasResult not.
	^ aDocumentPart