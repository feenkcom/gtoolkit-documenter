failed executable code snippet
codeSnippetOfDocumentWithFailedExecutableCodeSnippet
	<gtExample>
	<label: 'Code snippet of a document with an executable code snippet'>
	| aDocument aDocumentPart anAnnouncements |
	aDocument := self documentWithFailedExecutableCodeSnippet.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self assert: aDocumentPart label equals: 'Compute'.
	anAnnouncements := OrderedCollection new.
	aDocumentPart announcer 
		when: Announcement 
		do: [ :signal | anAnnouncements add: signal ].
	aDocumentPart executeWithPlaygroundStrategy.
	self assert: aDocumentPart hasResult.
	self assert: aDocumentPart result notNil.
	self assert: aDocumentPart result class equals: ZeroDivide.
	self assert: aDocumentPart isException.
	self assert: anAnnouncements size equals: 1.
	self assert: anAnnouncements first class equals: GtCodeSnippetFailedExecutionAnnouncement.
	self assert: anAnnouncements first exception class equals: ZeroDivide.
	self assert: anAnnouncements first codeSnippet equals: aDocumentPart.
	self assert: anAnnouncements first document equals: aDocument.
	^ anAnnouncements first