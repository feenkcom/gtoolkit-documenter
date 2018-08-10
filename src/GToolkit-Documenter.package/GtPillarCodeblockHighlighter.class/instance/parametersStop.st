executable node - accessing
parametersStop
	<return: #Integer>
	| aPillarNode |
	aPillarNode := self documentPart pillarNode.	
	^ aPillarNode stop - aPillarNode text size - self endMarkupSize - 2