instance creation
create
	<return: #BlElement>
	"Return a preview element that is displayed in a document"
	| aChildrenElementBlock aComposite |
	
	aChildrenElementBlock := [ 
		self annotation isMethodDefined 
			ifFalse: [ self newErrorMessageElement ]
			ifTrue: [ self annotation shouldDisplayResult
				ifTrue: [ self newPreviewElementFromShowParameter ]
				ifFalse: [ self newPreviewEditorElement ] ] ].
		
	aComposite := BlElement new look: GtPillarTransparentCompositeLook new.
	aComposite addChild: aChildrenElementBlock value.

	"self annotation 
		subscribe: GtExampleClassUpdatedAnnouncement 
		do: [ aComposite removeChildren. aComposite addChild: aChildrenElementBlock value ] 
		for: aComposite."
	
	^ aComposite