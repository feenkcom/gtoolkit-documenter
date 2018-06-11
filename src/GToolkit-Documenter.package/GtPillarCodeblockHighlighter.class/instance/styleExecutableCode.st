private-styles
styleExecutableCode
	self targetText
		attributes: { self newExecuteCodeSnippetAttribute }
		from: self closingBracketsEndPosition
		to: self closingBracketsEndPosition