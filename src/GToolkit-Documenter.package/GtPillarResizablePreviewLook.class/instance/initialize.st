initialization
initialize
	super initialize.
	self add: (BrLayoutLook linearVertical 
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: self constants exactPreviewHeight ])