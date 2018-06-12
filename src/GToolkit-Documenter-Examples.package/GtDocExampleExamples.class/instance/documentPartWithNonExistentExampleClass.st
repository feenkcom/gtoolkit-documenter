non-existent example class
documentPartWithNonExistentExampleClass
	<gtExample>
	<label: 'Document part with an example with non-existent example class'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithNonExistentExampleClass.
	aCodeSnippet := aDocument documentParts documentPartAt: 1.
	self assert: aCodeSnippet methodName equals: 'GtDocumenterNonExistentClass>>#nonExistentMethod'.
	self assert: aCodeSnippet shouldDisplayResult.
	self assert: aCodeSnippet shouldExpandPreview not.
	self assert: aCodeSnippet isMethodDefined not.
	self assert: aCodeSnippet isMethodClassDefined not.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet