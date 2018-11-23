Class {
	#name : #Gt2Document,
	#superclass : #Object,
	#traits : 'TBlDebug + GtAnnouncerTrait + TGt2DocumentConstants',
	#classTraits : 'TBlDebug classTrait + GtAnnouncerTrait classTrait + TGt2DocumentConstants classTrait',
	#instVars : [
		'editor',
		'announcer',
		'cache',
		'isSubscribedToSystem',
		'variableBindings',
		'storageStrategy',
		'styleTextProcess',
		'referencedFiles'
	],
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #'instance creation' }
Gt2Document class >> forClass: aClass [
	^ self new classComment: aClass; read
]

{ #category : #'instance creation' }
Gt2Document class >> forFile: aFileReference [
	^ self new fileReference: aFileReference; read
]

{ #category : #adding }
Gt2Document >> addAllImages: aCollection referencedIn: aRootDirectory [ 
	"Add collection of image files"
	| files |
	files := self fileReferencesFrom: aCollection referencedIn: aRootDirectory.
	self referencedFiles addAll: files
]

{ #category : #announcer }
Gt2Document >> announcer [
	<return: #Announcer>
	self subscribeToSystem.
	^ announcer
]

{ #category : #converting }
Gt2Document >> asElement [
	<return: #BlElement>
	^ self asElementWithoutSaveAction
		addChild: (BlElement new 
			layout: BlLinearLayout horizontal;
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c vertical fitContent.
				c horizontal fitContent.
				c ignored horizontal alignLeft.
				c ignored vertical alignBottom ];
			addChild: (BrButton new
				look: BrGlamorousButtonWithIconLook;
				icon: self constants saveButtonIcon asElement;
				label: self constants saveButtonLabel;
				action: [ self store ]);
			addChild: (BlElement new 
					viewModel: (BrToggleModel new
						icon: (self isReadingMode 
							ifTrue: [ self constants readingModeIcon asElement ]
							ifFalse: [ self constants editingModeIcon asElement ] ) );
					look: (BrMaterialToggleIconifiedLook new 
						when: BrToggleActivatedEvent do: [ :anEvent | 
							anEvent currentTarget widget viewModel icon: self constants editingModeIcon asElement.
							self editingMode ];
						when: BrToggleDeactivatedEvent do: [ :anEvent | 
							anEvent currentTarget widget viewModel icon: self constants readingModeIcon asElement.
							self readingMode ]) + BrGlamorousButtonWithIconLook - BrShadowLook))
]

{ #category : #converting }
Gt2Document >> asElementWithoutSaveAction [
	<return: #BlElement>
	| anElement anEditorElement |
	anEditorElement := BrEditorElement new
			editor: self editor;
			constraintsDo: [ :c |
				c padding: (BlInsets all: 10).
				c vertical matchParent.
				c horizontal matchParent ].
	anElement := Gt2SceneInformingElement new
		layout: BlLinearLayout new;
		addChild: anEditorElement;
		addEventHandler: (Gt2AddedToSceneEventHandler new document: self);
		addEventHandler: (Gt2RemovedFromSceneEventHandler new document: self);
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent ].
	anElement userData at: self constants documentUserDataKey put: self.
	self installCompleterForEditorElement: anEditorElement.
	^ anElement
]

{ #category : #cache }
Gt2Document >> cache [
	"It is not recommended to use this method outside of this object.
	You should use #cachAt:... relevant methods."
	<return: #Dictionary>
	^ cache
]

{ #category : #cache }
Gt2Document >> cacheAt: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ cache at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock
]

{ #category : #cache }
Gt2Document >> cacheAt: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock [
	^ cache at: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock
]

{ #category : #initialization }
Gt2Document >> classComment: aClass [ 
	self 
		assert: [ aClass notNil ]
		description: [ 'Class to document must be non-nil' ].
	self strategy: (Gt2StorageStrategy classComment: aClass)
]

{ #category : #'as yet unclassified' }
Gt2Document >> collectResources [
	| document |
	
	document := self parse.
	self
		addAllImages: (PRImageDependencies new start: document)
		referencedIn: self storage rootDirectory.
]

{ #category : #initialization }
Gt2Document >> defaultStyler [
	^ Gt2Styler new document: self; beReadingMode
]

{ #category : #initialization }
Gt2Document >> defaultText [
	^ ''
]

{ #category : #initialization }
Gt2Document >> editingMode [
	self editor styler mode isEditing ifTrue: [ ^ self ].
	self editor styler beEditingMode.
	self styleTextRequest.
]

{ #category : #accessing }
Gt2Document >> editor [
	<return: #BrTextEditor>
	^ editor
]

{ #category : #private }
Gt2Document >> ensureStyleTextProcess [
	styleTextProcess start
]

{ #category : #accessing }
Gt2Document >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution"
	<return: #Object>
	^ self storage evaluationReceiver
]

{ #category : #testing }
Gt2Document >> exists [
	<return: #Boolean>
	^ self storage exists
]

{ #category : #initialization }
Gt2Document >> fileReference: aFileReference [ 
	self 
		assert: [ aFileReference notNil ]
		description: [ 'Document file reference must be non-nil' ].
	self strategy: (Gt2StorageStrategy fileReference: aFileReference)
]

{ #category : #private }
Gt2Document >> fileReferencesFrom: aCollectionOfStringsOrPaths referencedIn: aRootDirectory [
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
Gt2Document >> gtResourcesFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Resources';
		painting: [ :aMondrian | 
			| aResource anAllResources |
			aResource := self resourcer includeDocuments; get.
			anAllResources := aResource withAllResources.
			aMondrian nodes with: anAllResources.
			aMondrian edges 
				shape: [ :eachResouce | BlLineElement new border: (BlBorder paint: Color blue width: 1) ];
				connectTo: [ :eachResource | eachResource resources ].
			aMondrian layout tree ]
]

{ #category : #'gt-extension' }
Gt2Document >> gtTextFor: aView [
	<gtView>
	self editor ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Document';
		stencil: [ self asElementWithoutSaveAction ];
		actionStencil: [ 
			| button |
			button := BrButton new.
			button
				look: BrGlamorousButtonWithIconLook;
				action:  [
					button fireEvent: (GtPhlowObjectToSpawn new
						object: self parse;
						sourceElement: button) ];
				icon: BrGlamorousIcons tree asElement;
				label: 'Parse using GToolkit Documenter' translated ];
		actionStencil: [ :tab | 
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons accept asElement;
				action: [ self store ] ];
		actionStencil: [ :tab | 
			BlElement new 
				viewModel: (BrToggleModel new
					icon: (self isReadingMode 
						ifTrue: [ self constants readingModeIcon asElement ]
						ifFalse: [ self constants editingModeIcon asElement ] ) );
				look: (BrMaterialToggleIconifiedLook new 
					when: BrToggleActivatedEvent do: [ :anEvent | 
						anEvent currentTarget widget viewModel icon: self constants editingModeIcon asElement.
						self editingMode ];
					when: BrToggleDeactivatedEvent do: [ :anEvent | 
						anEvent currentTarget widget viewModel icon: self constants readingModeIcon asElement.
						self readingMode ]) + BrGlamorousButtonWithIconLook - BrShadowLook ]
]

{ #category : #'announcement handling' }
Gt2Document >> handleSystemChangeAnnouncement: aSystemAnnouncement [
	announcer announce: aSystemAnnouncement
]

{ #category : #testing }
Gt2Document >> hasDocumentSubscriptions [
	^ announcer numberOfSubscriptions isZero not
]

{ #category : #initialization }
Gt2Document >> initialize [
	super initialize.
	styleTextProcess := Gt2StyleTextProcess new document: self.
	announcer := Announcer new.
	isSubscribedToSystem := false.
	variableBindings := GtPlaygroundBindings new.
	cache := Dictionary new.
	editor := BrTextEditor new.
	editor styler: self defaultStyler.
	self text: self defaultText.
	storageStrategy := Gt2StorageStrategy null.
	self subscribeToEditorChanges.
	referencedFiles := Set new.
]

{ #category : #private }
Gt2Document >> installCompleterForEditorElement: anEditorElement [
	| aCompletionStrategy aCompletionController |
	aCompletionStrategy := Gt2DocumentCompletionStrategy new.
	aCompletionStrategy fileReference: self rootDirectory.
	aCompletionController := GtCompletionController on: anEditorElement strategy: aCompletionStrategy.
	aCompletionController install.

]

{ #category : #testing }
Gt2Document >> isReadingMode [
	^ self editor styler mode isReading
]

{ #category : #testing }
Gt2Document >> isSubscribedToSystem [
	^ isSubscribedToSystem
]

{ #category : #subscriptions }
Gt2Document >> mayRequestDocumentUpdate [
	self isSubscribedToSystem ifFalse: [ ^ self ].
	self hasDocumentSubscriptions ifFalse: [ ^ self ].
	self styleTextRequest.
	self announcer announce: (Gt2DocumentUpdateRequestedAnnouncement new document: self)
]

{ #category : #subscriptions }
Gt2Document >> maySubscribeToSystem [
	self hasDocumentSubscriptions ifFalse: [ ^ self ].
	self subscribeToSystem
]

{ #category : #subscriptions }
Gt2Document >> mayUnsubscribeFromSystem [
	self hasDocumentSubscriptions ifTrue: [ ^ self ].
	self unsubscribeFromSystem
]

{ #category : #accessing }
Gt2Document >> name [
	<return: #String>
	^ self storage name
]

{ #category : #actions }
Gt2Document >> parse [
	"Message #isPetit2Failure helps to distinguish between a parsed document or a parser error"
	<return: #PRDocument or: #PP2Failure>
	^ PRValidation beSilentDuring: [ 
		PRPillarParser new 
			optimize; 
			parse: self text asString ].
]

{ #category : #private }
Gt2Document >> privateStyleText [
	"This method is used only for examples.
	Do not use it in other places."
	self editor styleText
]

{ #category : #actions }
Gt2Document >> read [
	storageStrategy read: self
]

{ #category : #initialization }
Gt2Document >> readingMode [
	self editor styler mode isReading ifTrue: [ ^ self ].
	self editor styler beReadingMode.
	self styleTextRequest
]

{ #category : #accessing }
Gt2Document >> referencedFiles [
	^ referencedFiles
]

{ #category : #accessing }
Gt2Document >> referencedFiles: anObject [
	referencedFiles := anObject
]

{ #category : #utility }
Gt2Document >> resourcer [
	^ Gt2ResourceVisitor new document: self
]

{ #category : #accessing }
Gt2Document >> rootDirectory [
	"Return root directory to access external data, e.g., images, change files"
	<return: #FileReference>
	^ self storage rootDirectory
]

{ #category : #accessing }
Gt2Document >> storage [
	<return: #Gt2StorageStrategy>
	^ storageStrategy
]

{ #category : #actions }
Gt2Document >> store [
	storageStrategy store: self
]

{ #category : #initialization }
Gt2Document >> strategy: aGt2StorageStrategy [ 
	self 
		assert: [ aGt2StorageStrategy notNil ]
		description: [ 'Storage strategy must be non-nil' ].
	storageStrategy := aGt2StorageStrategy
]

{ #category : #actions }
Gt2Document >> styleTextRequest [
	styleTextProcess request.
	"self editor styleText."
]

{ #category : #subscriptions }
Gt2Document >> subscribeToEditorChanges [
]

{ #category : #subscriptions }
Gt2Document >> subscribeToSystem [
	self isSubscribedToSystem ifTrue: [ ^ self ].
	SystemAnnouncer uniqueInstance weak 
		subscribe: SystemAnnouncement
		send: #handleSystemChangeAnnouncement:
		to: self.
	isSubscribedToSystem := true.
]

{ #category : #accessing }
Gt2Document >> text [
	<return: #BlText>
	^ self editor text
]

{ #category : #accessing }
Gt2Document >> text: aStringOrRope [
	self 
		assert: [ aStringOrRope notNil ] 
		description: [ 'The document text must be non-nil (a string or a rope)' ].
	editor text: aStringOrRope asRopedText.
]

{ #category : #'announcer - subscription' }
Gt2Document >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"
	| theRemovedSubscriptions |
	theRemovedSubscriptions := self announcer unsubscribe: anObject.
	self mayUnsubscribeFromSystem.
	^ theRemovedSubscriptions
]

{ #category : #subscriptions }
Gt2Document >> unsubscribeFromSystem [
	self isSubscribedToSystem ifFalse: [ ^ self ].
	SystemAnnouncer uniqueInstance unsubscribe: self.
	isSubscribedToSystem := false.
]

{ #category : #subscriptions }
Gt2Document >> updateAndSubscribeToSystem [
	self 
		maySubscribeToSystem;
		mayRequestDocumentUpdate
]

{ #category : #accessing }
Gt2Document >> variableBindings [
	^ variableBindings
]

{ #category : #accessing }
Gt2Document >> variableBindings: anObject [
	variableBindings := anObject
]
