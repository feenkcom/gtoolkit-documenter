executable node - accessing
parametersStop
	<return: #Integer>
	| aPillarNode |
	aPillarNode := self executableNode pillarNode.	
	^ aPillarNode stop - aPillarNode text size - self endMarkupSize - 1