accessing
codeSnippetAt: anInteger 
	<return: #GtOldCodeSnippetResult>
	self flag: 'remove it'.
	self assert: [ anInteger <= (codeSnippets size + 1) ] description: [ 'A code snippet was skipped' ].
	(codeSnippets size + 1) = anInteger ifTrue: [ | newScript |
		newScript := GtOldCodeSnippetResult new.
		newScript document: self ].
	^ codeSnippets codeSnippetAt: anInteger