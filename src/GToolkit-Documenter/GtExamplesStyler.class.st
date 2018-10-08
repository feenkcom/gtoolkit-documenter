Class {
	#name : #GtExamplesStyler,
	#superclass : #BrRBTextStyler,
	#category : #'GToolkit-Documenter-Pillar'
}

{ #category : #factory }
GtExamplesStyler class >> editorElementOnSourceCode: aString inClass: aClass [
	| styler editor editorElement text |
	
	text := aString asRopedText.
	styler := self new.
	styler classOrMetaClass: aClass.
	text attributes: { BrFontGenericFamilyAttribute monospace beNotOverwritableByStyler . (BrFontSizeAttribute new size: 14) beNotOverwritableByStyler}.
	editor := BrTextEditor new.
	editor styler: styler.
	editor text: text.
	
	editorElement := BrEditorElement new.
	editorElement editor: editor.
	
	editorElement
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical fitContent ];
		background: Color white";
		border: (BlBorder paint: Color veryLightGray width: 1)".
	^ editorElement
]

{ #category : #private }
GtExamplesStyler >> extraStyle: aText ast: ast [
	| selfSendsExamples |

	selfSendsExamples := ast allChildren select: [ :each | 
		each isMessage and: [ 
			each isSelfSend and: [ 
				each isUnary and: [ 
					(ast methodNode methodClass canPerform: each selector) and: [ 
						(ast methodNode methodClass lookupSelector: each selector) isGTExampleMethod ] ] ] ] ].
	selfSendsExamples do: [ :each | 
		aText 
			attributes: { 
				BrTextExpandButtonAttribute new attributesCreatingBlock: [ 
					BrTextAdornmentDynamicAttribute new beAppend; stencil: [	 
						| editorElement |
						editorElement := self class 
							editorElementOnSourceCode: (ast methodNode methodClass lookupSelector: each selector) sourceCode
							inClass: ast methodNode methodClass.
						editorElement border: (BlBorder paint: Color veryLightGray width: 1).
						editorElement margin: (BlInsets top: 0 right: 10 bottom: 10 left: 10) ]] } 
			from: each stop
			to: each stop ]
]
