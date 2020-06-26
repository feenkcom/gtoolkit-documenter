"
I dynamically subscribe to and unsubscribe from ${class:SystemAnnouncer}$ unique instance.
I inform document instances, in particular ${class:PRDocumentItem}$ Pillar AST document nodes about system changes.
I am used by ${class:GtDocumenterEditor}$.

"
Class {
	#name : #GtDocumenterEditorSystemSubscriptionModel,
	#superclass : #BrWidgetModel,
	#traits : 'TGtDocumentConstants',
	#classTraits : 'TGtDocumentConstants classTrait',
	#instVars : [
		'announcer',
		'mutexSubscription',
		'isSubscribedToSystem',
		'variableBindings'
	],
	#category : #'GToolkit-Documenter-! Editor - Model'
}

{ #category : #'api - announcer' }
GtDocumenterEditorSystemSubscriptionModel >> announce: anAnnouncement [
	self announcer announce: anAnnouncement
]

{ #category : #'api - announcer' }
GtDocumenterEditorSystemSubscriptionModel >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #defaults }
GtDocumenterEditorSystemSubscriptionModel >> defaultAnnouncer [
	^ GtAnnouncer new
]

{ #category : #'announcement handling' }
GtDocumenterEditorSystemSubscriptionModel >> handleSystemChangeAnnouncement: aSystemAnnouncement [
	self announcer announce: aSystemAnnouncement
]

{ #category : #subscriptions }
GtDocumenterEditorSystemSubscriptionModel >> hasDocumentSubscriptions [
	^ self announcer numberOfSubscriptions isZero not
]

{ #category : #initialization }
GtDocumenterEditorSystemSubscriptionModel >> initialize [
	super initialize.
	mutexSubscription := Mutex new.
	isSubscribedToSystem := false.
	announcer := self defaultAnnouncer.
]

{ #category : #'api - announcer' }
GtDocumenterEditorSystemSubscriptionModel >> isSubscribedToSystem [
	<return: #Boolean>
	^ mutexSubscription critical: [ isSubscribedToSystem ]
]

{ #category : #updating }
GtDocumenterEditorSystemSubscriptionModel >> mayRequestDocumentUpdate [
	self isSubscribedToSystem ifFalse: [ ^ self ].
	self hasDocumentSubscriptions ifFalse: [ ^ self ].
	self widgetDo: [ :aDocumenter | 
		aDocumenter styleTextRequest.
		self announcer announce: (GtDocumentUpdateRequestedAnnouncement new 
			document: aDocumenter) ]
]

{ #category : #subscriptions }
GtDocumenterEditorSystemSubscriptionModel >> maySubscribeToSystem [
	self hasDocumentSubscriptions ifFalse: [ ^ self ].
	self subscribeToSystem
]

{ #category : #subscriptions }
GtDocumenterEditorSystemSubscriptionModel >> mayUnsubscribeFromSystem [
	self hasDocumentSubscriptions ifTrue: [ ^ self ].
	self unsubscribeFromSystem
]

{ #category : #subscriptions }
GtDocumenterEditorSystemSubscriptionModel >> setSubscribedIfAlreadySubscribedDo: aBlock [
	| wantEvaluateBlock |
	wantEvaluateBlock := false.
	mutexSubscription critical: [ 
		isSubscribedToSystem 
			ifTrue: [ wantEvaluateBlock := true ]
			ifFalse: [ isSubscribedToSystem := true ] ].
	wantEvaluateBlock ifTrue: [ aBlock ]
]

{ #category : #subscriptions }
GtDocumenterEditorSystemSubscriptionModel >> subscribeToSystem [
	self setSubscribedIfAlreadySubscribedDo: [ ^ self ].
	SystemAnnouncer uniqueInstance weak
		when: SystemAnnouncement
		send: #handleSystemChangeAnnouncement:
		to: self.
]

{ #category : #'api - announcer' }
GtDocumenterEditorSystemSubscriptionModel >> systemAnnouncer [
	<return: #Announcer>
	self subscribeToSystem.
	^ self announcer
]

{ #category : #'api - announcer' }
GtDocumenterEditorSystemSubscriptionModel >> systemSubscriber [
	^ self
]

{ #category : #'api - announcer' }
GtDocumenterEditorSystemSubscriptionModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"
	| theRemovedSubscriptions |
	theRemovedSubscriptions := self announcer unsubscribe: anObject.
	self mayUnsubscribeFromSystem.
	^ theRemovedSubscriptions
]

{ #category : #subscriptions }
GtDocumenterEditorSystemSubscriptionModel >> unsubscribeFromSystem [
	mutexSubscription critical: [ 
		self isSubscribedToSystem ifFalse: [ ^ self ].
		SystemAnnouncer uniqueInstance unsubscribe: self.
		isSubscribedToSystem := false. ]
]

{ #category : #'api - updating' }
GtDocumenterEditorSystemSubscriptionModel >> updateAndSubscribeToSystem [
	self 
		maySubscribeToSystem;
		mayRequestDocumentUpdate
]
