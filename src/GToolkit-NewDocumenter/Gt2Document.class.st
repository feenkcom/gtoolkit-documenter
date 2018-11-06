Class {
	#name : #Gt2Document,
	#superclass : #Object,
	#traits : 'TBlDebug + GtAnnouncerTrait',
	#classTraits : 'TBlDebug classTrait + GtAnnouncerTrait classTrait',
	#instVars : [
		'editor',
		'announcer',
		'isRegisteredToSystem'
	],
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #announcer }
Gt2Document >> announcer [
	<return: #Announcer>
	self ensureSystemSubscription.
	^ announcer
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

{ #category : #subscriptions }
Gt2Document >> ensureSystemSubscription [
	isRegisteredToSystem ifTrue: [ ^ self ].
	SystemAnnouncer uniqueInstance weak 
		subscribe: SystemAnnouncement
		send: #handleSystemChangeAnnouncement:
		to: self.
	isRegisteredToSystem := true.
]

{ #category : #'gt-extension' }
Gt2Document >> gtTextFor: aView [
	<gtView>
	self editor ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'Text';
		text: [ self text ]
]

{ #category : #'announcement handling' }
Gt2Document >> handleSystemChangeAnnouncement: aSystemAnnouncement [
	announcer announce: aSystemAnnouncement
]

{ #category : #initialization }
Gt2Document >> initialize [
	super initialize.
	announcer := Announcer new.
	isRegisteredToSystem := false.
	editor := BrTextEditor new.
	editor styler: self defaultStyler.
	self text: self defaultText.
	self subscribeToEditorChanges.
]

{ #category : #testing }
Gt2Document >> isRegisteredToSystem [
	^ isRegisteredToSystem
]

{ #category : #subscriptions }
Gt2Document >> mayUnsubscribeFromSystem [
	announcer numberOfSubscriptions isZero ifFalse: [ ^ self ].
	SystemAnnouncer uniqueInstance unsubscribe: self.
	isRegisteredToSystem := false.
]

{ #category : #subscriptions }
Gt2Document >> subscribeToEditorChanges [
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
