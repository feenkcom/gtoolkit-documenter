pillar - examples method parameter
nonExistingExampleMethod
	<gtExample>
	| theMethods anArray |
	anArray := #(GtDocumenterExamples>>#nonExistingMethod).
	theMethods := self utility methodDefinitionsFromArray: anArray.
	self assert: theMethods notNil.
	self assert: theMethods isCollection.
	self assert: theMethods size equals: 1.
	self assert: theMethods first methodClass equals: GtDocumenterExamples.
	self assert: theMethods first selector equals: #nonExistingMethod.
	^ theMethods