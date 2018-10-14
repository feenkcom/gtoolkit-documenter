Class {
	#name : #GtPillarEpiceaBrickStencil,
	#superclass : #BrStencil,
	#traits : 'TGtPillarPreviewStencil',
	#classTraits : 'TGtPillarPreviewStencil classTrait',
	#instVars : [
		'documentPart'
	],
	#category : 'GToolkit-Documenter-Epicea'
}

{ #category : #'api - instantiation' }
GtPillarEpiceaBrickStencil >> create [
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
		when: BlDoubleClickEvent
		do: [ aFinalCodeElement ifNotNil: [
			aFinalCodeElement constraintsDo: [ :c | c vertical fitContent ].
			aComposite constraintsDo: [ :c | c vertical fitContent ] ] ].
	aResizerElement
		when: BlResizerResizedEvent
		do: [ aFinalCodeElement ifNotNil: [
			aFinalCodeElement constraintsDo: [ :c | c vertical matchParent ] ] ].

	aComposite addChild: aResizerElement.
	
	
	self epiceaLog hasImpact
		ifFalse: [ aTabGroup removeTab: aDiffTab ].
	self documentPart
		subscribe: GtEpiceaImpactChangedAnnouncement
		do: [ :anAnnouncement | 
			self
				handleEpiceaChangeImpact: anAnnouncement
				withGroup: aTabGroup
				diffTab: aDiffTab ].
	^ aComposite
]

{ #category : #'accessing - parameters' }
GtPillarEpiceaBrickStencil >> diffRope [
	<return: #BlRopedText>
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
			(aRopedText from: initialPosition to: aRopedText size)
				foreground: Color black.
			aRopedText insertString: String cr at: aRopedText size. ]
		ifInsert: [ :string | | initialPosition |
			initialPosition := aRopedText size max: 1.
			aRopedText insertString: '+ ' at: aRopedText size.
			aRopedText insertString: string at: aRopedText size.
			(aRopedText from: initialPosition to: aRopedText size)
				foreground: Color green muchDarker.
			aRopedText insertString: String cr at: aRopedText size. ]
		ifRemove: [ :string | | initialPosition |
			initialPosition := aRopedText size max: 1.
			aRopedText insertString: '- ' at: aRopedText size.
			aRopedText insertString: string at: aRopedText size.
			(aRopedText from: initialPosition to: aRopedText size)
				foreground: Color red muchDarker.
			aRopedText insertString: String cr at: aRopedText size. ].
	aRopedText isEmpty ifFalse: [ 
		aRopedText attributes: { BlFontGenericFamilyAttribute monospace } ].
	^ aRopedText
]

{ #category : #'event handling' }
GtPillarEpiceaBrickStencil >> displayGlobalChanges: aBlElement [
	"Trigger event to display ${class:GtEpiceaLog}$ in an inspector"
	aBlElement fireEvent: (GLMBlocObjectToSelect new toSelect: self epiceaLog).
	aBlElement fireEvent: (GtPhlowObjectToSpawn new object: self epiceaLog; sourceElement: aBlElement)
]

{ #category : #accessing }
GtPillarEpiceaBrickStencil >> documentPart [
	<return: #GtEpiceaChanges>
	self
		assert: [ documentPart notNil ] 
		description: [ 'Document part has to be initialized first' ].
	^ documentPart
]

{ #category : #accessing }
GtPillarEpiceaBrickStencil >> documentPart: aGtEpiceaChanges [
	self
		assert: [ aGtEpiceaChanges notNil ] 
		description: [ 'Document part has to be initialized first' ].
	documentPart := aGtEpiceaChanges
]

{ #category : #accessing }
GtPillarEpiceaBrickStencil >> epiceaLog [
	<return: #GtEpiceaLog>
	^ self documentPart epiceaLog
]

{ #category : #'accessing - parameters' }
GtPillarEpiceaBrickStencil >> finalCodeRope [
	<return: #BlRopedText>
	| aRopedText |
	aRopedText := self epiceaLog newStateString asRopedText.
	aRopedText isEmpty ifFalse: [ 
		aRopedText attributes: { BlFontGenericFamilyAttribute monospace } ].
	^ aRopedText
]

{ #category : #'announcement handling' }
GtPillarEpiceaBrickStencil >> handleEpiceaChangeImpact: anAnnouncement withGroup: aTabGroup diffTab: aDiffTab [

	anAnnouncement hasImpact
		ifTrue: [ (aTabGroup hasTab: aDiffTab)
			ifFalse: [ aTabGroup addTab: aDiffTab ] ]
		ifFalse: [ (aTabGroup hasTab: aDiffTab)
			ifTrue: [ aTabGroup removeTab: aDiffTab ] ]
]

{ #category : #'instance creation' }
GtPillarEpiceaBrickStencil >> newApplyChangesButtonElement [
	<return: #BrButton>
	| aButton |

	aButton := self newSlimButton.
	aButton label: (self epiceaLog hasImpact ifTrue: [ 'Apply' ] ifFalse: [ 'Applied' ]).
	aButton action: [ self epiceaLog applyCodeChanges ].

	self documentPart
		subscribe: GtEpiceaImpactChangedAnnouncement 
		do: [ :anAnnouncement |
			| newValue |
			newValue := anAnnouncement hasImpact ifTrue: [ 'Apply' ] ifFalse: [ 'Applied' ].
			aButton label: newValue ].

	^ aButton
]

{ #category : #'instance creation' }
GtPillarEpiceaBrickStencil >> newBrowseGlobalChangesButtonElement [
	<return: #BrButton>

	^ self newSlimButton
		label: 'Edit';
		action: [ :anElement :theModel | self displayGlobalChanges: anElement ]
]

{ #category : #'instance creation' }
GtPillarEpiceaBrickStencil >> newDiffElement [
	<return: #BrEditorElement>
	| diffElement |
	diffElement := self newEditorElementWithRopedText: self diffRope.
	diffElement background: (Color r: 0.95 g: 0.95 b: 0.95).
	self documentPart 
		subscribe: GtEpiceaImpactChangedAnnouncement 
		do: [ :anAnnouncement | 
			diffElement editor text: self diffRope ].
	^ diffElement
]

{ #category : #'instance creation' }
GtPillarEpiceaBrickStencil >> newEditorElementWithRopedText: aBrText [
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
GtPillarEpiceaBrickStencil >> newFinalCodeElement [
	<return: #BrEditorElement>
	| editorElement |
	editorElement := self newEditorElementWithRopedText: self finalCodeRope.
	editorElement background: (Color r: 0.95 g: 0.95 b: 0.95).
"	styler := BrRBTextStyler new.
	editorElement editor styler: styler.
"	self documentPart 
		subscribe: GtEpiceaImpactChangedAnnouncement 
		do: [ :anAnnouncement | 
			editorElement editor text: self finalCodeRope ].
	^ editorElement
]
