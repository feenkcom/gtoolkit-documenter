Class {
	#name : #Gt2Document,
	#superclass : #Object,
	#traits : 'TBlDebug + GtAnnouncerTrait',
	#classTraits : 'TBlDebug classTrait + GtAnnouncerTrait classTrait',
	#instVars : [
		'editor',
		'announcer',
		'cache',
		'isSubscribedToSystem',
		'variableBindings',
		'storageStrategy'
	],
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #announcer }
Gt2Document >> announcer [
	<return: #Announcer>
	self subscribeToSystem.
	^ announcer
]

{ #category : #converting }
Gt2Document >> asElement [
	<return: #BlElement>
	^ Gt2SceneInformingElement new
		layout: BlLinearLayout new;
		addChild: (BrEditorElement new
			editor: self editor;
			constraintsDo: [ :c |
				c padding: (BlInsets all: 10).
				c vertical matchParent.
				c horizontal matchParent ]);
		addEventHandler: (Gt2AddedToSceneEventHandler new document: self);
		addEventHandler: (Gt2RemovedFromSceneEventHandler new document: self);
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent ]
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
Gt2Document >> defaultStyler [
	^ Gt2Styler new document: self
]

{ #category : #initialization }
Gt2Document >> defaultText [
	^ ''
]

{ #category : #accessing }
Gt2Document >> editor [
	<return: #BrTextEditor>
	^ editor
]

{ #category : #initialization }
Gt2Document >> fileReference: aFileReference [ 
	self 
		assert: [ aFileReference notNil ]
		description: [ 'Document file reference must be non-nil' ].
	self strategy: (Gt2StorageStrategy fileReference: aFileReference)
]

{ #category : #'gt-extension' }
Gt2Document >> gtTextFor: aView [
	<gtView>
	self editor ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Document';
		stencil: [ self ];
		actionStencil: [ 
			| button |
			button := BrButton new.
			button
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				action:  [
					button fireEvent: (GtPhlowObjectToSpawn new
						object: self parse;
						sourceElement: button) ];
				icon: BrGlamorousIcons tree asElement;
				label: 'Parse using GToolkit Documenter' translated ];
		actionStencil: [ :tab | 
			BrButton new 
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				icon: BrGlamorousIcons accept asElement;
				action: [ self store ] ]
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
	announcer := Announcer new.
	isSubscribedToSystem := false.
	variableBindings := GtPlaygroundBindings new.
	cache := Dictionary new.
	editor := BrTextEditor new.
	editor styler: self defaultStyler.
	self text: self defaultText.
	storageStrategy := Gt2StorageStrategy null.
	self subscribeToEditorChanges.
]

{ #category : #testing }
Gt2Document >> isSubscribedToSystem [
	^ isSubscribedToSystem
]

{ #category : #subscriptions }
Gt2Document >> mayRequestDocumentUpdate [
	self isSubscribedToSystem ifFalse: [ ^ self ].
	self hasDocumentSubscriptions ifFalse: [ ^ self ].
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

{ #category : #actions }
Gt2Document >> parse [
	^ PRPillarParser new 
		optimize; 
		parse: self text asString
]

{ #category : #actions }
Gt2Document >> read [
	storageStrategy read: self
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
