accessing - pillar node
scriptBodyEndPosition
	<return: #Integer>
	| aPillarNode |
	aPillarNode := self documentPart pillarNode.	
	^ aPillarNode stop - self endMarkupSize - 1