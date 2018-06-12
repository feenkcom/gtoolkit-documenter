simple example definition
documentPartWithOneExampleCodeSnippet
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet'>
	| aDocument aDocumentPart |
	aDocument := self documentWithOneExampleCodeSnippet.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self assert: aDocumentPart methodName equals: 'GtExampleCodeSnippetExamples>>#pillarContentWithOneExampleCodeSnippet'.
	self assert: aDocumentPart hasResult not.
	^ aDocumentPart