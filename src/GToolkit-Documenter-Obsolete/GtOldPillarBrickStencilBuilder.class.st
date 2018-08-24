Class {
	#name : #GtOldPillarBrickStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'text',
		'editor',
		'codeSnippet'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #'api - accessing' }
GtOldPillarBrickStencilBuilder >> codeSnippet [
	^ codeSnippet
]

{ #category : #'api - accessing' }
GtOldPillarBrickStencilBuilder >> codeSnippet: anObject [
	codeSnippet := anObject
]

{ #category : #'api - accessing' }
GtOldPillarBrickStencilBuilder >> editor [
	<return: #BrEditorElement>

	^ editor
]

{ #category : #'api - accessing' }
GtOldPillarBrickStencilBuilder >> editor: aBrEditorElement [
	editor := aBrEditorElement
]

{ #category : #'api - instantiation' }
GtOldPillarBrickStencilBuilder >> paramsOn: aStencilExecutor [

	aStencilExecutor
		push: self codeSnippet;
		push: self editor;
		push: self text
]

{ #category : #'api - accessing' }
GtOldPillarBrickStencilBuilder >> text [
	^ text
]

{ #category : #'api - accessing' }
GtOldPillarBrickStencilBuilder >> text: anObject [
	text := anObject
]
