Class {
	#name : #GtSystemChangesHandler,
	#superclass : #Object,
	#traits : 'GtSubscriptionTrait + GtAssertingTrait',
	#classTraits : 'GtSubscriptionTrait classTrait + GtAssertingTrait classTrait',
	#instVars : [
		'document',
		'announcer',
		'isRegistered'
	],
	#category : #'GToolkit-Documenter-Core'
}

{ #category : #'announcer - accessing' }
GtSystemChangesHandler >> announcer [
	<return: #Announcer>
	self ensureSystemSubscription.
	^ announcer
]

{ #category : #private }
GtSystemChangesHandler >> ensureSystemSubscription [
	isRegistered ifTrue: [ ^ self ].
	SystemAnnouncer uniqueInstance weak 
		subscribe: SystemAnnouncement
		send: #handleSystemChange:
		to: self.
	isRegistered := true.
]

{ #category : #finalization }
GtSystemChangesHandler >> finalize [
	super finalize.
	self unsubscribeFromSystem.
]

{ #category : #'system changes' }
GtSystemChangesHandler >> handleSystemChange: aSystemAnnouncement [ 
	self announcer announce: aSystemAnnouncement 
]

{ #category : #initialization }
GtSystemChangesHandler >> initialize [
	super initialize.
	announcer := Announcer new.
	isRegistered := false.
	"self class finalizationRegistry add: self."

]

{ #category : #subscriptions }
GtSystemChangesHandler >> mayRequestDocumentUpdate [
	isRegistered ifFalse: [ ^ self ].
	announcer numberOfSubscriptions isZero ifTrue: [ ^ self ].
	self announcer announce: (GtDocumentUpdateRequestedAnnouncement new)
]

{ #category : #subscriptions }
GtSystemChangesHandler >> maySubscribeToSystem [
	isRegistered ifTrue: [ ^ self ].
	announcer numberOfSubscriptions isZero ifTrue: [ ^ self ].
	self ensureSystemSubscription. 
]

{ #category : #subscriptions }
GtSystemChangesHandler >> unsubscribeFromSystem [
	SystemAnnouncer uniqueInstance unsubscribe: self.
	isRegistered := false.
]
