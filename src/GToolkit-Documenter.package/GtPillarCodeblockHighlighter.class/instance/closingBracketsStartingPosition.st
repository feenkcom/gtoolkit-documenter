as yet unclassified
closingBracketsStartingPosition
	<return: #Integer>
	| aPillarNode |
	aPillarNode := self documentPart pillarNode.	
	^ aPillarNode stop - self endMarkupSize