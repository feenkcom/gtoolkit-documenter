"
This was deprecated. See ${class:name=GtDocumenter}$ instead.
"
Class {
	#name : #GtDocument,
	#superclass : #Object,
	#traits : 'TBlDebug + TGtAnnouncer + TLepiterConstants',
	#classTraits : 'TBlDebug classTrait + TGtAnnouncer classTrait + TLepiterConstants classTrait',
	#instVars : [
		'editor',
		'announcer',
		'cache',
		'isSubscribedToSystem',
		'variableBindings',
		'storageStrategy',
		'styleTextProcess',
		'pillarParser',
		'addOns'
	],
	#category : #'GToolkit-Documenter-! Core'
}

{ #category : #accessing }
GtDocument class >> constants [
	^ GtDocumentConstants
]

{ #category : #'instance creation' }
GtDocument class >> forClass: aClass [
	^ self new classComment: aClass; read
]

{ #category : #'instance creation' }
GtDocument class >> forFile: aFileReference [
	^ self new fileReference: aFileReference; read
]

{ #category : #testing }
GtDocument class >> isDeprecated [
	^ true
]

{ #category : #accessing }
GtDocument >> addOns [
	<return: #GtTextualCoderAddOns>
	^ addOns
]

{ #category : #announcer }
GtDocument >> announcer [
	<return: #Announcer>
	self subscribeToSystem.
	^ announcer
]

{ #category : #converting }
GtDocument >> asElement [
	<return: #BlElement>
	| aDocumentElement aToolbar |
	
	aDocumentElement := self asElementWithoutSaveAction.

	aToolbar := BlElement new 
			layout: BlLinearLayout horizontal;
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent.
				c frame horizontal alignLeft.
				c frame vertical alignBottom ].

	self gtActions do: [ :eachAction | 
		(eachAction target isForViewDefinedIn: #gtTextFor:) ifTrue: [ 
			eachAction 
				asElement: [ :anActionElement | aToolbar addChild: anActionElement ]
				withHostElement: aDocumentElement ] ].
	
	aDocumentElement addChild: aToolbar.
	
	^ aDocumentElement
]

{ #category : #converting }
GtDocument >> asElementWithoutSaveAction [
	<return: #BlElement>
	| aDocumentElement |
	
	aDocumentElement := GtDocumentElement new document: self.
	aDocumentElement
		when: BlElementAddedToSceneGraphEvent do: [ self updateAndSubscribeToSystem ];
		when: BlElementRemovedFromSceneGraphEvent do: [ self unsubscribeFromSystem ].

	aDocumentElement userData at: self constants documentUserDataKey put: self.

	^ aDocumentElement
]

{ #category : #accessing }
GtDocument >> ast [
	"Message #isPetit2Failure helps to distinguish between a parsed document or a parser error"
	<return: #PRDocument or: #PP2Failure>
	^ self parse
]

{ #category : #accessing }
GtDocument >> basename [
	<return: #String>
	^ self storage basename
]

{ #category : #actions }
GtDocument >> browseClass: anEditorElement [
	| aPRDocumentOrError |
	aPRDocumentOrError := self ast. 
	aPRDocumentOrError isPetit2Failure ifTrue: [ ^ self ].
	aPRDocumentOrError accept: (
		GtCodeblockActionVisitor new 
			action: (GtCodeblockBrowseClassAction new 
				document: self;
				text: self text;
				element: anEditorElement))
]

{ #category : #actions }
GtDocument >> browseImplementors: anEditorElement [
	| aPRDocumentOrError |
	aPRDocumentOrError := self ast. 
	aPRDocumentOrError isPetit2Failure ifTrue: [ ^ self ].
	aPRDocumentOrError accept: (
		GtCodeblockActionVisitor new 
			action: (GtCodeblockBrowseImplementorsAction new 
				document: self;
				text: self text;
				element: anEditorElement))
]

{ #category : #actions }
GtDocument >> browseReferences: anEditorElement [
	| aPRDocumentOrError |
	aPRDocumentOrError := self ast. 
	aPRDocumentOrError isPetit2Failure ifTrue: [ ^ self ].
	aPRDocumentOrError accept: (
		GtCodeblockActionVisitor new 
			action: (GtCodeblockBrowseReferencesAction new 
				document: self;
				text: self text;
				element: anEditorElement))
]

{ #category : #cache }
GtDocument >> cache [
	"It is not recommended to use this method outside of this object.
	You should use #cachAt:... relevant methods."
	<return: #Dictionary>
	^ cache
]

{ #category : #cache }
GtDocument >> cacheAt: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ cache at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock
]

{ #category : #cache }
GtDocument >> cacheAt: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock [
	^ cache at: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock
]

{ #category : #initialization }
GtDocument >> classComment: aClass [ 
	self 
		assert: [ aClass notNil ]
		description: [ 'Class to document must be non-nil' ].
	self strategy: (GtStorageStrategy classComment: aClass)
]

{ #category : #accessing }
GtDocument >> constants [
	^ GtDocumentConstants
]

{ #category : #initialization }
GtDocument >> defaultStyler [
	^ GtDocumenterStyler new 
		document: self; 
		parser: self pillarParser;
		hideMarkup
]

{ #category : #initialization }
GtDocument >> defaultText [
	^ ''
]

{ #category : #initialization }
GtDocument >> displayMarkup [
	self showMarkup
]

{ #category : #actions }
GtDocument >> doItAndGoSelectionOrAll: anEditorElement [
	| aPRDocumentOrError |
	aPRDocumentOrError := self ast. 
	aPRDocumentOrError isPetit2Failure ifTrue: [ ^ self ].
	aPRDocumentOrError accept: (GtCodeblockActionVisitor new 
		action: (GtCodeblockEvaluator new
			document: self;
			text: self text;
			condition: [ :anEvaluator | anEvaluator isCursorPlacedInTheBody ]))
]

{ #category : #actions }
GtDocument >> doItSelectionOrAll: anEditorElement [
	| aPRDocumentOrError |
	aPRDocumentOrError := self ast. 
	aPRDocumentOrError isPetit2Failure ifTrue: [ ^ self ].
	aPRDocumentOrError accept: (GtCodeblockActionVisitor new 
		action: (GtCodeblockEvaluator new
			document: self;
			text: self text;
			doNotDisplayResult;
			condition: [ :anEvaluator | anEvaluator isCursorPlacedInTheBody ]))
]

{ #category : #accessing }
GtDocument >> editor [
	<return: #BrTextEditor>
	^ editor
]

{ #category : #private }
GtDocument >> ensureStyleTextProcess [
	styleTextProcess start
]

{ #category : #accessing }
GtDocument >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution"
	<return: #Object>
	^ self storage evaluationReceiver
]

{ #category : #testing }
GtDocument >> exists [
	<return: #Boolean>
	^ self storage exists
]

{ #category : #initialization }
GtDocument >> fileReference: aFileReference [ 
	self 
		assert: [ aFileReference notNil ]
		description: [ 'Document file reference must be non-nil' ].
	self strategy: (GtStorageStrategy fileReference: aFileReference)
]

{ #category : #private }
GtDocument >> fileReferencesFrom: aCollectionOfStringsOrPaths referencedIn: aRootDirectory [
	<return: #Set of: #FileReference>
	^ aCollectionOfStringsOrPaths 
		collect: [ :eachStringOrPath | | fileReference |
			eachStringOrPath isString 
				ifTrue: [ fileReference := aRootDirectory resolveString: eachStringOrPath ]
				ifFalse: [ fileReference := aRootDirectory resolve: eachStringOrPath ].
			fileReference exists ifFalse: nil ifTrue: [ fileReference ] ]
		thenSelect: #notNil
]

{ #category : #'gt-extension' }
GtDocument >> gtResourcesFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Resources';
		priority: 10;
		painting: [ :aMondrian | 
			| aResource |
			aResource := self resourcer includeDocuments; allDepth; get.
			aMondrian nodes 
				stencil: [ :eachResource | 
					| anElement |
					eachResource isDocument ifTrue: [ 
						anElement := BrCard new
							size: 200@100;
							aptitude: BrShadowAptitude + BrGlamorousLabelAptitude + BrDescriptionAptitude 
								+ BrGlamorousWithVerticalResizerAptitude + BrGlamorousWithHorizontalResizerAptitude;
							margin: (BlInsets all: 10);
							padding: (BlInsets all: 10);
							background: Color white;
							title: (eachResource document name asRopedText bold);
							description: ((eachResource document text asString 
									first: (100 min: eachResource document text size))
								asRopedText foreground: Color gray);
							action: [ :aBrCard | aBrCard phlow spawnObject: eachResource ].
						 ]];
				with: aResource withAllResources.
			aMondrian edges 
				fromRightCenter;
				toLeftCenter;
				connectToAll: #resources.
			aMondrian layout custom: (GtGradHorizontalDominanceCenteredTreeLayout new 
				levelDistance: 50; nodeDistance: 10) ] 
]

{ #category : #'gt-extension' }
GtDocument >> gtSaveActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: self constants saveButtonIcon asElement;
		tooltip: 'Save document';
		forViewDefinedIn: #gtTextFor:;
		priority: 1;
		action: [ self save ]
]

{ #category : #'gt-extension' }
GtDocument >> gtShowMarkupActionFor: anAction [
	<gtAction>
	^ anAction toggle
		icon: self constants editButtonIcon;
		tooltip: 'Show/Hide Markups';
		forViewDefinedIn: #gtTextFor:;
		priority: 3;
		activatedAction: [ self displayMarkup ];
		deactivatedAction: [ self hideMarkup ]
]

{ #category : #'gt-extension' }
GtDocument >> gtTextFor: aView [
	<gtView>
	self editor ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Document';
		priority: 1;
		stencil: [ self asElementWithoutSaveAction ];
		actionButtonIcon: BrGlamorousIcons tree 
			tooltip: 'Display AST nodes'
			action: [ :aWidget | aWidget phlow spawnObject: self parse ]
]

{ #category : #'announcement handling' }
GtDocument >> handleSystemChangeAnnouncement: aSystemAnnouncement [
	announcer announce: aSystemAnnouncement
]

{ #category : #testing }
GtDocument >> hasDocumentSubscriptions [
	^ announcer numberOfSubscriptions isZero not
]

{ #category : #initialization }
GtDocument >> hideMarkup [
	self editor styler mode isReading ifTrue: [ ^ self ].
	self editor styler hideMarkup.
	self styleTextRequest
]

{ #category : #initialization }
GtDocument >> initialize [
	super initialize.
	styleTextProcess := GtStyleTextProcess new document: self.
	announcer := Announcer new.
	isSubscribedToSystem := false.
	variableBindings := GtLocalVariablesBindings new.
	variableBindings localAt: self constants thisDocument put: self.
	cache := Dictionary new.
	editor := BrTextEditor new.
	editor styler: self defaultStyler.
	self text: self defaultText.
	storageStrategy := GtStorageStrategy null.
	self subscribeToEditorChanges.
	self initializeAddOns.
]

{ #category : #initialization }
GtDocument >> initializeAddOns [
	addOns := GtTextualCoderAddOns new.
	self initializeShortcuts.
]

{ #category : #initialization }
GtDocument >> initializeShortcuts [

	addOns
		addShortcut: (BlShortcutWithAction new
			combination: BlKeyCombination primaryM;
			action: [ :anEvent | self browseImplementors: anEvent currentTarget ]);
		addShortcut: (BlShortcutWithAction new
			combination: BlKeyCombination primaryN;
			action: [ :anEvent | self browseReferences: anEvent currentTarget ]);
		addShortcut: (BlShortcutWithAction new
			combination: BlKeyCombination primaryB;
			action: [ :anEvent | self browseClass: anEvent currentTarget ]);
		addShortcut: (BlShortcutWithAction new
			combination: BlKeyCombination primaryD;
			action: [ :anEvent | self doItSelectionOrAll: anEvent currentTarget ]);
		addShortcut: (BlShortcutWithAction new
			combination: BlKeyCombination primaryG;
			action: [ :anEvent | self doItAndGoSelectionOrAll: anEvent currentTarget ])
]

{ #category : #private }
GtDocument >> installCompleterForEditorElement: anEditorElement [
	| aCompletionStrategy aCompletionController |
	aCompletionStrategy := GtDocumentCompletionStrategy new.
	aCompletionStrategy fileReference: self rootDirectory.
	aCompletionController := GtCompletionController on: anEditorElement strategy: aCompletionStrategy.
	aCompletionController install.

]

{ #category : #testing }
GtDocument >> isReadingMode [
	^ self editor styler mode isReading
]

{ #category : #testing }
GtDocument >> isSubscribedToSystem [
	^ isSubscribedToSystem
]

{ #category : #subscriptions }
GtDocument >> mayRequestDocumentUpdate [
	self isSubscribedToSystem ifFalse: [ ^ self ].
	self hasDocumentSubscriptions ifFalse: [ ^ self ].
	self styleTextRequest.
	self announcer announce: (GtDocumentUpdateRequestedAnnouncement new document: self)
]

{ #category : #subscriptions }
GtDocument >> maySubscribeToSystem [
	self hasDocumentSubscriptions ifFalse: [ ^ self ].
	self subscribeToSystem
]

{ #category : #subscriptions }
GtDocument >> mayUnsubscribeFromSystem [
	self hasDocumentSubscriptions ifTrue: [ ^ self ].
	self unsubscribeFromSystem
]

{ #category : #accessing }
GtDocument >> name [
	<return: #String>
	^ self storage name
]

{ #category : #initialization }
GtDocument >> noInteractions [
	self editor styler mode isNoInteractions ifTrue: [ ^ self ].
	self editor styler noInteractions.
	self styleTextRequest
]

{ #category : #accessing }
GtDocument >> normalFontSize [
	^ 12
]

{ #category : #actions }
GtDocument >> parse [
	"Message #isPetit2Failure helps to distinguish between a parsed document or a parser error"
	<return: #PRDocument or: #PP2Failure>
	^ PRValidation beSilentDuring: [ 
		self pillarParser parse: self string ].
]

{ #category : #utility }
GtDocument >> pillarParser [
	<return: #PRPillarParser>

	^ pillarParser ifNil: [ pillarParser := GtDocumenterParser new ]
]

{ #category : #private }
GtDocument >> privateStyleText [
	"This method is used only for examples.
	Do not use it in other places."
	self editor styleText
]

{ #category : #actions }
GtDocument >> read [
	storageStrategy read: self
]

{ #category : #utility }
GtDocument >> resourcer [
	^ GtResourceVisitor new document: self
]

{ #category : #accessing }
GtDocument >> rootDirectory [
	"Return root directory to access external data, e.g., images, change files"
	<return: #FileReference>
	^ self storage rootDirectory
]

{ #category : #actions }
GtDocument >> save [
	storageStrategy save: self
]

{ #category : #initialization }
GtDocument >> showMarkup [
	self editor styler mode isEditing ifTrue: [ ^ self ].
	self editor styler displayMarkup.
	self styleTextRequest.
]

{ #category : #accessing }
GtDocument >> storage [
	<return: #GtStorageStrategy>
	^ storageStrategy
]

{ #category : #actions }
GtDocument >> store [
	self
		deprecated: 'Please use save method instead.'
		transformWith:
			'`@receiver store'
				-> '`@receiver save'.
	self save
]

{ #category : #initialization }
GtDocument >> strategy: aGt2StorageStrategy [ 
	self 
		assert: [ aGt2StorageStrategy notNil ]
		description: [ 'Storage strategy must be non-nil' ].
	storageStrategy := aGt2StorageStrategy
]

{ #category : #accessing }
GtDocument >> string [
	<return: #String>
	^ self text asString
]

{ #category : #actions }
GtDocument >> styleTextRequest [
	styleTextProcess request.
]

{ #category : #subscriptions }
GtDocument >> subscribeToEditorChanges [
]

{ #category : #subscriptions }
GtDocument >> subscribeToSystem [
	self isSubscribedToSystem
		ifTrue: [ ^ self ].
	SystemAnnouncer uniqueInstance weak
		when: SystemAnnouncement
		send: #handleSystemChangeAnnouncement:
		to: self.
	isSubscribedToSystem := true
]

{ #category : #announcer }
GtDocument >> systemAnnouncer [
	^ self
]

{ #category : #accessing }
GtDocument >> text [
	<return: #BlText>
	^ self editor text
]

{ #category : #accessing }
GtDocument >> text: aStringOrRope [
	self 
		assert: [ aStringOrRope notNil ] 
		description: [ 'The document text must be non-nil (a string or a rope)' ].
	editor text: aStringOrRope asRopedText.
]

{ #category : #'announcer - subscription' }
GtDocument >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"
	| theRemovedSubscriptions |
	theRemovedSubscriptions := self announcer unsubscribe: anObject.
	self mayUnsubscribeFromSystem.
	^ theRemovedSubscriptions
]

{ #category : #subscriptions }
GtDocument >> unsubscribeFromSystem [
	self isSubscribedToSystem ifFalse: [ ^ self ].
	SystemAnnouncer uniqueInstance unsubscribe: self.
	isSubscribedToSystem := false.
]

{ #category : #subscriptions }
GtDocument >> updateAndSubscribeToSystem [
	self 
		maySubscribeToSystem;
		mayRequestDocumentUpdate
]

{ #category : #accessing }
GtDocument >> variableBindings [
	^ variableBindings
]

{ #category : #accessing }
GtDocument >> variableBindings: anObject [
	variableBindings := anObject
]
