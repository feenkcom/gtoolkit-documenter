instance creation
newExecuteCodeSnippetAttribute
	^ GtPillarInlinedTextAdornmentDynamicAttribute new
		beAppend;
		stencil: [ :aBrText :aTextElement | 
			self newExecuteCodeButtonForText: aBrText inEditor: aTextElement ]