api - instantiation
create
	| view |
	view := self inspectedObject gtViewsFor: GtPhlowExplicitView new.	
	^ view asElementDo: [ :element |
		element constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ] ]