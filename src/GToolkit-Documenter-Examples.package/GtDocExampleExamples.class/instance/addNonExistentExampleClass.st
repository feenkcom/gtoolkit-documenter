adding non-existent example class
addNonExistentExampleClass
	<gtExample>
	<label: 'Add non-existent example class'>
	| aDocument aPillarNode anAnnouncements |
	aDocument := self documentWithNonExistentExampleClass.
	aPillarNode := GtDocumenterExamplesUtility 
		subscriberThat: [ :eachSubscriber | eachSubscriber class = GtPillarExampleAnnotation ] 
		in: aDocument systemChangesHandler announcer.
	self assert: aPillarNode isMethodClassDefined not.
	anAnnouncements := OrderedCollection new.
	aPillarNode subscribe: GtDocumentAnnouncement do: [ :anAnnouncement | 
		anAnnouncements add: anAnnouncement ].
	GtDocumenterExamplesUtility 
		createClassNamed: aPillarNode methodClassName 
		during: [ 
			self assert: anAnnouncements size equals: 1.
			self assert: anAnnouncements first class equals: GtExampleClassUpdatedAnnouncement.
			self assert: anAnnouncements first codeSnippet equals: aPillarNode.
			self assert: anAnnouncements first document equals: aPillarNode document.
			self assert: aPillarNode isMethodClassDefined.
			self assert: aPillarNode isMethodDefined not ].
	self assert: anAnnouncements size equals: 2.
	self assert: anAnnouncements second class equals: GtExampleClassUpdatedAnnouncement.
	self assert: anAnnouncements second codeSnippet equals: aPillarNode.
	self assert: anAnnouncements second document equals: aPillarNode document.
	^ aPillarNode