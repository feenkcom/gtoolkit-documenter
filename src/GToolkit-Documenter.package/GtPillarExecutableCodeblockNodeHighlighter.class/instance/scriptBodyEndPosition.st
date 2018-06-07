as yet unclassified
scriptBodyEndPosition
	<return: #Integer>
	| aPillarNode |
	aPillarNode := self executableNode pillarNode.	
	^ aPillarNode stop - self endMarkupSize - 1