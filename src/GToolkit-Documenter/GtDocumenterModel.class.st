Class {
	#name : #GtDocumenterModel,
	#superclass : #BrWidgetModel,
	#traits : 'TGtDocumentConstants',
	#classTraits : 'TGtDocumentConstants classTrait',
	#instVars : [
		'announcer',
		'mutexSubscription',
		'isSubscribedToSystem',
		'variableBindings'
	],
	#category : #'GToolkit-Documenter-! Core'
}

{ #category : #'api - announcer' }
GtDocumenterModel >> announce: anAnnouncement [
	self announcer announce: anAnnouncement
]

{ #category : #'api - announcer' }
GtDocumenterModel >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #defaults }
GtDocumenterModel >> defaultAnnouncer [
	^ GtAnnouncer new
]

{ #category : #defaults }
GtDocumenterModel >> defaultVariableBindings [
	^ GtSnippetBindings new
			at: self constants thisDocument 
			put: self.
]

{ #category : #'announcement handling' }
GtDocumenterModel >> handleSystemChangeAnnouncement: aSystemAnnouncement [
	self announcer announce: aSystemAnnouncement
]

{ #category : #subscriptions }
GtDocumenterModel >> hasDocumentSubscriptions [
	^ self announcer numberOfSubscriptions isZero not
]

{ #category : #initialization }
GtDocumenterModel >> initialize [
	super initialize.
	mutexSubscription := Mutex new.
	isSubscribedToSystem := false.
	announcer := self defaultAnnouncer.
	variableBindings := self defaultVariableBindings.
	
]

{ #category : #initialization }
GtDocumenterModel >> initializeListeners [
	super initializeListeners.
	
	self 
		when: GtDocumenterStorageChanged 
		reply: [ :aResponse | aResponse storage: self storage ].
]

{ #category : #'api - announcer' }
GtDocumenterModel >> isSubscribedToSystem [
	<return: #Boolean>
	^ mutexSubscription critical: [ isSubscribedToSystem ]
]

{ #category : #updating }
GtDocumenterModel >> mayRequestDocumentUpdate [
	self isSubscribedToSystem ifFalse: [ ^ self ].
	self hasDocumentSubscriptions ifFalse: [ ^ self ].
	self widgetDo: [ :aDocumenter | 
		aDocumenter styleTextRequest.
		self announcer announce: (GtDocumentUpdateRequestedAnnouncement new 
			document: aDocumenter) ]
]

{ #category : #updating }
GtDocumenterModel >> maySubscribeToSystem [
	self hasDocumentSubscriptions ifFalse: [ ^ self ].
	self subscribeToSystem
]

{ #category : #subscriptions }
GtDocumenterModel >> mayUnsubscribeFromSystem [
	self hasDocumentSubscriptions ifTrue: [ ^ self ].
	self unsubscribeFromSystem
]

{ #category : #subscriptions }
GtDocumenterModel >> setSubscribedIfAlreadySubscribedDo: aBlock [
	| wantEvaluateBlock |
	wantEvaluateBlock := false.
	mutexSubscription critical: [ 
		isSubscribedToSystem 
			ifTrue: [ wantEvaluateBlock := true ]
			ifFalse: [ isSubscribedToSystem := true ] ].
	wantEvaluateBlock ifTrue: [ aBlock ]
]

{ #category : #subscriptions }
GtDocumenterModel >> subscribeToSystem [
	self setSubscribedIfAlreadySubscribedDo: [ ^ self ].
	SystemAnnouncer uniqueInstance weak
		when: SystemAnnouncement
		send: #handleSystemChangeAnnouncement:
		to: self.
]

{ #category : #'api - announcer' }
GtDocumenterModel >> systemAnnouncer [
	<return: #Announcer>
	self subscribeToSystem.
	^ self announcer
]

{ #category : #'api - announcer' }
GtDocumenterModel >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"
	| theRemovedSubscriptions |
	theRemovedSubscriptions := self announcer unsubscribe: anObject.
	self mayUnsubscribeFromSystem.
	^ theRemovedSubscriptions
]

{ #category : #subscriptions }
GtDocumenterModel >> unsubscribeFromSystem [
	mutexSubscription critical: [ 
		self isSubscribedToSystem ifFalse: [ ^ self ].
		SystemAnnouncer uniqueInstance unsubscribe: self.
		isSubscribedToSystem := false. ]
]

{ #category : #'api - updating' }
GtDocumenterModel >> updateAndSubscribeToSystem [
	self 
		maySubscribeToSystem;
		mayRequestDocumentUpdate
]

{ #category : #'api - variables' }
GtDocumenterModel >> variableBindings [
	<return: #GtSnippetBindings>
	^ variableBindings
]
