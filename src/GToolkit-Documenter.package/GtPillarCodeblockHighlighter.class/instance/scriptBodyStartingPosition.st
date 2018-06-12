accessing - pillar node
scriptBodyStartingPosition
	| aPillarNode |
	aPillarNode := self documentPart pillarNode.
	^ aPillarNode stop - self endMarkupSize - aPillarNode text size - 1