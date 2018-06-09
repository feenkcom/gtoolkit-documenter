as yet unclassified
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
	self targetText
		attributes:
			{BrFontGenericFamilyAttribute monospace.
			(BrFontSizeAttribute size: 14)}
		from: self scriptBodyStartingPosition
		to: self scriptBodyEndPosition