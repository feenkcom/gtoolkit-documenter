Class {
	#name : #Gt2StylerEventHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'subscriber',
		'document'
	],
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #accessing }
Gt2StylerEventHandler >> document [
	<return: #Gt2Document>
	^ document
]

{ #category : #accessing }
Gt2StylerEventHandler >> document: aGt2Document [
	self 
		assert: [ aGt2Document notNil ]
		description: [ 'Document must be non-nil' ].
	document := aGt2Document
]

{ #category : #'api - event managing' }
Gt2StylerEventHandler >> handleEvent: anEvent [
	anEvent editor text size isZero ifFalse: [ ^ self ].
	self document unsubscribe: self subscriber.
]

{ #category : #accessing }
Gt2StylerEventHandler >> subscriber [
	^ subscriber
]

{ #category : #accessing }
Gt2StylerEventHandler >> subscriber: anObject [
	subscriber := anObject
]

{ #category : #'api - event managing' }
Gt2StylerEventHandler >> wantsEvent: anEvent [
	^ anEvent class = BrTextEditorDeletedEvent
]
