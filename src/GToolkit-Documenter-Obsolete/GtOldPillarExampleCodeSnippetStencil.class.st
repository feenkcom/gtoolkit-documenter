Class {
	#name : #GtOldPillarExampleCodeSnippetStencil,
	#superclass : #GtOldPillarBrickStencil,
	#instVars : [
		'withCode',
		'gtExample'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #'instance creation' }
GtOldPillarExampleCodeSnippetStencil >> create [
	<return: #BlElement>
	"Return a preview element that is displayed in a document"
	| aChildrenElementBlock aComposite |
	
	aChildrenElementBlock := [ 
		self codeSnippet isMethodDefined 
			ifFalse: [ self newErrorMessageElement ]
			ifTrue: [ self codeSnippet shouldDisplayResult
				ifTrue: [ self newPreviewElementFromShowParameter ]
				ifFalse: [ self newPreviewEditorElement ] ] ].
		
	aComposite := self newTransparentCompositeElement.
	aComposite addChild: aChildrenElementBlock value.

	self codeSnippet 
		subscribe: GtExampleClassUpdatedAnnouncement 
		do: [ aComposite removeChildren. aComposite addChild: aChildrenElementBlock value ] 
		for: aComposite.
	
	^ aComposite
]

{ #category : #'instance creation' }
GtOldPillarExampleCodeSnippetStencil >> errorMessageText [
	<return: #BrRopedText>

	self codeSnippet isMethodClassDefined ifFalse: [ 
		^ ('Example class (', self codeSnippet methodClassName , ') is not defined (yet).') asRopedText ].

	self codeSnippet isMethodDefined ifFalse: [ 
		^ ('Example method (', self codeSnippet methodSelectorName , ') is not defined (yet).') asRopedText ].

	^ ('Something wrong with ', self codeSnippet methodName) asRopedText
]

{ #category : #private }
GtOldPillarExampleCodeSnippetStencil >> mayExpandResultPreviewIn: exampleElement [
	self codeSnippet shouldExpandPreview ifTrue: [ exampleElement showPreview ]
]

{ #category : #private }
GtOldPillarExampleCodeSnippetStencil >> maySetHeightOfPreview: exampleElement [
	self codeSnippet isPreviewHeightDefined
		ifTrue: [ exampleElement previewHeight: self codeSnippet previewHeight ]
]

{ #category : #'instance creation' }
GtOldPillarExampleCodeSnippetStencil >> newErrorMessageElement [
	<return: #BlElement>
	^ self newCompositeElement 
		addChild: (self newEditorElementWithRopedText: self errorMessageText)
]

{ #category : #'instance creation' }
GtOldPillarExampleCodeSnippetStencil >> newPreviewEditorElement [
	^ (GtExamplesStyler
		editorElementOnSourceCode: self codeSnippet methodSourceCode
		inClass: self codeSnippet methodClass) 
			margin: (BlInsets top: 5 left: 20 bottom: 0 right: 20)
]

{ #category : #'instance creation' }
GtOldPillarExampleCodeSnippetStencil >> newPreviewElementFromShowParameter [
	| exampleElement |
	
	exampleElement := GtPillarExampleElement
		withCode: self codeSnippet shouldDisplayCode.
	
	self maySetHeightOfPreview: exampleElement.
	
	exampleElement
		margin: (BlInsets top: 0 left: 20 bottom: 0 right: 20);
		constraintsDo: [ :c | 
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical fitContent ].
	exampleElement
		example: self codeSnippet exampleMethod gtExample
		showBlock: [ :returnValue | 
			| view |
			view := GtPhlowExplicitView new.
			returnValue perform: self codeSnippet showMessageName withArguments: {view}.
			view asElementDo: [ :element |
				element constraintsDo: [ :c | 
					c vertical matchParent.
					c horizontal matchParent ] ] ].
	self mayExpandResultPreviewIn: exampleElement.
	^ exampleElement
]
