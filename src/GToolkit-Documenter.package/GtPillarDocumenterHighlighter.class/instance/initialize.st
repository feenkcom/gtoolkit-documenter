initialization
initialize
	super initialize.
	document := GtDocument new.
	parser := PRPillarParser new optimize.
	self resetOutCounter.
	self resetListItemCounter.