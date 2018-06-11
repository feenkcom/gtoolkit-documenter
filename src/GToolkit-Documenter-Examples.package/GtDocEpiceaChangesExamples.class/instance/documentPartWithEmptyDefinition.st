empty example definition
documentPartWithEmptyDefinition
	<gtExample>
	<label: 'Code snippet of a document with an Epicea code changes with empty definition'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithEmptyDefinition.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet epiceaLog notNil.
	self assert: aCodeSnippet epiceaLog ombuFile exists not.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet