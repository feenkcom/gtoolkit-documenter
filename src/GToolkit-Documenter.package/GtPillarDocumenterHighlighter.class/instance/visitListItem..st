visiting
visitListItem: aPRListItem
	| anItemIndex |
	listItemCounter incrementAt: 1.
	anItemIndex := listItemCounter printString asString.
	(self targetText
		from: aPRListItem start
		to: aPRListItem start)
			attributes: {
				BrTextAdornmentDynamicAttribute new 
					beAppend; 
					stencil: [
						| indexText |
						indexText := anItemIndex asRopedText.
						indexText fontSize: 9.
						indexText foreground: Color lightGray.
						BlTextElement new text: indexText ] }