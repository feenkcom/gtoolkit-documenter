testing
hasSimilarSourceCodeAtFollowingIndex
	^ self numberOfDocumentParts > self pillarNodeIndex and: [ 
		(self pillarNodeAtFollowingIndex text = self pillarNode text) or: [ 
			self pillarNode text endsWith: self pillarNodeAtFollowingIndex text ] ]