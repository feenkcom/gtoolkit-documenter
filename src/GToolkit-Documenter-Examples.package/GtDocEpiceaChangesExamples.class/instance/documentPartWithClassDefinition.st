class definition
documentPartWithClassDefinition
	<gtExample>
	<label: 'Document part with Epicea changes with class definition'>
	| aDocument |
	aDocument := self documentWithClassDefinition.
	self flag: 'We should likely remember Epicea document parts'.
	^ aDocument
"	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet epiceaLog notNil.
	self assert: aCodeSnippet epiceaLog ombuFile exists.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet"