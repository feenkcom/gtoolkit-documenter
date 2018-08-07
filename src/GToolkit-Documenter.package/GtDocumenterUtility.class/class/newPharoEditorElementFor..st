brick
newPharoEditorElementFor: aBlText
	| aTextEditor anEditorElement |
	aBlText attributes: {
		BrFontGenericFamilyAttribute monospace beNotOverwritableByStyler.
		(BrFontSizeAttribute size: 14) beNotOverwritableByStyler }.
	aTextEditor := BrTextEditor new.
	aTextEditor styler: (BrRBTextStyler new workspace: GtHighlightingBindingStrategy new).
	aTextEditor text: aBlText.
	anEditorElement := BrEditorElement new.
	^ anEditorElement editor: aTextEditor.
	