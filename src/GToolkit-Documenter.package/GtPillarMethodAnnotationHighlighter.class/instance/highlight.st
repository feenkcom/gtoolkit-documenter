api - actions
highlight
	(self targetText from: self pillarNode start to: self pillarNode stop)
		foreground: Color gray.
	self initializeReferencedMethod.
	self styleReferenceParameter.
	self styleExpandingParameter