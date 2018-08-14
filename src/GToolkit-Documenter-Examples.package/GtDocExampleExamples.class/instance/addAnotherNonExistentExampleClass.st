adding non-existent example class
addAnotherNonExistentExampleClass
	<gtExample>
	<label: 'Add another non-existent example class'>
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
		createClassNamed: (aPillarNode methodClassName, 'Two') asSymbol
		during: [ 
			self assert: anAnnouncements isEmpty.
			self assert: aPillarNode isMethodClassDefined not.
			self assert: aPillarNode isMethodDefined not ].
	self assert: anAnnouncements isEmpty.
	^ aPillarNode