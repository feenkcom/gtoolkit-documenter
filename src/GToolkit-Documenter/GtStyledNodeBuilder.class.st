Class {
	#name : #GtStyledNodeBuilder,
	#superclass : #Object,
	#traits : 'TGt2DocumentConstants + TBlDebug',
	#classTraits : 'TGt2DocumentConstants classTrait + TBlDebug classTrait',
	#instVars : [
		'document',
		'node',
		'text',
		'properties'
	],
	#category : #'GToolkit-Documenter-Styler Builder'
}

{ #category : #'accessing - properties' }
GtStyledNodeBuilder >> action: anAction [
	self properties action: anAction
]

{ #category : #'style - cursor' }
GtStyledNodeBuilder >> activateCursor [
	self nodeText attribute: (BrTextCursorAttribute new
		enterAction: self properties cursorEnterAction;
		leaveAction: self properties cursorLeaveAction)
]

{ #category : #asserting }
GtStyledNodeBuilder >> assertNode [
	self
		assert: [ self node isNotNil ] 
		description: [ 'Pillar AST node must be initialized' ]
]

{ #category : #'style - hide' }
GtStyledNodeBuilder >> autoHideNode [
	"Hide node only if a cursor is far away"
	self 
		if: self isCursorClose
		do: [ self revealNode ]
		otherwise: [ self hideNode ].
	self installDisplayMarkupsHandler
]

{ #category : #'accessing - properties' }
GtStyledNodeBuilder >> cursorEnterAction: anAction [
	self properties cursorEnterAction: anAction
]

{ #category : #'accessing - properties' }
GtStyledNodeBuilder >> cursorLeaveAction: anAction [
	self properties cursorLeaveAction: anAction
]

{ #category : #accessing }
GtStyledNodeBuilder >> document [
	<return: #GtDocument>
	self
		assert: [ document isNotNil ] 
		description: [ 'Document instance must be itialized before using it' ].
	^ document
]

{ #category : #accessing }
GtStyledNodeBuilder >> document: aGtDocument [
	self
		assert: [ document isNil ] 
		description: [ 'Document instance must be itialized only once' ].
	self
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document instance must be non-nil' ].
	document := aGtDocument
]

{ #category : #'style - hide' }
GtStyledNodeBuilder >> hideNode [
	"Hide node in the text"
	self nodeText attribute: GtHideAttribute uniqueInstance.
]

{ #category : #'style - condition' }
GtStyledNodeBuilder >> if: aConditionBlock do: aStylingBlock [
	"Execute the styling block only if the condition block is true"
	aConditionBlock value ifTrue: [ aStylingBlock cull: self ].
]

{ #category : #'style - condition' }
GtStyledNodeBuilder >> if: aConditionBlock do: aStylingBlock otherwise: aSecondStylingBlock [
	"Execute the styling block only if the condition block is true"
	aConditionBlock value 
		ifTrue: [ aStylingBlock cull: self ]
		ifFalse: [ aSecondStylingBlock cull: self ]
]

{ #category : #initialization }
GtStyledNodeBuilder >> initialize [
	super initialize.
	document := nil.
	node := nil.
	properties := GtStyledNodeBuilderProperties new.
	text := nil.
]

{ #category : #'style - hide' }
GtStyledNodeBuilder >> installDisplayMarkupsHandler [
	"Display markups if a cursor is close to the node"
	self cursorEnterAction: [ :aTextEditor |
		self updateText: aTextEditor text.
		self revealNode.
		aTextEditor invalidate: self start to: self stop.
		aTextEditor update: self start to: self stop ].
	self cursorLeaveAction: [ :aTextEditor |
		self updateText: aTextEditor text.
		self hideNode.
		aTextEditor invalidate: self start to: self stop.
		aTextEditor update: self start to: self stop ].
	self activateCursor
]

{ #category : #'style - cursor' }
GtStyledNodeBuilder >> isCursorClose [
	"Return true if a cursor is close to the node"

	<return: #Boolean>
	^ self document editor cursors
		detect: [ :eachCursor | eachCursor position between: self start and: self stop ]
		ifFound: [ :aCursor | true ]
		ifNone: [ false ]
]

{ #category : #'accessing - properties' }
GtStyledNodeBuilder >> name: aValuable [
	self properties name: aValuable
]

{ #category : #accessing }
GtStyledNodeBuilder >> node [
	<return: #PRDocumentItem>
	self
		assert: [ node isNotNil ]
		description: [ 'Pillar AST node must be initialized' ].
	^ node
]

{ #category : #accessing }
GtStyledNodeBuilder >> node: aPRDocumentItem [
	self
		assert: [ node isNil ] 
		description: [ 'Pillar AST node must be itialized only once' ].
	self
		assert: [ aPRDocumentItem isNotNil ] 
		description: [ 'Pillar AST node must be non-nil' ].
	node := aPRDocumentItem
]

{ #category : #'accessing - node' }
GtStyledNodeBuilder >> nodeText [
	^ self text from: self start to: self stop
]

{ #category : #accessing }
GtStyledNodeBuilder >> properties [
	<return: #GtStyledNodeBuilderProperties>
	^ properties
]

{ #category : #'style - hide' }
GtStyledNodeBuilder >> revealNode [
	"Reveal node in the text that was hidden"
	self nodeText clearAttributes: [ :eachAttribute | 
		eachAttribute = GtHideAttribute uniqueInstance ]
]

{ #category : #'accessing - properties' }
GtStyledNodeBuilder >> spawnObject: anAction [
	^ self action: [ :aButton | aButton phlow spawnObject: anAction value ]
]

{ #category : #'accessing - node' }
GtStyledNodeBuilder >> start [
	"Return starting position of a node"
	<return: #Integer>
	^ self node start
]

{ #category : #'accessing - node' }
GtStyledNodeBuilder >> stop [
	"Return ending position of a node"
	<return: #Integer>
	^ self node stop
]

{ #category : #'style - button' }
GtStyledNodeBuilder >> styleLinkButton [
	"Add button to a node"
	self nodeText 
		attribute: (GtButtonAttribute new
			beAppend;
			stencil: [ BrButton new 
				look: BrGlamorousLinkButtonWithLabelLook;
				beSmall;
				label: self properties name value;
				action: self properties action ])
]

{ #category : #accessing }
GtStyledNodeBuilder >> text [
	self
		assert: [ text isNotNil ] 
		description: [ 'Document text must be itialized before using it' ].
	^ text
]

{ #category : #accessing }
GtStyledNodeBuilder >> text: aBlRope [
	self
		assert: [ text isNil ] 
		description: [ 'Document text must be itialized only once' ].
	self
		assert: [ aBlRope isNotNil ] 
		description: [ 'Document text must be non-nil' ].
	text := aBlRope
]

{ #category : #accessing }
GtStyledNodeBuilder >> updateText: aBlRope [
	self
		assert: [ text isNotNil ] 
		description: [ 'Document text must be itialized before to be able to update it' ].
	self
		assert: [ aBlRope isNotNil ] 
		description: [ 'Document text must be non-nil' ].
	text := aBlRope
]
