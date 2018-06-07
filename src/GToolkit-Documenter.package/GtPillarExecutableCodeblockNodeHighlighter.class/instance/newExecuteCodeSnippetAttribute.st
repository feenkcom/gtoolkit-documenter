as yet unclassified
newExecuteCodeSnippetAttribute
	self flag: 'Use elementBlockWithErrorCatching: instead of elementBlock:'.
	^ GtPillarInlinedTextAdornmentDynamicAttribute new
		beAppend;
		elementBlock: [ :aBrText :aTextElement | 
			self newExecuteCodeButtonForText: aBrText inEditor: aTextElement ]