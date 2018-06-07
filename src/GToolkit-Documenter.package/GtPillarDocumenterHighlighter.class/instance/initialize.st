initialization
initialize
	super initialize.
	document := GtDocument new.
	outsCounter := PRCascadingCounter maxLevel: 1.
	self resetListItemCounter.