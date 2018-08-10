api - instantiation
create
	| view |
	view := self inspectedObject perform: self showMethod with: GtPhlowExplicitView new.	
	^ view asElementDo: [ :element |
		element constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ] ]