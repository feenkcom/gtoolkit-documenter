as yet unclassified
scriptBodyStartingPosition
	| aPillarNode |
	aPillarNode := self documentPart pillarNode.
	^ aPillarNode stop - self endMarkupSize - aPillarNode text size