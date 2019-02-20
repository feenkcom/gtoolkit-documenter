Class {
	#name : #GtSceneInformingEventHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'document'
	],
	#category : #'GToolkit-Documenter-Brick'
}

{ #category : #accessing }
GtSceneInformingEventHandler >> document [
	^ document
]

{ #category : #accessing }
GtSceneInformingEventHandler >> document: aGt2Document [
	self 
		assert: [ aGt2Document notNil ]
		description: [ 'Document must be non-nil' ].
	document := aGt2Document
]

{ #category : #accessing }
GtSceneInformingEventHandler >> eventClass [
	^ self subclassResponsibility
]

{ #category : #'api - event managing' }
GtSceneInformingEventHandler >> wantsEvent: anEvent [
	^ anEvent class = self eventClass
]
