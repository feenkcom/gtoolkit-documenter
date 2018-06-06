api - instantiation
buildDefault
	| anOutputText |
	
	anOutputText := ('(outs at: ' , self annotation counter asString , ')') asRopedText.
	anOutputText monospace.
	anOutputText foreground: "(self codeSnippet isException
		ifTrue: [ Color red ]
		ifFalse: [" Color gray "])".

	^ GtPillarResultPreviewStencil new
		result: "self codeSnippet value" 4;
		outputInformation: anOutputText