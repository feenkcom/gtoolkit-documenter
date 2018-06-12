accessing
documentPartAtSameIndex
	<return: #GtPillarDocumentPart>
	| aDocumentPart |
	aDocumentPart := self document documentParts documentPartAt: self pillarNodeIndex.
	aDocumentPart pillarNode: self pillarNode.
	^ aDocumentPart