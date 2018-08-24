Class {
	#name : #GtOldDocumenterExamplesUtility,
	#superclass : #Object,
	#traits : 'GtAssertingTrait',
	#classTraits : 'GtAssertingTrait classTrait',
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #'utility - accessing' }
GtOldDocumenterExamplesUtility class >> codeSnippetsFromEditor: aBrTextEditor [ 
	<return: #Array of: #GtOldCodeSnippetResult>
	| outs |
	outs := self outsFromEditor: aBrTextEditor.
	^ Array new: outs size streamContents: [ :aStream | 
		1 to: outs size do: [ :anIndex | | aSnippet |
			aSnippet := outs codeSnippetAt: anIndex.
			aStream nextPut: aSnippet.
			self assert: aSnippet index equals: anIndex ] ]
]

{ #category : #'utility - system environment' }
GtOldDocumenterExamplesUtility class >> createClassNamed: aClassNameString during: aBlockClosure [ 
	"Create a class in a temporary package and execute a block"
	| theClass |
	self
		assert: [ aClassNameString isSymbol ] 
		description: [ 'Class name should be a symbol' ].
	self
		assert: [ aClassNameString size > 1 ] 
		description: [ 'Class name should have at least one character' ].
	self 
		assert: [ (self environment includesKey: aClassNameString) not ]
		description: [ 'Class name should not exists' ].
	self
		assert: [ aBlockClosure notNil ] 
		description: [ 'Valuable object (block closure) should be initialized' ].
	theClass := Object 
		subclass: aClassNameString 
		instanceVariableNames: ''
		classVariableNames: ''
		package: 'GToolkit-DocumenterTemporaryPackage'.
	[ aBlockClosure cull: theClass cull: aClassNameString.
	] ensure: [ theClass ifNotNil: [ theClass removeFromSystem ] ].
]

{ #category : #'utility - accessing' }
GtOldDocumenterExamplesUtility class >> documentFromPillarElement: aGtPillarEditorElement [ 
	<return: #GtDocument>
	| aDocument |
	aDocument := aGtPillarEditorElement document.
	self assert: aDocument notNil.
	self assert: aDocument outs notNil.
	^ aDocument
]

{ #category : #'utility - accessing' }
GtOldDocumenterExamplesUtility class >> editorElementFromPillarElement: pillarElement [
	<return: #BrEditorElement>
	^ pillarElement contentElement
]

{ #category : #'utility - accessing' }
GtOldDocumenterExamplesUtility class >> editorFromPillarElement: pillarElement [
	<return: #BrEditorElement>
	^ (self editorElementFromPillarElement: pillarElement) editor
]

{ #category : #'utility - accessing' }
GtOldDocumenterExamplesUtility class >> outsFromEditor: aBrTextEditor [ 
	^ aBrTextEditor styler workspace outs
]

{ #category : #'utility - accessing' }
GtOldDocumenterExamplesUtility class >> pillarElementForPillarFileReference: aFileReference [
	<return: #GtPillarEditorElement>
	| pillarElement document editor |
	pillarElement := GtOldDocumenter editorForPillar: aFileReference.
	self assert: pillarElement notNil.
	document := pillarElement document.
	editor := self editorElementFromPillarElement: pillarElement.
	self assert: document notNil.
	self assert: editor notNil.
	self assert: document outs notNil.
	^ pillarElement
]
