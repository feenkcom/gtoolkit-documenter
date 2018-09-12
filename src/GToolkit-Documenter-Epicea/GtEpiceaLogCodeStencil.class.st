Class {
	#name : #GtEpiceaLogCodeStencil,
	#superclass : #BrStencil,
	#instVars : [
		'epiceaLog'
	],
	#category : #'GToolkit-Documenter-Epicea'
}

{ #category : #private }
GtEpiceaLogCodeStencil >> addElementsToContainer: anElement [
	self entries do: [ :eachEntry | 
		anElement addChild: (self elementFor: eachEntry) ].
]

{ #category : #'api - instantiation' }
GtEpiceaLogCodeStencil >> create [
	<return: #BlElement>

	| aContainer | 
	aContainer := BlElement new
		layout: BlLinearLayout vertical;
		padding: (BlInsets all: 10);
		constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical fitContent ].
	self epiceaLog announcer when: EpEntryAdded do: [ :anAnnouncement | 
		aContainer removeChildren. ].
	
	self entries do: [ :eachEntry | 
		aContainer addChild: (self elementFor: eachEntry) ].
	^ aContainer
]

{ #category : #private }
GtEpiceaLogCodeStencil >> elementFor: anOmEntry [
	| aStateString anEditor aStyler |
	aStateString := (EpEntryItem new entry: anOmEntry) newStateString.
	aStyler := GtEpiceaStyler new.
	aStyler workspace: GtSatisfyingHighlightingBindingStrategy new.
	anOmEntry content isEpMethodChange ifTrue: [  
		anOmEntry content behaviorAffectedName asClassIfPresent: [ :aBehavior |
			 aStyler classOrMetaClass: aBehavior ] ].
	anEditor := BrEditorElement new.
	anEditor editor: BrTextEditor new.
	anEditor editor text: aStateString asRopedText.
	anEditor editor styler: aStyler.
	anEditor constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent.
		c padding: (BlInsets all: 10) ].
	^ anEditor
	

]

{ #category : #accessing }
GtEpiceaLogCodeStencil >> entries [
	<return: #Collection of: #OmEntry>
	^ self store entries
]

{ #category : #accessing }
GtEpiceaLogCodeStencil >> epiceaLog [
	<return: #GtEpiceaLog>
	^ epiceaLog
]

{ #category : #accessing }
GtEpiceaLogCodeStencil >> epiceaLog: aGtEpiceaLog [
	self 
		assert: [ aGtEpiceaLog notNil ] 
		description: [ 'Epicea log must be non-nil' ].
	epiceaLog := aGtEpiceaLog
]

{ #category : #accessing }
GtEpiceaLogCodeStencil >> log [
	<return: #EpLog>
	^ self epiceaLog log
]

{ #category : #accessing }
GtEpiceaLogCodeStencil >> store [
	<return: #OmStore>
	^ self log store
]
