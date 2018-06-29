initialization
initialize
	super initialize.
	document := GtDocument new.
	"parser := PR2PillarParser new optimize."
	parser := PRPillarParser new optimize.
	self resetOutCounter.
	self resetListItemCounter.