figure - not existing file
textEditorWithNonExistingFigureFile
	<gtExample>
	| aPillarElement aBrTextEditor anAttributes |
	aPillarElement := self pillarElementWithNonExistingFigureFile.
	aBrTextEditor := (GtDocumenterExamplesUtility editorFromPillarElement: aPillarElement).
	self assert: aBrTextEditor notNil.
	anAttributes := aBrTextEditor text attributesAt: 1.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color red.
	^ aBrTextEditor