Class {
	#name : #GtPillarExampleWithCodeElement,
	#superclass : #GtPillarExampleElement,
	#instVars : [
		'editorElement',
		'arrowElement'
	],
	#category : 'GToolkit-Documenter-Brick'
}

{ #category : #initialization }
GtPillarExampleWithCodeElement >> initializeElements [
	"Initalize elements and add them as children.
	Note: Must be done only after attaching a GT-Example"
	
	super initializeElements.
	
	self
		assert: [ editorElement isNil ]
		description: [ 'Editor element must not be initialized' ].
	self
		assert: [ arrowElement isNil ]
		description: [ 'Arrow element must not be initialized' ].

	editorElement := self newEditorElement: self example.
	editorElement look: GtPillarExpandedPreviewLook.

	arrowElement := self newArrowElement.
	arrowElement constraintsDo: [ :c |
		"Let's put arrow in the middle of its cell"
		c linear horizontal alignCenter.
		c linear vertical alignCenter ].

	"we don't add previewElement by default"
	self addChildren: { editorElement . arrowElement }.
]

{ #category : #initialization }
GtPillarExampleWithCodeElement >> initializeListeners [
	"Initalize elements listeners such as arrow callback to show / hide preview.
	Note: Elements must be initalized before listeners!"
	
	self
		assert: [ arrowElement isNotNil ]
		description: [ 'Arrow element must exist' ].

	arrowElement
		addEventHandlerOn: BlClickEvent
		do: [ :anEvent | self isPreviewShown
			ifTrue: [ self hidePreview ]
			ifFalse: [ self showPreview: previewShowBlock ] ]
]

{ #category : #'instance creation' }
GtPillarExampleWithCodeElement >> newEditorElement: aGTExample [
	"Instantiate a new editor for a given GT-Example"
	<return: #BrEditorElement>
	
	^ GtExamplesStyler 
		editorElementOnSourceCode: aGTExample sourceCode
		inClass: aGTExample methodClass
]
