initialization
initialize
	super initialize.
	document := GtDocument new.
	parser := PR2PillarParser new optimize.
	outsCounter := PRCascadingCounter maxLevel: 1.
	self resetListItemCounter.