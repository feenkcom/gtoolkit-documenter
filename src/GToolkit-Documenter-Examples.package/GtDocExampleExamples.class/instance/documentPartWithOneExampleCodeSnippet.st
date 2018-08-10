simple example definition
documentPartWithOneExampleCodeSnippet
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet'>
	| aDocument aDocumentPart |
	aDocument := self documentWithOneExampleCodeSnippet.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self assert: aDocumentPart methodName equals: self referencedExampleMethodName.
	self assert: aDocumentPart hasResult not.
	self assert: aDocumentPart shouldExpandPreview not.
	self assert: aDocumentPart shouldDisplaySourceCode.
	^ aDocumentPart