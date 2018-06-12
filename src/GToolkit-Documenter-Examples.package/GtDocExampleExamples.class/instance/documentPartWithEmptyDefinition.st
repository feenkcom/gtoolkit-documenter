empty example definition
documentPartWithEmptyDefinition
	<gtExample>
	<label: 'Document part with an example code snippet with empty definition'>
	| aDocument aDocumentPart |
	aDocument := self documentWithEmptyDefinition.
	self flag: 'We should handle PRError differently'.
	aDocument class = PRError ifTrue: [ ^ aDocument ].
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self assert: aDocumentPart hasResult not.
	^ aDocumentPart