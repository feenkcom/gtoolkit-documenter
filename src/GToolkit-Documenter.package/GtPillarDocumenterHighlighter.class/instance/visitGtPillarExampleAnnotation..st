visiting
visitGtPillarExampleAnnotation: aGtPillarExampleAnnotation
	aGtPillarExampleAnnotation document: self document.
	self document systemChangesHandler
		subscribe: MethodAdded, MethodModified, MethodRemoved
		send: #handleMethodAnnouncement:
		to: aGtPillarExampleAnnotation
		for: aGtPillarExampleAnnotation.
	self document systemChangesHandler
		subscribe: ClassAdded, ClassRemoved
		send: #handleClassAddedOrRemovedAnnouncement:
		to: aGtPillarExampleAnnotation
		for: aGtPillarExampleAnnotation.
	self document systemChangesHandler
		subscribe: ClassRenamed
		send: #handleClassRenamedAnnouncement:
		to: aGtPillarExampleAnnotation
		for: aGtPillarExampleAnnotation.
	GtPillarExampleHighlighter highlight: aGtPillarExampleAnnotation using: self.