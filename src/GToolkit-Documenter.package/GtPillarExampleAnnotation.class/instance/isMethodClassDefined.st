testing
isMethodClassDefined
	| aMethodDefinition |
	aMethodDefinition := self methodDefinition.
	^ aMethodDefinition notNil and: [ aMethodDefinition parent isDefined ]