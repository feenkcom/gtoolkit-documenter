private-container protocol
highlight
	self targetText 
		attributes: { BrTextForegroundAttribute paint: Color gray }
		from: self pillarNodeStart
		to: self pillarNodeStop.
	self targetText
		attributes: self expandingAttributes
		from: self pillarNodeStop
		to: self pillarNodeStop