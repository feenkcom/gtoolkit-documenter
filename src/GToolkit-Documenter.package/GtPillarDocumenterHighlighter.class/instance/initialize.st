initialization
initialize
	super initialize.
	document := GtDocument new.
	parser := PR2PillarParser new optimize.
	self resetOutCounter.
	self resetListItemCounter.