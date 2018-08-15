adding non-existent example class
addNonExistentExampleMethod
	<gtExample>
	<label: 'Add non-existent example method'>
	| aDocument aPillarNode anAnnouncements |
	aDocument := self documentWithNonExistentExampleClass.
	aPillarNode := GtDocumenterExamplesUtility 
		subscriberThat: [ :eachSubscriber | eachSubscriber class = GtPillarExampleAnnotation ] 
		in: aDocument systemChangesHandler announcer.
	self assert: aPillarNode isMethodClassDefined not.
	self assert: aPillarNode isMethodDefined not.
	anAnnouncements := OrderedCollection new.
	aPillarNode subscribe: GtDocumentAnnouncement do: [ :anAnnouncement | 
		anAnnouncements add: anAnnouncement ].
	GtDocumenterExamplesUtility 
		createClassNamed: aPillarNode methodClassName 
		during: [ :theClass | 
			self assert: anAnnouncements size equals: 1.
			theClass 
				compile: aPillarNode methodDefinition selector, String cr, String tab, '<gtExample>'
				classified: 'example'.
			self assert: anAnnouncements size equals: 2.
			self assert: anAnnouncements second class equals: GtExampleClassUpdatedAnnouncement.
			self assert: anAnnouncements first codeSnippet equals: aPillarNode.
			self assert: anAnnouncements first document equals: aPillarNode document.
			self assert: aPillarNode isMethodClassDefined.
			self assert: aPillarNode isMethodDefined ].
	self assert: anAnnouncements size equals: 3.
	self assert: anAnnouncements third class equals: GtExampleClassUpdatedAnnouncement.
	self assert: anAnnouncements third codeSnippet equals: aPillarNode.
	self assert: anAnnouncements third document equals: aPillarNode document.
	^ aPillarNode