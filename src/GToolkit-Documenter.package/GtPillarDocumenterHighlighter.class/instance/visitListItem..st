visiting
visitListItem: aPRListItem
	| anItemIndex |
	listItemCounter incrementAt: 1.
	anItemIndex := listItemCounter printString asString.
	self targetText 
		attributes: {
			BrTextAdornmentDynamicAttribute new 
				beAppend; 
				elementBlock: [ 
					| indexText |
					indexText := anItemIndex asRopedText.
					indexText attributes: { 
						BrFontSizeAttribute size: 9. 
						BrTextForegroundAttribute paint: Color lightGray }.
					BlTextElement new text: indexText ] }
		from: aPRListItem start
		to: aPRListItem start