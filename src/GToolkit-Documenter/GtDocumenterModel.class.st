Class {
	#name : #GtDocumenterModel,
	#superclass : #BrWidgetModel,
	#traits : 'TGtDocumentConstants',
	#classTraits : 'TGtDocumentConstants classTrait',
	#instVars : [
		'storage',
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

{ #category : #'api - storage' }
GtDocumenterModel >> classComment: aClass [ 
	self 
		assert: [ aClass notNil ]
		description: [ 'Class to document must be non-nil' ].
	self storage: (GtStorageStrategy classComment: aClass)
]

{ #category : #defaults }
GtDocumenterModel >> defaultAnnouncer [
	^ GtAnnouncer new
]

{ #category : #defaults }
GtDocumenterModel >> defaultStorage [
	^ GtStorageStrategy null
]

{ #category : #defaults }
GtDocumenterModel >> defaultVariableBindings [
	^ GtSnippetBindings new
			at: self constants thisDocument 
			put: self.
]

{ #category : #'api - storage' }
GtDocumenterModel >> evaluationReceiver [
	"Return an object that is used as a receiver (self) in a codeblock (code snippet) evalution"
	<return: #Object>
	^ self storage evaluationReceiver
]

{ #category : #'api - storage' }
GtDocumenterModel >> fileReference: aFileReference [ 
	self 
		assert: [ aFileReference notNil ]
		description: [ 'Document file reference must be non-nil' ].
	self storage: (GtStorageStrategy fileReference: aFileReference)
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
	storage := self defaultStorage.
	variableBindings := self defaultVariableBindings.
	
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

{ #category : #'api - storage' }
GtDocumenterModel >> name [
	<return: #String>
	^ self storage name
]

{ #category : #'api - storage' }
GtDocumenterModel >> read [
	self widgetDo: [ :aDocumenter |
		self storage read: aDocumenter ]
]

{ #category : #'api - storage' }
GtDocumenterModel >> rootDirectory [
	"Return root directory to access external data, e.g., images, change files"
	<return: #FileReference>
	^ self storage rootDirectory
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

{ #category : #'api - storage' }
GtDocumenterModel >> storage [
	<return: #GtStorageStrategy>
	^ storage
]

{ #category : #'api - storage' }
GtDocumenterModel >> storage: aGtStorageStrategy [
	self 
		assert: [ aGtStorageStrategy isNotNil ] 
		description: [ 'Storage strategy must be non-nil' ].
	storage := aGtStorageStrategy
]

{ #category : #'api - storage' }
GtDocumenterModel >> store [
	self widgetDo: [ :aDocumenter |
		self storage store: aDocumenter ]
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
