Class {
	#name : #GtOldDocumenter,
	#superclass : #Object,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #opening }
GtOldDocumenter class >> editorForPillar: aPillarFile [
	| aFileReference |
	
	aFileReference := aPillarFile asFileReference.

	^ self
		editorForText: aFileReference contents
		fileReference: aFileReference
]

{ #category : #opening }
GtOldDocumenter class >> editorForText: aString [

	^ self
		editorForText: aString
		fileReference: FileSystem workingDirectory
]

{ #category : #opening }
GtOldDocumenter class >> editorForText: aString fileReference: aFileReference [
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
]

{ #category : #opening }
GtOldDocumenter class >> openPillar: aPillarFile [
	| aSpace |

	aSpace := BlSpace new.
	aSpace title: aPillarFile asFileReference basename.
	aSpace root addChild: (self editorForPillar: aPillarFile).
	aSpace show
]
