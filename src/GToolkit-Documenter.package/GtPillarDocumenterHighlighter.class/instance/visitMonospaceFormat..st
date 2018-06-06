visiting
visitMonospaceFormat: aPRMonospaceFormat
	self targetText 
			attributes: { 
				BrFontGenericFamilyAttribute monospace. 
				BrTextForegroundAttribute paint: Color darkGray }
			from: aPRMonospaceFormat start
			to: aPRMonospaceFormat stop 