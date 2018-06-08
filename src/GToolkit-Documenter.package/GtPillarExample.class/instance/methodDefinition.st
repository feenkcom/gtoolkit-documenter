pillar node - accessing
methodDefinition
	methodDefinition ifNil: [ self initializeMethodDefinition ].
	^ methodDefinition