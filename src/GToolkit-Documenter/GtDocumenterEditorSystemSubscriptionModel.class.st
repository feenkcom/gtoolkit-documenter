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
		'isInSceneGraph',
		'shouldUpdateWhenInSceneGraph'
	],
	#category : 'GToolkit-Documenter-! Editor - Model'
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

{ #category : #accessing }
GtDocumenterEditorSystemSubscriptionModel >> gtSubscriptionsFor: aView [
	<gtView>
	self announcer ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Subscriptions';
		priority: 2;
		object: [ self announcer ];
		view: #gtSubscriptionsFor:
]

{ #category : #'private - announcement handling' }
GtDocumenterEditorSystemSubscriptionModel >> handleSystemChangeAnnouncement: aSystemAnnouncement [
	self hasDocumentSubscriptions ifFalse: [ ^ self ].
	self isInSceneGraph 
		ifTrue: [ self announcer announce: aSystemAnnouncement ]
		ifFalse: [ shouldUpdateWhenInSceneGraph := true ]
]

{ #category : #'private - testing' }
GtDocumenterEditorSystemSubscriptionModel >> hasDocumentSubscriptions [
	^ self announcer numberOfSubscriptions isZero not
]

{ #category : #initialization }
GtDocumenterEditorSystemSubscriptionModel >> initialize [
	super initialize.
	mutexSubscription := Mutex new.
	isSubscribedToSystem := false.
	isInSceneGraph := false.
	shouldUpdateWhenInSceneGraph := false.
	announcer := self defaultAnnouncer.
]

{ #category : #initialization }
GtDocumenterEditorSystemSubscriptionModel >> initializeListeners [
	super initializeListeners.
	self 
		when: BlElementAddedToSceneGraphEvent
		do: [ :anEvent | self onAddedToSceneGraph ].
	self
		when: BlElementRemovedFromSceneGraphEvent
		do: [ :anEvent | self onRemovedFromSceneGraph ].
]

{ #category : #'private - testing' }
GtDocumenterEditorSystemSubscriptionModel >> isInSceneGraph [
	^ isInSceneGraph ifNil: [ false ]
]

{ #category : #'api - announcer' }
GtDocumenterEditorSystemSubscriptionModel >> isSubscribedToSystem [
	<return: #Boolean>
	^ mutexSubscription critical: [ isSubscribedToSystem ]
]

{ #category : #'private - updating' }
GtDocumenterEditorSystemSubscriptionModel >> mayRequestDocumentUpdate [
	self isSubscribedToSystem ifFalse: [ ^ self ].
	self hasDocumentSubscriptions ifFalse: [ ^ self ].
	self widgetDo: [ :aDocumenter | 
		aDocumenter styleTextRequest.
		self announcer announce: (GtDocumentUpdateRequestedAnnouncement new 
			document: aDocumenter) ]
]

{ #category : #'private - subscriptions' }
GtDocumenterEditorSystemSubscriptionModel >> mayUnsubscribeFromSystem [
	self hasDocumentSubscriptions ifTrue: [ ^ self ].
	self unsubscribeFromSystem
]

{ #category : #'private - event handling' }
GtDocumenterEditorSystemSubscriptionModel >> onAddedToSceneGraph [
	isInSceneGraph := true.
	shouldUpdateWhenInSceneGraph ifFalse: [ ^ self ].
	shouldUpdateWhenInSceneGraph := false.
	self mayRequestDocumentUpdate.
]

{ #category : #'private - event handling' }
GtDocumenterEditorSystemSubscriptionModel >> onRemovedFromSceneGraph [
	isInSceneGraph := false
]

{ #category : #'private - subscriptions' }
GtDocumenterEditorSystemSubscriptionModel >> setSubscribedIfAlreadySubscribedDo: aBlock [
	| wantEvaluateBlock |
	wantEvaluateBlock := false.
	mutexSubscription critical: [ 
		isSubscribedToSystem 
			ifTrue: [ wantEvaluateBlock := true ]
			ifFalse: [ isSubscribedToSystem := true ] ].
	wantEvaluateBlock ifTrue: [ aBlock ]
]

{ #category : #'private - subscriptions' }
GtDocumenterEditorSystemSubscriptionModel >> subscribeToSystem [
	self setSubscribedIfAlreadySubscribedDo: [ ^ self ].
	SystemAnnouncer uniqueInstance weak
		when: ClassAnnouncement, MethodAnnouncement, RPackageAnnouncement
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

{ #category : #'private - subscriptions' }
GtDocumenterEditorSystemSubscriptionModel >> unsubscribeFromSystem [
	mutexSubscription critical: [ 
		self isSubscribedToSystem ifFalse: [ ^ self ].
		SystemAnnouncer uniqueInstance unsubscribe: self.
		isSubscribedToSystem := false. ]
]
