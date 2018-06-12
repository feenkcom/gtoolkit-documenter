non-existent example method
documentPartWithNonExistentExampleMethod
	<gtExample>
	<label: 'Document part with an example with non-existent example method'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithNonExistentExampleMethod.
	aCodeSnippet := aDocument documentParts documentPartAt: 1.
	self assert: aCodeSnippet methodName equals: self className, '>>#nonExistentMethod'.
	self assert: aCodeSnippet shouldDisplayResult.
	self assert: aCodeSnippet shouldExpandPreview not.
	self assert: aCodeSnippet isMethodDefined not.
	self assert: aCodeSnippet isMethodClassDefined.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet