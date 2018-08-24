Class {
	#name : #GtOldDocumenterCodeSnippetResultPreviewStencilBuilder,
	#superclass : #GtOldPillarBrickStencilBuilder,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #'api - instantiation' }
GtOldDocumenterCodeSnippetResultPreviewStencilBuilder >> buildDefault [
	| anOutputText |
	
	anOutputText := ('(outs at: ' , self codeSnippet index asString , ')') asRopedText.
	anOutputText monospace.
	anOutputText foreground: (self codeSnippet isException
		ifTrue: [ Color red ]
		ifFalse: [ Color gray ]).

	^ GtPillarResultPreviewStencil new
		result: self codeSnippet value;
		outputInformation: anOutputText
]
