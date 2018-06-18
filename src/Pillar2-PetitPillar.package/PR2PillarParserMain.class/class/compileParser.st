compiled parser
compileParser
	PR2PillarParser new compileWithOptions: {#parserName: . self compiledParserName asSymbol}.
	^ Smalltalk classNamed: self compiledParserName
	