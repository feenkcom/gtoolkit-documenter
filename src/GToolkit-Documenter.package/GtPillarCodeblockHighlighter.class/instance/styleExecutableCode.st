private-styles
styleExecutableCode
	(self targetText
		from: self closingBracketsStartingPosition
		to: self closingBracketsEndPosition - 1)
			attributes: { self newExecuteCodeSnippetAttribute }