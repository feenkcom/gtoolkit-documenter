accessing
script
	| endParser startParser |
	endParser := ((EndMarkups at: PRCodeblock) asParser token, space star , lineEnd) 
		==> [ :t | t first ].
	startParser := (Markups at: PRCodeblock) asParser token, scriptParameters , endParser negate star token, endParser.
	^ startParser ==> [ :tokens | | scriptTokens scriptType |
		scriptTokens := GtOldPillarScriptTokens new.
		scriptTokens sourceFileReference: self sourceFile.
		scriptTokens tokens: tokens.
		scriptType := GtOldPillarCodeSnippetDetector typeForScriptTokens: scriptTokens.
		scriptType parserHandlerClass tokens: scriptTokens ].