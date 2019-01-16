Class {
	#name : #GtHTMLWriter,
	#superclass : #PRHTMLWriter,
	#category : #'GToolkit-NewDocumenter'
}

{ #category : #'visiting-document' }
GtHTMLWriter >> visitCodeblock: aCodeBlock [
	| language code |
	canvas tag
		name: 'div';
		parameterAt: 'class' put: 'codeBlock';
		with: [ 
			language := PRSmalltalkScriptLanguage default.						
			canvas tag
				name: 'pre';
				with: [
					code := canvas tag
						name: 'code';
						yourself.
					language := PRSmalltalkScriptLanguage default.
					language isSyntaxHighlightingPossible
						ifTrue: [ code parameterAt: 'class' put: language printString ].
					code with: [ 
						canvas lines: aCodeBlock text.
					].
				].
			].
	canvas newLine
]
