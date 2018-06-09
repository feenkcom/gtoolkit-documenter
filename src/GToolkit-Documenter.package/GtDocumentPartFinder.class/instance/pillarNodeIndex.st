accessing
pillarNodeIndex
	<return: #Integer>
	| aCollection aResult |
	aCollection := self pillarNode counter elements.
	aResult := 0.
	aCollection withIndexDo: [ :aValue :anIndex |
		aResult := aResult + (aValue * (10 raisedTo: (aCollection size - anIndex))) ].
	^ aResult 