Class {
	#name : #GtStyleTextProcess,
	#superclass : #Object,
	#traits : 'TBlDebug + TGtDocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGtDocumentConstants classTrait',
	#instVars : [
		'document',
		'process',
		'updateRequested',
		'mutex',
		'delay'
	],
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #accessing }
GtStyleTextProcess class >> constants [
	^ GtDocumentConstants
]

{ #category : #accessing }
GtStyleTextProcess >> constants [
	^ GtDocumentConstants
]

{ #category : #accessing }
GtStyleTextProcess >> delay [
	<return: #Duration>
	^ delay
]

{ #category : #accessing }
GtStyleTextProcess >> document [
	<return: #GtDocumenter>
	^ document
]

{ #category : #accessing }
GtStyleTextProcess >> document: aGt2Document [
	self 
		assert: [ aGt2Document notNil ] 
		description: [ 'Document must be non-nil' ].
	document := aGt2Document
]

{ #category : #initialization }
GtStyleTextProcess >> initialize [
	super initialize.
	document := nil.
	process := nil.
	delay := 50 milliSeconds.
	mutex := Mutex new.
	updateRequested := Semaphore new.
]

{ #category : #testing }
GtStyleTextProcess >> isActive [
	^ process notNil and: [ 
		process isTerminated not and: [ 
			process isTerminating not ] ]
]

{ #category : #actions }
GtStyleTextProcess >> request [
	mutex critical: [ 
		updateRequested signal.
		self isActive ifFalse: [ self start ] ]
]

{ #category : #private }
GtStyleTextProcess >> start [
	process := [ 
		updateRequested wait.
		self delay wait.
		updateRequested consumeAllSignals.
		self styleText.
		mutex critical: [
			process := nil.
			updateRequested isSignaled ifTrue: [ 
				self start ] ] ] 
			forkAt: Processor userBackgroundPriority 
			named: 'Documenter Text Styler'
]

{ #category : #private }
GtStyleTextProcess >> styleText [
	self document editor styleText
]
