initialization
initialize
	super initialize.
	outsCounter := PRCascadingCounter maxLevel: 1.
	self resetListItemCounter.