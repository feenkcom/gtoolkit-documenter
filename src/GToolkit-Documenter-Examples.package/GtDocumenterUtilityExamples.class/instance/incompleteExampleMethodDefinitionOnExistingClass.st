pillar - examples method parameter
incompleteExampleMethodDefinitionOnExistingClass
	<gtExample>
	| theMethods anArray |
	anArray := #(GtDocumenterExamples).
	theMethods := self utility methodDefinitionsFromArray: anArray.
	self assert: theMethods notNil.
	self assert: theMethods isCollection.
	self assert: theMethods size equals: 0.
	^ theMethods