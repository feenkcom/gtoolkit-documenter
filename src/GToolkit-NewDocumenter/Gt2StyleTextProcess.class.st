Class {
	#name : #Gt2StyleTextProcess,
	#superclass : #Object,
	#traits : 'TBlDebug + TGt2DocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait',
	#instVars : [
		'document',
		'process',
		'updateRequested',
		'mutex',
		'delay'
	],
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #accessing }
Gt2StyleTextProcess >> delay [
	<return: #Duration>
	^ delay
]

{ #category : #accessing }
Gt2StyleTextProcess >> document [
	<return: #Gt2Document>
	^ document
]

{ #category : #accessing }
Gt2StyleTextProcess >> document: aGt2Document [
	self 
		assert: [ aGt2Document notNil ] 
		description: [ 'Document must be non-nil' ].
	document := aGt2Document
]

{ #category : #initialization }
Gt2StyleTextProcess >> initialize [
	super initialize.
	document := nil.
	process := nil.
	delay := 50 milliSeconds.
	mutex := Mutex new.
	updateRequested := Semaphore new.
]

{ #category : #testing }
Gt2StyleTextProcess >> isActive [
	^ process notNil and: [ 
		process isTerminated not and: [ 
			process isTerminating not ] ]
]

{ #category : #actions }
Gt2StyleTextProcess >> request [
	mutex critical: [ 
		updateRequested signal.
		self isActive ifFalse: [ self start ] ]
]

{ #category : #private }
Gt2StyleTextProcess >> start [
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
Gt2StyleTextProcess >> styleText [
	#styleText traceCr.
	self document editor styleText
]
