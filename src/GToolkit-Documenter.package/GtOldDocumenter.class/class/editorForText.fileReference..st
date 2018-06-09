opening
editorForText: aString fileReference: aFileReference
	| text styler editor editorElement document |

	text := aString asRopedText.
	document := GtOldDocument new.
	styler := GtOldPillarStyler new fileReference: aFileReference.
	styler workspace: document.
	editor := BrTextEditor new.
	editor styler: styler.
	editor text: text.
	editorElement := BrEditorElement new.
	editorElement padding: (BlInsets all: 10).
	editorElement constraintsDo: [ :c |
	    c horizontal matchParent.
	    c vertical matchParent ].
	editorElement editor: editor.

	^ GtPillarEditorElement new
		editorElement: editorElement;
		document: document;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ]