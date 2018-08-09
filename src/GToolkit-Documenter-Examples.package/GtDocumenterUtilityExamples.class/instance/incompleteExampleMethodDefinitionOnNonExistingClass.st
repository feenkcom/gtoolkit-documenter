pillar - examples method parameter
incompleteExampleMethodDefinitionOnNonExistingClass
	<gtExample>
	| theMethods anArray |
	anArray := #(NotExistingClass).
	theMethods := self utility methodDefinitionsFromArray: anArray.
	self assert: theMethods notNil.
	self assert: theMethods isCollection.
	self assert: theMethods size equals: 0.
	^ theMethods