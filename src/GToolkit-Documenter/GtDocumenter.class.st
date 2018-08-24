Class {
	#name : #GtDocumenter,
	#superclass : #Object,
	#category : 'GToolkit-Documenter-Core'
}

{ #category : #opening }
GtDocumenter class >> editorForPillar: aPillarFile [
	| aFileReference |
	
	aFileReference := aPillarFile asFileReference.

	^ self
		editorForText: aFileReference contents
		fileReference: aFileReference
]

{ #category : #opening }
GtDocumenter class >> editorForText: aString [

	^ self
		editorForText: aString
		fileReference: FileSystem workingDirectory
]

{ #category : #opening }
GtDocumenter class >> editorForText: aString fileReference: aFileReference [
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
	completionStrategy fileReference: aFileReference.
	completionController := GtCompletionController on: editorElement strategy: completionStrategy.
	completionController install.
	^ editorElement
]

{ #category : #opening }
GtDocumenter class >> openPillar: aPillarFile [
	| aSpace |

	aSpace := BlSpace new.
	aSpace title: aPillarFile asFileReference basename.
	aSpace root addChild: (self editorForPillar: aPillarFile).
	aSpace show
]
