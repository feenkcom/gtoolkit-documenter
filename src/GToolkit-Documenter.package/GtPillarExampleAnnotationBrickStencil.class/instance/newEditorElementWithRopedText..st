instance creation
newEditorElementWithRopedText: aBrText
	<return: #BrEditorElement>
	| anEditor anEditorElement |
	
	anEditor := BrTextEditor new.
	anEditor text: aBrText.

	anEditorElement := BrEditorElement new.
	anEditorElement editor: anEditor.
	anEditorElement look: GtPillarTextEditorLook new.
	
	^ anEditorElement