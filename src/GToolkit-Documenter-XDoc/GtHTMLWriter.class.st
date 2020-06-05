Class {
	#name : #GtHTMLWriter,
	#superclass : #PRHTMLWriter,
	#category : #'GToolkit-Documenter-XDoc-Writer'
}

{ #category : #'visiting-document' }
GtHTMLWriter >> visitCodeblock: aCodeBlock [
	| language code |
	canvas tag
		name: 'div';
		parameterAt: 'class' put: 'codeBlock';
		with: [ 
			language := aCodeBlock language.						
			canvas tag
				name: 'pre';
				with: [
					code := canvas tag
						name: 'code';
						yourself.
					language isSyntaxHighlightingPossible
						ifTrue: [ code parameterAt: 'class' put: language printString ].
					code with: [ 
						canvas lines: aCodeBlock text.
					].
				].
			].
	canvas newLine
]

{ #category : #'visiting-document' }
GtHTMLWriter >> visitFigure: aFigure [
	(aFigure hasLabel not and: [ aFigure hasCaption not ])
		ifTrue: [ 
			self exportImgFor: aFigure.
			^ self ].
	aFigure label ifNotNil: [ :label | self createAnchorWith: label ].
	canvas newLine.
	canvas tag
		name: 'figure';
		parameterAt: 'class' put: aFigure alignmentParameterValue;
		with:
			[ 
			canvas newLine.
			canvas nextPut: Character tab.
			self exportImgFor: aFigure.
			canvas newLine.
			canvas nextPut: Character tab.
			canvas tag
				name: 'figcaption';
				with:
						[ 
					aFigure label ifNotNil: [ self writeCounterForFigure: aFigure ].
					self visitReference: aFigure ].
			canvas newLine ].
]
