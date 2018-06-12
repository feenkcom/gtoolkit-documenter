private-styles
styleExecutableCode
	self targetText
		attributes: { self newExecuteCodeSnippetAttribute }
		from: self closingBracketsStartingPosition
		to: self closingBracketsEndPosition - 1