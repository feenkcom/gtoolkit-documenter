utility - accessing
textElementForPillarFileReference: aFileReference
	<return: #BrEditorElement>
	| editorElement |
	editorElement := GtDocumenter editorForPillar: aFileReference.
	self assert: editorElement notNil.
	^ editorElement