document registered to system changes
registeredDocument
	<gtExample>
	<label: 'Ensure that document is registered to system changes'>
	| aDocument aSubscriptions aDocumentPart aCounter |
	aDocument := self emptyDocument.
	aDocumentPart := GtPillarExample new.
	aCounter := PRCascadingCounter maxLevel: 1.
	aCounter incrementAt: 1.
	aDocumentPart pillarNode: (GtPillarExampleAnnotation new counter: aCounter).
	aDocumentPart document: aDocument.
	aSubscriptions := SystemAnnouncer uniqueInstance subscriptions subscriptions 
		select: [ :eachSubscription | eachSubscription subscriber = aDocument systemChangesHandler ].
	self assert: aSubscriptions isCollection.
	self assert: aSubscriptions size equals: 1.
	self assert: (aSubscriptions anyOne isKindOf: WeakAnnouncementSubscription).
	^ aDocument.