Class {
	#name : #Gt2Document,
	#superclass : #Object,
	#traits : 'TBlDebug + GtAnnouncerTrait',
	#classTraits : 'TBlDebug classTrait + GtAnnouncerTrait classTrait',
	#instVars : [
		'editor',
		'announcer',
		'isSubscribedToSystem'
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
				c vertical matchParent.
				c horizontal matchParent ]);
		addEventHandler: (Gt2AddedToSceneEventHandler new document: self);
		addEventHandler: (Gt2RemovedFromSceneEventHandler new document: self);
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent ]
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

{ #category : #'gt-extension' }
Gt2Document >> gtTextFor: aView [
	<gtView>
	self editor ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Document';
		stencil: [ self ]
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
	editor := BrTextEditor new.
	editor styler: self defaultStyler.
	self text: self defaultText.
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
