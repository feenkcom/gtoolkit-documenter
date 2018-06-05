private-styles
styleExpandingCode
	self targetText
		attributes: self expandingAttributes
		from: tokens closingBracketsEndPosition
		to: tokens closingBracketsEndPosition