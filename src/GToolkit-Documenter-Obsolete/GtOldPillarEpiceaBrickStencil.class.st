Class {
	#name : #GtOldPillarEpiceaBrickStencil,
	#superclass : #GtOldPillarBrickStencil,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #'api - instantiation' }
GtOldPillarEpiceaBrickStencil >> create [
	<return: #BlElement>
	| aTabGroup aDiffTab aResultTab aComposite aToolbar aResizerElement aFinalCodeElement |

	aComposite := self newCompositeElement.
	aComposite margin: (BlInsets top: 0 left: 20 bottom: 5 right: 20). 

	aToolbar := self newRightAlignedToolbarElement.
	aToolbar addChild: self newApplyChangesButtonElement.
	aToolbar addChild: self newBrowseGlobalChangesButtonElement.
	aComposite addChild: aToolbar.

	aDiffTab := BrTab new
		look: BrMaterialTabLabelledLook;
		label: 'Diff';
		stencil: [ self newDiffElement ].
	
	aResultTab := BrTab new
		look: BrMaterialTabLabelledLook;
		label: 'Code';
		stencil: [ aFinalCodeElement := self newFinalCodeElement constraintsDo: [ :c | c vertical matchParent ] ].
	
	aTabGroup := BrTabGroup new
		look: BrMaterialTabGroupLook;
		addTabs: { aResultTab . aDiffTab }.
	
	aComposite addChild: aTabGroup.
	
	aResizerElement := self newResizerBarElementOn: aComposite.
	aResizerElement
		when: BlDblClickEvent
		do: [ aFinalCodeElement ifNotNil: [
			aFinalCodeElement constraintsDo: [ :c | c vertical fitContent ].
			aComposite constraintsDo: [ :c | c vertical fitContent ] ] ].
	aResizerElement
		when: BlResizerResizedEvent
		do: [ aFinalCodeElement ifNotNil: [
			aFinalCodeElement constraintsDo: [ :c | c vertical matchParent ] ] ].

	aComposite addChild: aResizerElement.
	
	
	self codeSnippet epiceaLog hasImpact
		ifFalse: [ aTabGroup removeTab: aDiffTab ].
	self codeSnippet
		subscribe: GtEpiceaImpactChangedAnnouncement
		do: [ :anAnnouncement | 
			self
				handleEpiceaChangeImpact: anAnnouncement
				withGroup: aTabGroup
				diffTab: aDiffTab ].
	^ aComposite
]

{ #category : #'accessing - parameters' }
GtOldPillarEpiceaBrickStencil >> diffRope [
	<return: #BrRopedText>
	| aBuilder aRopedText |
	aBuilder := PrettyTextDiffBuilder 
		from: self epiceaLog currentStateString 
		to: self epiceaLog newStateString.
	aRopedText := '' asRopedText.
	aBuilder
		patchSequenceDoIfMatch: [ :string | | initialPosition |
			initialPosition := aRopedText size max: 1.
			aRopedText insertString: '  ' at: aRopedText size.
			aRopedText insertString: string at: aRopedText size.
			aRopedText 
				attributes: { BrTextForegroundAttribute paint: Color black } 
				from: initialPosition to: aRopedText size.
			aRopedText insertString: String cr at: aRopedText size. ]
		ifInsert: [ :string | | initialPosition |
			initialPosition := aRopedText size max: 1.
			aRopedText insertString: '+ ' at: aRopedText size.
			aRopedText insertString: string at: aRopedText size.
			aRopedText 
				attributes: { BrTextForegroundAttribute paint: Color green muchDarker } 
				from: initialPosition to: aRopedText size.
			aRopedText insertString: String cr at: aRopedText size. ]
		ifRemove: [ :string | | initialPosition |
			initialPosition := aRopedText size max: 1.
			aRopedText insertString: '- ' at: aRopedText size.
			aRopedText insertString: string at: aRopedText size.
			aRopedText 
				attributes: { BrTextForegroundAttribute paint: Color red muchDarker } 
				from: initialPosition to: aRopedText size.
			aRopedText insertString: String cr at: aRopedText size. ].
	aRopedText isEmpty ifFalse: [ 
		aRopedText attributes: { BrFontGenericFamilyAttribute monospace } ].
	^ aRopedText
]

{ #category : #accessing }
GtOldPillarEpiceaBrickStencil >> epiceaLog [
	<return: #GtEpiceaLog>
	^ self codeSnippet epiceaLog
]

{ #category : #'accessing - parameters' }
GtOldPillarEpiceaBrickStencil >> finalCodeRope [
	<return: #BrRopedText>
	| aRopedText |
	aRopedText := self epiceaLog newStateString asRopedText.
	aRopedText isEmpty ifFalse: [ 
		aRopedText attributes: { BrFontGenericFamilyAttribute monospace } ].
	^ aRopedText
]

{ #category : #'announcement handling' }
GtOldPillarEpiceaBrickStencil >> handleEpiceaChangeImpact: anAnnouncement withGroup: aTabGroup diffTab: aDiffTab [

	anAnnouncement hasImpact
		ifTrue: [ (aTabGroup hasTab: aDiffTab)
			ifFalse: [ aTabGroup addTab: aDiffTab ] ]
		ifFalse: [ (aTabGroup hasTab: aDiffTab)
			ifTrue: [ aTabGroup removeTab: aDiffTab ] ]
]

{ #category : #'instance creation' }
GtOldPillarEpiceaBrickStencil >> newApplyChangesButtonElement [
	<return: #BlElement>
	| aButton aModel |
	aButton := self newSlimButtonElement.
	aModel := self newApplyChangesButtonModel.
	aButton viewModel: aModel.
	^ aButton
]

{ #category : #'instance creation' }
GtOldPillarEpiceaBrickStencil >> newApplyChangesButtonModel [
	| aLabel aModel |
	aLabel := self epiceaLog hasImpact ifTrue: [ 'Apply' ] ifFalse: [ 'Applied' ].
	aModel := BrButtonModel new
		label: aLabel;
		action: [ self epiceaLog applyCodeChanges ].
	self codeSnippet 
		subscribe: GtEpiceaImpactChangedAnnouncement 
		do: [ :anAnnouncement | | newValue |
			newValue := anAnnouncement hasImpact ifTrue: [ 'Apply' ] ifFalse: [ 'Applied' ].
			aModel label: newValue ].
	^ aModel
]

{ #category : #'instance creation' }
GtOldPillarEpiceaBrickStencil >> newBrowseGlobalChangesButtonElement [
	<return: #BlElement>
	| aButton aModel |
	aButton := self newSlimButtonElement.
	aModel := self newBrowseGlobalChangesButtonModel.
	aButton viewModel: aModel.
	^ aButton
]

{ #category : #'instance creation' }
GtOldPillarEpiceaBrickStencil >> newBrowseGlobalChangesButtonModel [
	^ BrButtonModel new
		label: 'Edit';
		action: [ :theModel | self epiceaLog displayGlobalChanges: theModel ]
]

{ #category : #'instance creation' }
GtOldPillarEpiceaBrickStencil >> newBrowseLogButtonElement [
	<return: #BlElement>
	| aButton aModel aLook |
	aButton := self newSlimButtonElement.
	aModel := self newBrowseLogButtonModel.
	aLook := self newButtonLabelLook.
	aButton look: aLook.
	aButton viewModel: aModel.
	^ aButton
]

{ #category : #'instance creation' }
GtOldPillarEpiceaBrickStencil >> newBrowseLogButtonModel [
	| aModel |
	aModel := BrButtonModel new
		label: 'Browse';
		action: [ self epiceaLog browseEvents ].
	^ aModel
]

{ #category : #'instance creation' }
GtOldPillarEpiceaBrickStencil >> newButtonLabelLook [
	^ BrMaterialToggleLabelledLook + GtPillarSlimButtonLook
]

{ #category : #'instance creation' }
GtOldPillarEpiceaBrickStencil >> newDiffElement [
	<return: #BrEditorElement>
	| diffElement |
	diffElement := self newEditorElementWithRopedText: self diffRope.
	diffElement background: (Color r: 0.95 g: 0.95 b: 0.95).
	self codeSnippet 
		subscribe: GtEpiceaImpactChangedAnnouncement 
		do: [ :anAnnouncement | 
			diffElement editor text: self diffRope ].
	^ diffElement
]

{ #category : #'instance creation' }
GtOldPillarEpiceaBrickStencil >> newFinalCodeElement [
	<return: #BrEditorElement>
	| editorElement |
	editorElement := self newEditorElementWithRopedText: self finalCodeRope.
	editorElement background: (Color r: 0.95 g: 0.95 b: 0.95).
"	styler := BrRBTextStyler new.
	editorElement editor styler: styler.
"	self codeSnippet 
		subscribe: GtEpiceaImpactChangedAnnouncement 
		do: [ :anAnnouncement | 
			editorElement editor text: self finalCodeRope ].
	^ editorElement
]
