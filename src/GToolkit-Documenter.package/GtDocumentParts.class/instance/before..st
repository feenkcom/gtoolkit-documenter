accessing
before: aGtPillarDocumentExecutablePart 
	<return: #LiteralVariable or: nil>
	| anIndex |
	anIndex := collection indexOf: aGtPillarDocumentExecutablePart.
	anIndex < 1 ifTrue: [ ^ nil ].
	^ (collection at: anIndex - 1) result