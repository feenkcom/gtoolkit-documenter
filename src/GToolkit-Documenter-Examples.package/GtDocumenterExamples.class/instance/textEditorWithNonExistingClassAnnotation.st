class - missing one
textEditorWithNonExistingClassAnnotation
	<gtExample>
	| aPillarElement aBrTextEditor anAttributes |
	aPillarElement := self pillarElementWithNonExistingClassAnnotation.
	aBrTextEditor := (GtDocumenterExamplesUtility editorFromPillarElement: aPillarElement).
	self assert: aBrTextEditor notNil.
	anAttributes := aBrTextEditor text attributesAt: 1.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	anAttributes := aBrTextEditor text attributesAt: 9.
	self assert: anAttributes size equals: 2.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second paint equals: Color red.
	anAttributes := aBrTextEditor text attributesAt: aBrTextEditor text size.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	^ aBrTextEditor