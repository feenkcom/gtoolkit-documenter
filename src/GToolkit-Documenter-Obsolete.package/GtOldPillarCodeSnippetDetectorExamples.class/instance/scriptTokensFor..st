utility
scriptTokensFor: aString
	<return: #GtOldPillarScriptTokens>
	| scriptTokensInArray scriptTokens |
	scriptTokensInArray := self parserInstance 
		targetText: aString asRopedText;
		parse: aString.
	self assert: scriptTokensInArray isCollection.
	self assert: scriptTokensInArray size equals: 1.
	self assert: scriptTokensInArray first class equals: GtOldPillarScriptTokens.
	scriptTokens := scriptTokensInArray first.
	^ scriptTokens.