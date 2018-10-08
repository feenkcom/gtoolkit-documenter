Class {
	#name : #GtDocumenterEmojiExamples,
	#superclass : #Object,
	#category : #'GToolkit-Documenter-Examples'
}

{ #category : #emojis }
GtDocumenterEmojiExamples >> documenterWithEmojis [
	<gtExample>
	^ GtDocumenter editorForText: '!Can Bloc deal with 😎?

[[[
''We should investigate 😉''
]]]
'
]
