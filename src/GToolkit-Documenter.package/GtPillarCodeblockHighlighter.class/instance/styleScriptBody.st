private-styles
styleScriptBody
	| styler strategy |
	styler := BrRBTextStyler new.
	strategy := GtHighlightingBindingStrategy bindings: self documentPart outBindings.
	styler workspace: strategy.
	styler
		style:
			(self targetText
				from: self scriptBodyStartingPosition
				to: self scriptBodyEndPosition).

	(self targetText
		from: self scriptBodyStartingPosition
		to: self scriptBodyEndPosition)
			monospace;
			fontSize: 14