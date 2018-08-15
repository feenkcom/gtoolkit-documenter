testing
isMethodDefined
	| aMethodDefinition |
	aMethodDefinition := self methodDefinition.
	^ aMethodDefinition notNil and: [ aMethodDefinition isDefined ]