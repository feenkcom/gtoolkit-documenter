tests - List
testOrderedListMulti
	super testOrderedListMulti.
	self
		assert: result
		equals:
			(PROrderedList
				withAll:
					{(PRListItem
						withAll:
							{(PRText content: '1').
							(PROrderedList
								withAll:
									{(PRListItem
										withAll:
											{(PRText content: '2').
											(PROrderedList with: (PRListItem with: (PRText content: '3')))}).
									(PRListItem with: (PRText content: '4')).
									(PRListItem with: (PRText content: '5')).
									(PRListItem with: (PRText content: '6'))})}).
					(PRListItem
						withAll:
							{(PRText content: '7').
							(PROrderedList with: (PRListItem with: (PROrderedList with: (PRListItem with: (PRText content: '8')))))})}).
	self assertStart: 1 stop: 31.
	self assertStart: 1 stop: 24 ofNode: result children first.
	self assertStart: 2 stop: 2 ofNode: result children first children first.
	self assertStart: 4 stop: 12 ofNode: result children first children second.

	self assertStart: 25 stop: 31 ofNode: result children second.