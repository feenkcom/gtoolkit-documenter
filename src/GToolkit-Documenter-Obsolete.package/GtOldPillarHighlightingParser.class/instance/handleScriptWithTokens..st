handling
handleScriptWithTokens: tokens
	| handlerClass handler codeSnippet scriptTokens type |
	scriptTokens := GtOldPillarScriptTokens new.
	self fileReference ifNotNil: [ 
		scriptTokens sourceFileReference: self fileReference ].
	scriptTokens tokens: tokens.
	scriptIndex := scriptIndex + 1.
	codeSnippet := GtOldCodeSnippetFinder new
		document: workspace;
		scriptIndex: scriptIndex;
		tokens: scriptTokens;
		find.
	type := GtOldPillarCodeSnippetDetector typeForScriptTokens: scriptTokens.
	handlerClass := type brickHandlerClass.
	handler := handlerClass new.
	handler
		tokens: scriptTokens;
		targetText: self targetText;
		sourceFile: self fileReference;
		codeSnippet: codeSnippet;
		handle.
	 ^ scriptTokens