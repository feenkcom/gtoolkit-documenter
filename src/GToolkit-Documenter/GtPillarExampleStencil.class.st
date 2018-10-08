Class {
	#name : #GtPillarExampleStencil,
	#superclass : #BrStencil,
	#traits : 'TGtPillarPreviewStencil',
	#classTraits : 'TGtPillarPreviewStencil classTrait',
	#instVars : [
		'text',
		'editor',
		'documentPart'
	],
	#category : #'GToolkit-Documenter-Brick-Stencils'
}

{ #category : #'instance creation' }
GtPillarExampleStencil >> create [
	<return: #BlElement>
	"Return a preview element that is displayed in a document"
	| aChildrenElementBlock aComposite |
	
	aChildrenElementBlock := [ 
		self documentPart isMethodDefined 
			ifFalse: [ self newErrorMessageElement ]
			ifTrue: [ self newPreviewElementFromShowParameter ] ].
		
	aComposite := BlElement new look: GtPillarTransparentCompositeLook.
	aComposite addChild: aChildrenElementBlock value.

	self documentPart 
		subscribe: GtExampleClassUpdatedAnnouncement 
		do: [ aComposite removeChildren. aComposite addChild: aChildrenElementBlock value ] 
		for: aComposite.
	
	^ aComposite
]

{ #category : #accessing }
GtPillarExampleStencil >> documentPart [
	<return: #GtPillarDocumentPart>
	self
		assert: [ documentPart notNil ]
		description: [ 'Document part should be initialized first' ].
	^ documentPart
]

{ #category : #accessing }
GtPillarExampleStencil >> documentPart: aGtPillarExample [
	self
		assert: [ aGtPillarExample notNil ]
		description: [ 'Annotation has to be initialized' ].
	documentPart := aGtPillarExample
]

{ #category : #accessing }
GtPillarExampleStencil >> editor [
	<return: #BrEditorElement>
	self
		assert: [ editor notNil ]
		description: [ 'Editor should be initialized first' ].
	^ editor
]

{ #category : #accessing }
GtPillarExampleStencil >> editor: aBrEditorElement [
	self
		assert: [ aBrEditorElement notNil ]
		description: [ 'Editor has to be initialized' ].
	editor := aBrEditorElement
]

{ #category : #'instance creation' }
GtPillarExampleStencil >> errorMessageText [
	<return: #BlRopedText>

	self documentPart isMethodClassDefined ifFalse: [ 
		^ ('Example class (', self documentPart methodClassName , ') is not defined (yet).') asRopedText ].

	self documentPart isMethodDefined ifFalse: [ 
		^ ('Example method (', self documentPart methodName asString, ') is not defined (yet).') asRopedText ].

	^ ('Something wrong with ', self documentPart methodName) asRopedText
]

{ #category : #private }
GtPillarExampleStencil >> mayExpandResultPreviewIn: exampleElement [
	self documentPart doNotDisplaySourceCodeParameterValue ifTrue: [ ^ self ].
	self documentPart expandedPreviewParameterValue ifTrue: [ exampleElement showPreview ]
]

{ #category : #private }
GtPillarExampleStencil >> maySetHeightOfPreview: exampleElement [
	self documentPart isPreviewHeightDefined
		ifTrue: [ exampleElement previewHeight: self documentPart previewHeightParameterValue ]
]

{ #category : #'instance creation' }
GtPillarExampleStencil >> newEditorElementWithRopedText: aBrText [
	<return: #BrEditorElement>
	| anEditor anEditorElement |
	
	anEditor := BrTextEditor new.
	anEditor text: aBrText.

	anEditorElement := BrEditorElement new.
	anEditorElement editor: anEditor.
	anEditorElement look: GtPillarTextEditorLook new.
	
	^ anEditorElement
]

{ #category : #'instance creation' }
GtPillarExampleStencil >> newErrorMessageElement [
	<return: #BlElement>
	^ self newCompositeElement 
		addChild: (self newEditorElementWithRopedText: self errorMessageText)
]

{ #category : #'instance creation' }
GtPillarExampleStencil >> newPreviewElementFromShowParameter [
	| exampleElement |

	exampleElement := GtPillarExampleElement
		withCode: self documentPart doNotDisplaySourceCodeParameterValue not.
	
	self maySetHeightOfPreview: exampleElement.
	
	exampleElement
		margin: (BlInsets top: 0 left: 20 bottom: 0 right: 20);
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical fitContent ].
	exampleElement
		example: self documentPart exampleMethod gtExample
		showBlock: [ :returnValue | 
			| view |
			self flag: 'Maybe use GtPillarInspectorStencil instead of this code?'.
			view := GtPhlowView sequentialExplicit on: returnValue perform: self documentPart showParameterValue.
			view asElementDo: [ :element |
				element constraintsDo: [ :c | 
					c vertical matchParent.
					c horizontal matchParent ] ] ].
	self mayExpandResultPreviewIn: exampleElement.
	^ exampleElement
]

{ #category : #accessing }
GtPillarExampleStencil >> text [
	<return: #BlText>
	self
		assert: [ text notNil ]
		description: [ 'Text should be initialized first' ].
	^ text
]

{ #category : #accessing }
GtPillarExampleStencil >> text: aBrText [
	self
		assert: [ aBrText notNil ]
		description: [ 'Text has to be initialized' ].
	text := aBrText
]
