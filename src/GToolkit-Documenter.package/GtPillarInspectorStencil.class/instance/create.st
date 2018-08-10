api - instantiation
create
	| view |
	view := GtPhlowExplicitView on: self inspectedObject perform: self showMethod.
	^ view asElementDo: [ :element |
		element constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ] ]