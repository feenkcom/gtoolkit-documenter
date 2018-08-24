Class {
	#name : #GtPillarDocumenterHighlighterExamples,
	#superclass : #Object,
	#category : 'GToolkit-Documenter-Examples'
}

{ #category : #'highlighted text' }
GtPillarDocumenterHighlighterExamples >> annotatedParagraph [
	<gtExample>
	| aText |
	aText := '@@todo annotated paragraph' asRopedText.
	GtPillarDocumenterHighlighter highlight: aText.
	self assert: aText rope attributes size equals: 1.
	^ aText
]

{ #category : #'highlighted text' }
GtPillarDocumenterHighlighterExamples >> exampleAnnotation [
	<gtExample>
	| aText |
	aText := 'bla ${example:GtPillarDocumenterHighlighterExamples>>#exampleAnnotation}$ dsa lkfjalksdjalksdj alksdj alksdj alskdj alkd jalksdj alkdj alksdj aslkd j
	
	asdasdad' asRopedText.
	GtPillarDocumenterHighlighter highlight: aText.
	^ aText
]

{ #category : #'highlighted text' }
GtPillarDocumenterHighlighterExamples >> executableScriptAnnotation [
	<gtExample>
	| aText |
	aText := '[[[
aResult ifNil: [ aResult := 2 ].
aResult := aResult * aResult.
]]]' asRopedText.
	GtPillarDocumenterHighlighter highlight: aText.
	^ aText
]

{ #category : #'highlighted text' }
GtPillarDocumenterHighlighterExamples >> executableScriptAnnotation2 [
	<gtExample>
	| aText |
	aText := '
adslfkj daslfkj alsdfkj 
	
[[[
aResult ifNil: [ aResult := 2 ].
aResult := aResult * aResult.
]]]

ldsfjlkasdjf alsdfjlk asldfj' asRopedText.
	^ GtDocumenter editorForText: aText.
]

{ #category : #'highlighted text' }
GtPillarDocumenterHighlighterExamples >> executableScriptAnnotation3 [
	<gtExample>
	| aText |
	aText := '
[[[
aResult ifNil: [ aResult := 2 ].
aResult := aResult * aResult.
]]]
' asRopedText.
	^ GtDocumenter editorForText: aText.
]

{ #category : #'highlighted text' }
GtPillarDocumenterHighlighterExamples >> header [
	<gtExample>
	| aText |
	aText := '! Hello' asRopedText.
	GtPillarDocumenterHighlighter highlight: aText.
	self assert: aText rope attributes size equals: 1.
	^ aText
]

{ #category : #'highlighted text' }
GtPillarDocumenterHighlighterExamples >> monospace [
	<gtExample>
	| aText |
	aText := '==monospace==' asRopedText.
	GtPillarDocumenterHighlighter highlight: aText.
	self assert: aText rope attributes size equals: 2.
	^ aText
]
