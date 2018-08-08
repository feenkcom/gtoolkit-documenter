api - actions
highlight
	self initializeReferencedClass.
	(self targetText from: self pillarNode start to: self pillarNode stop)
		foreground: Color gray.
	self styleReferenceParameter.
	self styleExpandingView