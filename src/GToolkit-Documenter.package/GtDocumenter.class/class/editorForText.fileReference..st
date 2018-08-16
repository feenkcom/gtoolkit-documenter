opening
editorForText: aString fileReference: aFileReference
	| text styler editor editorElement document completionStrategy completionController |

	text := aString asRopedText.
	document := GtDocument new.
	styler := GtPillarStyler new fileReference: aFileReference.
	styler document: document.
	editor := BrTextEditor new.
	editor styler: styler.
	editor text: text.
	editorElement := BrEditorElement new.
	editorElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent.
		c padding: (BlInsets all: 10) ].
	editorElement editor: editor.
	completionStrategy := GtDocumenterCompletionStrategy new.
	completionController := GtCompletionController on: editorElement strategy: completionStrategy.
	completionController install.
	^ editorElement