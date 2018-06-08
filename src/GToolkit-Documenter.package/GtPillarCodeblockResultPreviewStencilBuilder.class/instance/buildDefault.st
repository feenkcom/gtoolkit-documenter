api - instantiation
buildDefault
	| anOutputText |
	
	anOutputText := ('(outs at: ' , self documentPart pillarNode counter asString , ')') asRopedText.
	anOutputText monospace.
	anOutputText foreground: (self documentPart isException
		ifTrue: [ Color red ]
		ifFalse: [ Color gray ]).

	^ GtPillarResultPreviewStencil new
		result: self documentPart result;
		outputInformation: anOutputText