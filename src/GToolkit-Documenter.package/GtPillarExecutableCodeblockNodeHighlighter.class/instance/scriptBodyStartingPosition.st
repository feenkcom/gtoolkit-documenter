as yet unclassified
scriptBodyStartingPosition
	| aPillarNode |
	aPillarNode := self executableNode pillarNode.
	^ aPillarNode stop - self endMarkupSize - aPillarNode text size