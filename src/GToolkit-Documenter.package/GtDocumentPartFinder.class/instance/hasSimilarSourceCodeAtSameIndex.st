testing
hasSimilarSourceCodeAtSameIndex
	^ (self pillarNodeAtSameIndex text = self pillarNode text) or: [ 
		self pillarNode text endsWith: self pillarNodeAtSameIndex text ]