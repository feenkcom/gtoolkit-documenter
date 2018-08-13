brick
newPharoEditorElementFor: aBlText styler: aStyler
	<return: #BrEditorElement>
	| aTextEditor anEditorElement |
	aBlText attributes: {
		BrFontGenericFamilyAttribute monospace beNotOverwritableByStyler.
		(BrFontSizeAttribute size: 14) beNotOverwritableByStyler }.
	aTextEditor := BrTextEditor new.
	aTextEditor styler: aStyler.
	aTextEditor text: aBlText.
	anEditorElement := BrEditorElement new.
	^ anEditorElement editor: aTextEditor.
	