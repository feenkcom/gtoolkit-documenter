Class {
	#name : #GtOldDocumenterExampleCodeSnippetStencilBuilder,
	#superclass : #GtOldPillarBrickStencilBuilder,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #'api - instantiation' }
GtOldDocumenterExampleCodeSnippetStencilBuilder >> buildDefault [
	^ GtOldPillarExampleCodeSnippetStencil new
		text: self text;
		editor: self editor;
		codeSnippet: self codeSnippet
]
