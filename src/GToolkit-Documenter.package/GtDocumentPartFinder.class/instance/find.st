actions
find
	<return: #GtPillarDocumentPart>
	self 
		assert: [ self pillarNodeIndex <= (self numberOfDocumentParts + 1) ] 
		description: [ 'A code snippet was skipped' ].
	(self pillarNodeIndex = (self numberOfDocumentParts + 1))
		ifTrue: [ ^ self newDocumentPartAtSameIndex ].
	self hasSimilarSourceCodeAtSameIndex
		ifTrue: [ ^ self documentPartAtSameIndex ].
	self hasSimilarSourceCodeAtFollowingIndex
		ifTrue: [
			self halt.
			self removeScriptAtSameIndex. 
			^ self documentPartAtSameIndex ]. 
	^ self newDocumentPartAtSameIndex