instance creation
create
	<return: #BlElement>
	"Return a preview element that is displayed in a document"
	| aChildrenElementBlock aComposite |
	
	aChildrenElementBlock := [ 
		self documentPart isMethodDefined 
			ifFalse: [ self newErrorMessageElement ]
			ifTrue: [ self documentPart shouldDisplayResult
				ifTrue: [ self newPreviewElementFromShowParameter ]
				ifFalse: [ self newPreviewEditorElement ] ] ].
		
	aComposite := BlElement new look: GtPillarTransparentCompositeLook.
	aComposite addChild: aChildrenElementBlock value.

	self documentPart 
		subscribe: GtExampleClassUpdatedAnnouncement 
		do: [ aComposite removeChildren. aComposite addChild: aChildrenElementBlock value ] 
		for: aComposite.
	
	^ aComposite