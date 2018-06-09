accessing
index
	<return: #Integer>
	| aCollection aResult |
	self
		assert: [ self pillarNode notNil ]
		description: [ 'Pillar node has to be initialized first' ].
	self 
		assert: [ self pillarNode counter notNil ]
		description: [ 'Pillar node counter has to be initialized first' ].
	self 
		assert: [ self pillarNode counter isValidCounter ]
		description: [ 'Pillar node counter has to be a valid counter' ].
	aCollection := self pillarNode counter elements.
	aResult := 0.
	aCollection withIndexDo: [ :aValue :anIndex |
		aResult := aResult + (aValue * (10 raisedTo: (aCollection size - anIndex))) ].
	^ aResult 