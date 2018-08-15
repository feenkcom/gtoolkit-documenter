simple example definition
documentWithOneExampleCodeSnippet
	<gtExample>
	<label: 'Document with an example code snippet'>
	| aTextElement aDocument |
	aTextElement := self textElementWithOneExampleCodeSnippet.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	^ aDocument