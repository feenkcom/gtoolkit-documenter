adding non-existent example class
addNonExistentExampleMethod
	<gtExample>
	<label: 'Add non-existent example method'>
	| aDocumentPart anAnnouncements |
	aDocumentPart := self documentPartWithNonExistentExampleClass.
	self assert: aDocumentPart isMethodClassDefined not.
	self assert: aDocumentPart isMethodDefined not.
	anAnnouncements := OrderedCollection new.
	aDocumentPart subscribe: GtDocumentAnnouncement do: [ :anAnnouncement | 
		anAnnouncements add: anAnnouncement ].
	GtDocumenterExamplesUtility 
		createClassNamed: aDocumentPart methodClassName 
		during: [ :theClass | 
			self assert: anAnnouncements size equals: 1.
			theClass 
				compile: aDocumentPart methodSelectorName, String cr, String tab, '<gtExample>'
				classified: 'example'.
			self assert: anAnnouncements size equals: 2.
			self assert: anAnnouncements second class equals: GtExampleClassUpdatedAnnouncement.
			self assert: anAnnouncements first codeSnippet equals: aDocumentPart.
			self assert: anAnnouncements first document equals: aDocumentPart document.
			self assert: aDocumentPart isMethodClassDefined.
			self assert: aDocumentPart isMethodDefined ].
	self assert: anAnnouncements size equals: 3.
	self assert: anAnnouncements third class equals: GtExampleClassUpdatedAnnouncement.
	self assert: anAnnouncements third codeSnippet equals: aDocumentPart.
	self assert: anAnnouncements third document equals: aDocumentPart document.
	^ aDocumentPart