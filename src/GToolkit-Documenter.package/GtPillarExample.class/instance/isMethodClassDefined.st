testing
isMethodClassDefined
	^ self methodDefinition notNil and: [ self methodDefinition parent isDefined ]