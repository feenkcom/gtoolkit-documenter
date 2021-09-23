Class {
	#name : 'GtStyledNodeBuilder',
	#superclass : 'Object',
	#traits : 'TGtDocumentConstants + TBlDebug',
	#classTraits : 'TGtDocumentConstants classTrait + TBlDebug classTrait',
	#instVars : [
		'document',
		'node',
		'text',
		'properties'
	],
	#category : 'GToolkit-Documenter-Styler Builder'
}

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> action: anAction [
	self properties action: anAction
]

{ #category : 'style - cursor' }
GtStyledNodeBuilder >> activateCursor [
	self activateCursorFrom: self start to: self stop.
]

{ #category : 'style - cursor' }
GtStyledNodeBuilder >> activateCursorFrom: aStartPosition to: aStopPosition [
	| anInitialPosition aFinalPosition |

	anInitialPosition := self possibleMinCursorPosition: aStartPosition.
	aFinalPosition := self possibleMaxCursorPosition: aStopPosition.

	(self text from: anInitialPosition to: aFinalPosition) 
		attribute: (BrTextCursorAttribute new
			enterAction: self properties cursorEnterAction;
			leaveAction: self properties cursorLeaveAction)
]

{ #category : 'asserting' }
GtStyledNodeBuilder >> assertNode [
	self
		assert: [ self node isNotNil ] 
		description: [ 'Pillar AST node must be initialized' ]
]

{ #category : 'style - hide' }
GtStyledNodeBuilder >> autoHideNode [
	"Hide node only if a cursor is far away"
	self 
		if: self isCursorClose
		do: [ self revealNode ]
		otherwise: [ self hideNode ].
	self installDisplayMarkupsHandler
]

{ #category : 'style - hide' }
GtStyledNodeBuilder >> autoHideTextFrom: aStartPosition to: aStopPosition [
	"Hide a text only if a cursor is far away"
	self 
		if: (self isCursorCloseTo: aStartPosition and: aStopPosition)
		do: [ self revealTextFrom: aStartPosition to: aStopPosition ]
		otherwise: [ self hideTextFrom: aStartPosition to: aStopPosition ].
	self installDisplayMarkupsHandlerFrom: aStartPosition to: aStopPosition
]

{ #category : 'style - button' }
GtStyledNodeBuilder >> buttonStencil: aStencil [
	"Add button to a node"
	| anAttribute |
	anAttribute := GtButtonAttribute new
		beAppend;
		stencil: aStencil.
	self nodeText attribute: anAttribute.
	self properties shouldClearIt ifTrue: [ 
		self clearAttribute: anAttribute from: self start to: self stop ].
]

{ #category : 'style - clear' }
GtStyledNodeBuilder >> clearAction: aValuable [
	self node addClearAction: aValuable
]

{ #category : 'style - clear' }
GtStyledNodeBuilder >> clearAttribute: anAttribute from: aStartIndex to: aStopIndex [
	"Clear attribute that was added dynamicly while hiding/revealing markups"
	self clearAction: [ :aStyler | 
		aStyler text 
			clearAttributes: aStartIndex 
			to: aStopIndex 
			if: [ :eachAttribute | eachAttribute = anAttribute ] ]
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> clearIt [
	"Clear what every is created, e.g, text attributes, by this builder"
	self properties clearIt.
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> cursorEnterAction: anAction [
	self properties cursorEnterAction: anAction
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> cursorLeaveAction: anAction [
	self properties cursorLeaveAction: anAction
]

{ #category : 'accessing' }
GtStyledNodeBuilder >> document [
	<return: #GtDocumenter>
	self
		assert: [ document isNotNil ] 
		description: [ 'Documenter instance must be initialized before using it' ].
	^ document
]

{ #category : 'accessing' }
GtStyledNodeBuilder >> document: aGtDocument [
	self
		assert: [ document isNil ] 
		description: [ 'Document instance must be itialized only once' ].
	self
		assert: [ aGtDocument isNotNil ] 
		description: [ 'Document instance must be non-nil' ].
	document := aGtDocument
]

{ #category : 'style - button' }
GtStyledNodeBuilder >> explanation [
	"Add button to a node"
	self nodeText 
		appendingAdornment: [ :aTBrTextEditorTextualPiece :anEditorElement | 
			| aContainer aTextPieceElement aRenderedText |
			aRenderedText := self properties name value asString asRopedText.
			aContainer := BlElement new
				clipChildren: false;
				layout: BlLinearLayout vertical;
				background: Color veryLightGray;
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent ].
			aContainer explainer isExplanation: true; model: self properties name value.
			aTextPieceElement := (BrTextElementWithCursors new
				editorMeasurement;
				segmentPiece: (BrTextEditorLineSegmentPiece new initializeWith: aRenderedText from: 0 to: aRenderedText size delimiter: 0)).
			aContainer addChildren: { aTextPieceElement } ]
		
		" (GtButtonAttribute new
			beAppend;
			stencil: [ BrButton new 
				look: BrGlamorousLinkButtonWithLabelLook;
				beSmall;
				margin: (BlInsets top: -1);
				label: self properties name value;
				action: self properties action ])"
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> hide: aStartIndex to: aStopIndex [
	self hideInterval: (aStartIndex to: aStopIndex)
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> hideInterval: anInterval [
	"Hide given interval of a node text"
	self properties hideInterval: anInterval
]

{ #category : 'style - hide' }
GtStyledNodeBuilder >> hideNode [
	"Hide node in the text"
	self hideTextFrom: self start to: self stop
]

{ #category : 'style - hide' }
GtStyledNodeBuilder >> hideTextFrom: aStartPosition to: aStopPosition [
	"Execute clear actions"
	self properties shouldClearIt ifTrue: [ 
		self node clearActions do: [ :eachAction | 
			eachAction cull: self ] ].
	"Hide node in the text"
	self properties shouldKeepChildDisplayed ifTrue: [ 
			| aSubNode |
			aSubNode := self properties keepChildDisplayed.
			self node = aSubNode ifTrue: [ ^ self ].
			self installHideAttribute: aStartPosition to: aSubNode start - 1.
			self installHideAttribute: aSubNode stop + 1 to: aStopPosition.
			^ self ].
	self properties shouldHideParts ifTrue: [
		self properties hidingIntervals do: [ :eachInterval | 
			self installHideAttribute: eachInterval first to: eachInterval last ].
		^ self ].
	"Hide all"
	(self text from: aStartPosition to: aStopPosition) 
		attribute: GtHideAttribute uniqueInstance.
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> icon: aValuable [
	self properties icon: aValuable
]

{ #category : 'style - button' }
GtStyledNodeBuilder >> iconButton [
	"Add button to a node"
	| anAttribute |
	anAttribute := GtButtonAttribute new
		beAppend;
		stencil: [ BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				beSmallSize;
				margin: (BlInsets left: 3);
				icon: self properties icon value asElement;
				action: self properties action ].
	self nodeText attribute: anAttribute.
	self properties shouldClearIt ifTrue: [ 
		self clearAttribute: anAttribute from: self start to: self stop ].
]

{ #category : 'style - condition' }
GtStyledNodeBuilder >> if: aConditionBlock do: aStylingBlock [
	"Execute the styling block only if the condition block is true"
	aConditionBlock value ifTrue: [ aStylingBlock cull: self ].
]

{ #category : 'style - condition' }
GtStyledNodeBuilder >> if: aConditionBlock do: aStylingBlock otherwise: aSecondStylingBlock [
	"Execute the styling block only if the condition block is true"
	aConditionBlock value 
		ifTrue: [ aStylingBlock cull: self ]
		ifFalse: [ aSecondStylingBlock cull: self ]
]

{ #category : 'initialization' }
GtStyledNodeBuilder >> initialize [
	super initialize.
	document := nil.
	node := nil.
	properties := GtStyledNodeBuilderProperties new.
	text := nil.
]

{ #category : 'style - hide' }
GtStyledNodeBuilder >> installDisplayMarkupsHandler [
	"Display markups if a cursor is close to the node"
	self installDisplayMarkupsHandlerFrom: self start to: self stop.
]

{ #category : 'style - hide' }
GtStyledNodeBuilder >> installDisplayMarkupsHandlerFrom: aStartPosition to: aStopPosition [
	"Display markups if a cursor is close to the node"

	self cursorEnterAction: [ :aTextEditor :anEvent :aStart :anEnd |
		self updateText: aTextEditor text.
		self revealTextFrom: aStart to: anEnd ].

	self cursorLeaveAction: [ :aTextEditor :anEvent :aStart :anEnd |
		self updateText: aTextEditor text.
		self hideTextFrom: aStart to: anEnd ].

	self activateCursorFrom: aStartPosition to: aStopPosition
]

{ #category : 'style - hide' }
GtStyledNodeBuilder >> installHideAttribute: aStartPosition to: aStopPosition [
	(self text from: aStartPosition to: aStopPosition)
		attribute: GtHideAttribute uniqueInstance.
]

{ #category : 'style - cursor' }
GtStyledNodeBuilder >> isCursorClose [
	"Return true if a cursor is close to the node"

	<return: #Boolean>
	^ self isCursorCloseTo: self start and: self stop
]

{ #category : 'style - cursor' }
GtStyledNodeBuilder >> isCursorCloseTo: aStartPosition and: aStopPosition [
	"Return true if a cursor is close to the position interval"

	<return: #Boolean>
	| anInitialPosition aFinalPosition |
	anInitialPosition := self possibleMinCursorPosition: aStartPosition.
	aFinalPosition := self possibleMaxCursorPosition: aStopPosition.
	^ self document editor cursors
		detect:
			[ :eachCursor | eachCursor position between: anInitialPosition and: aFinalPosition ]
		ifFound: [ :aCursor | true ]
		ifNone: [ false ]
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> keepChildDisplayed: aPRDocumentItem [
	self properties keepChildDisplayed: aPRDocumentItem
]

{ #category : 'style - button' }
GtStyledNodeBuilder >> linkButton [
	"Add button to a node"
	self nodeText 
		attribute: (GtButtonAttribute new
			beAppend;
			stencil: [
				| anElements |
				anElements := self 
					maySplitString: self properties name value 
					collect: [ :eachLabel | 
						BrButton new 
							aptitude: (BrGlamorousLinkSquaredButtonWithLabelAptitude new fontSize: self normalFontSize);
							beSmallSize;
							margin: (BlInsets top: -1 left: 0 bottom: 0 right: 0);
							label: eachLabel;
							action: self properties action ]
					shareEvents: {
						BlMouseEnterEvent. BlMouseLeaveEvent.
						BlMouseDownEvent. BlMouseUpEvent. BlClickEvent.
						BlDragEnterEvent . BlDragLeaveEvent. BlDragEndEvent . BlDragStartEvent }.
				anElements size > 1 
					ifTrue: [ 
						anElements first margin: (BlInsets top: -1 left: 3 bottom: 0 right: 0).
						anElements first padding: (BlInsets top: 3 left: 3 bottom: 3 right: 0).
						anElements first geometry: ( BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
							topLeft: 4;
							topRight: 0;
							bottomLeft: 4;
							bottomRight: 0)).
						anElements last margin: (BlInsets top: -1 left: 0 bottom: 0 right: 3).
						anElements last padding: (BlInsets top: 3 left: 0 bottom: 3 right: 3).
						anElements last geometry: ( BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new
							topLeft: 0;
							topRight: 4;
							bottomLeft: 0;
							bottomRight: 4)).
						anElements allButFirstDo: [ :eachButton | eachButton action: [ "do nothing" ] ] ]
					ifFalse: [
						anElements first 
							margin: (BlInsets top: -1 left: 3 bottom: 0 right: 3);
							padding: (BlInsets top: 3 left: 3 bottom: 3 right: 3);
							geometry: (BlRoundedRectangleGeometry cornerRadius: 4) ].
				anElements ])
]

{ #category : 'style - text' }
GtStyledNodeBuilder >> maySplitString: aString [
	"Split a string according to specific split and reject actions (if they are defined)"
	<return: #Collection of: #String>
	| aSplitText |
	self properties shouldSplit ifFalse: [ ^ Array with: aString ].
	aSplitText := self properties splitBy value: aString asString.
	self assert: [ aSplitText isString not ] description: [ 'String must be split into a collection of strings' ].
	self assert: [ aSplitText isCollection ] description: [ 'String must be split into a collection' ].
	self properties shouldRejectParts ifFalse: [ ^ aSplitText ].
	^ aSplitText reject: self properties rejectParts.
]

{ #category : 'style - text' }
GtStyledNodeBuilder >> maySplitString: aString collect: aBlock [
	"Split a string according to specific split and reject actions (if they are defined)
	and collect an element for every string"
	<return: #Collection of: #BlElement>
	^ (self maySplitString: aString) collect: aBlock
]

{ #category : 'style - text' }
GtStyledNodeBuilder >> maySplitString: aString collect: aBlock shareEvents: aCollectionOfEvents [
	"Split a string according to specific split and reject actions (if they are defined)
	and collect an element for every string"
	<return: #Collection of: #BlElement>
	| aCollection aHandler |
	aCollection := self maySplitString: aString collect: aBlock.
	aCollection size = 1 ifTrue: [ ^ aCollection ].
	aHandler := BlSharedEventDistributor shareEvents: aCollectionOfEvents.
	aCollection do: [ :eachElement | eachElement addEventHandler: aHandler ].
	^ aCollection
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> name: aValuable [
	self properties name: aValuable
]

{ #category : 'accessing' }
GtStyledNodeBuilder >> node [
	<return: #PRDocumentItem>
	self
		assert: [ node isNotNil ]
		description: [ 'Pillar AST node must be initialized' ].
	^ node
]

{ #category : 'accessing' }
GtStyledNodeBuilder >> node: aPRDocumentItem [
	self
		assert: [ node isNil ] 
		description: [ 'Pillar AST node must be itialized only once' ].
	self
		assert: [ aPRDocumentItem isNotNil ] 
		description: [ 'Pillar AST node must be non-nil' ].
	node := aPRDocumentItem
]

{ #category : 'accessing - node' }
GtStyledNodeBuilder >> nodeText [
	^ self text from: self start to: self stop
]

{ #category : 'accessing - document' }
GtStyledNodeBuilder >> normalFontSize [
	^ self document normalFontSize
]

{ #category : 'style - cursor' }
GtStyledNodeBuilder >> possibleMaxCursorPosition: aStopPosition [
	^ aStopPosition min: self textStop
]

{ #category : 'style - cursor' }
GtStyledNodeBuilder >> possibleMinCursorPosition: aStartPosition [
	^ aStartPosition - 1 max: self textStart
]

{ #category : 'accessing' }
GtStyledNodeBuilder >> properties [
	<return: #GtStyledNodeBuilderProperties>
	^ properties
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> rejectParts: aRejectBlock [
	"Reject text parts as a result of a split action"
	self properties rejectParts: aRejectBlock
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> rejectSeparatorParts [
	self rejectParts: [ :aString | aString trimBoth isEmpty ]
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> revealAction: anAction [
	self properties revealAction: anAction
]

{ #category : 'style - hide' }
GtStyledNodeBuilder >> revealNode [
	"Reveal node in the text that was hidden"
	self revealTextFrom: self start to: self stop.
]

{ #category : 'style - hide' }
GtStyledNodeBuilder >> revealTextFrom: aStartPosition to: aStopPosition [
	"Reveal a text that was hidden"
	(self text from: aStartPosition to: aStopPosition) clearAttributes: [ :eachAttribute | 
		eachAttribute = GtHideAttribute uniqueInstance ].
	"Reveal other hidden parts"
	self properties shouldHideParts ifTrue: [
		self properties hidingIntervals do: [ :eachInterval | 
			(self text from: eachInterval first to: eachInterval last)
				clearAttributes: [ :eachAttribute | 
					eachAttribute = GtHideAttribute uniqueInstance ] ] ].
	"Execute reveal action, e.g,. adding text attributes"
	self properties shouldExecuteRevealActions ifTrue: [ 
		self properties revealActions do: [ :eachAction | 
			eachAction cull: self ] ].
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> spawnObject: anAction [
	^ self action: [ :aButton | aButton phlow spawnObject: anAction value ]
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> spawnTool: anAction [
	^ self action: [ :aButton | aButton phlow spawnTool: anAction value ]
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> splitBy: aSplitBlock [
	"Split text into parts and reject some parts"
	self properties splitBy: aSplitBlock
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> splitBy: aSplitBlock rejectParts: aRejectBlock [
	"Split text into parts (words) and reject some resulting text parts"
	self splitBy: aSplitBlock.
	self rejectParts: aRejectBlock.
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> splitByWords [
	self splitBy: [ :aString | 
		[ :eachCharacter | eachCharacter isSeparator ] split: aString ]
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> splitCamelCase [
	self splitBy: [ :aString | 
		Array streamContents: [ :anArrayStream | 
			aString readStreamDo: [ :aStringStream |
				| aSubStringStream |
				aSubStringStream := '' writeStream.
				[ aStringStream atEnd ] whileFalse: [ 
					| aCharacter | 
					aCharacter := aStringStream next.
					aCharacter isUppercase ifTrue: [
						aSubStringStream isEmpty ifFalse: [ 
							anArrayStream nextPut: aSubStringStream contents.
							aSubStringStream := '' writeStream ] ].
					(aSubStringStream size = 3 and: [ aSubStringStream contents = '>>#' ]) ifTrue: [
						anArrayStream nextPut: aSubStringStream contents.
						aSubStringStream := '' writeStream ].
					(aCharacter = $> and: [ aSubStringStream size > 3 ]) ifTrue: [
						anArrayStream nextPut: aSubStringStream contents.
						aSubStringStream := '' writeStream ].
					aSubStringStream nextPut: aCharacter ].
				aSubStringStream contents ifNotEmpty: [ :aContent |
					anArrayStream nextPut: aContent ] ] ] ]
]

{ #category : 'accessing - properties' }
GtStyledNodeBuilder >> splitURI [
	self splitBy: [ :aString | 
		Array streamContents: [ :anArrayStream | 
			aString readStreamDo: [ :aStringStream |
				| aSubStringStream |
				aSubStringStream := '' writeStream.
				[ aStringStream atEnd ] whileFalse: [ 
					| aCharacter | 
					aCharacter := aStringStream next.
					aSubStringStream nextPut: aCharacter.
					('/&.|+\?=' includes: aCharacter) ifTrue: [ 
						aSubStringStream size = 1 ifFalse: [ 
							anArrayStream nextPut: aSubStringStream contents.
							aSubStringStream := '' writeStream ] ] ].
				aSubStringStream contents ifNotEmpty: [ :aContent |
					anArrayStream nextPut: aContent ] ] ] ]
]

{ #category : 'accessing - node' }
GtStyledNodeBuilder >> start [
	"Return starting position of a node"
	<return: #Integer>
	^ self node start
]

{ #category : 'accessing - node' }
GtStyledNodeBuilder >> stop [
	"Return ending position of a node"
	<return: #Integer>
	^ self node stop
]

{ #category : 'style - text link' }
GtStyledNodeBuilder >> styleKnownLink [
	self styleKnownLinkFrom: self textStart to: self textStop
]

{ #category : 'style - text link' }
GtStyledNodeBuilder >> styleKnownLinkFrom: aStartIndex to: aStopIndex [
	self 
		styleLinkWithColor: self constants linkColor 
		from: aStartIndex 
		to: aStopIndex
]

{ #category : 'style - text link' }
GtStyledNodeBuilder >> styleLinkWithColor: aColor from: aStartIndex to: aStopIndex [
	(self text from: aStartIndex to: aStopIndex)
		foreground: aColor
]

{ #category : 'style - text link' }
GtStyledNodeBuilder >> styleUnknownLinkFrom: aStartIndex to: aStopIndex [
	self 
		styleLinkWithColor: self constants linkWithErrorColor 
		from: aStartIndex 
		to: aStopIndex
]

{ #category : 'accessing' }
GtStyledNodeBuilder >> text [
	<return: #BlRope>
	self
		assert: [ text isNotNil ] 
		description: [ 'Document text must be itialized before using it' ].
	^ text
]

{ #category : 'accessing' }
GtStyledNodeBuilder >> text: aBlRope [
	self
		assert: [ text isNil ] 
		description: [ 'Document text must be itialized only once' ].
	self
		assert: [ aBlRope isNotNil ] 
		description: [ 'Document text must be non-nil' ].
	text := aBlRope
]

{ #category : 'accessing - text' }
GtStyledNodeBuilder >> textStart [
	<return: #Integer>
	^ self text size isZero ifTrue: [ 0 ] ifFalse: [ 1 ]
]

{ #category : 'accessing - text' }
GtStyledNodeBuilder >> textStop [
	<return: #Integer>
	^ self text size
]

{ #category : 'accessing' }
GtStyledNodeBuilder >> updateText: aBlRope [
	self
		assert: [ text isNotNil ] 
		description: [ 'Document text must be itialized before to be able to update it' ].
	self
		assert: [ aBlRope isNotNil ] 
		description: [ 'Document text must be non-nil' ].
	text := aBlRope
]
