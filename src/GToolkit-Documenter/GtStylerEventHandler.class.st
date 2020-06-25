Class {
	#name : #GtStylerEventHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'subscriber',
		'document'
	],
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #accessing }
GtStylerEventHandler >> document [
	<return: #GtDocumenter>
	^ document
]

{ #category : #accessing }
GtStylerEventHandler >> document: aGt2Document [
	self 
		assert: [ aGt2Document notNil ]
		description: [ 'Document must be non-nil' ].
	document := aGt2Document
]

{ #category : #'api - event managing' }
GtStylerEventHandler >> handleEvent: anEvent [
	anEvent editor text size isZero ifFalse: [ ^ self ].
	self document unsubscribe: self subscriber.
]

{ #category : #accessing }
GtStylerEventHandler >> subscriber [
	^ subscriber
]

{ #category : #accessing }
GtStylerEventHandler >> subscriber: anObject [
	subscriber := anObject
]

{ #category : #'api - event managing' }
GtStylerEventHandler >> wantsEvent: anEvent [
	^ anEvent class = BrTextEditorDeletedEvent
]
