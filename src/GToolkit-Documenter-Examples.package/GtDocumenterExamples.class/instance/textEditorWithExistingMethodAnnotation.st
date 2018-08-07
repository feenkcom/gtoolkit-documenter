method - existing one
textEditorWithExistingMethodAnnotation
	<gtExample>
	| aPillarElement aBrTextEditor anAttributes |
	aPillarElement := self pillarElementWithExistingMethodAnnotation.
	aBrTextEditor := (GtDocumenterExamplesUtility editorFromPillarElement: aPillarElement).
	self assert: aBrTextEditor notNil.
	anAttributes := aBrTextEditor text attributesAt: 1.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	anAttributes := aBrTextEditor text attributesAt: 10.
	self assert: anAttributes size equals: 4.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextForegroundAttribute.
	self assert: anAttributes third class equals: BrTextHoverAttribute.
	self assert: anAttributes fourth class equals: BrTextClickAttribute.
	anAttributes := aBrTextEditor text attributesAt: aBrTextEditor text size.
	self assert: anAttributes size equals: 2.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextExpandButtonAttribute.
	^ aBrTextEditor