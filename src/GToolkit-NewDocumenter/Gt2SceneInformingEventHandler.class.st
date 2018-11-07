Class {
	#name : #Gt2SceneInformingEventHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'document'
	],
	#category : #'GToolkit-NewDocumenter-Brick'
}

{ #category : #accessing }
Gt2SceneInformingEventHandler >> document [
	^ document
]

{ #category : #accessing }
Gt2SceneInformingEventHandler >> document: aGt2Document [
	self 
		assert: [ aGt2Document notNil ]
		description: [ 'Document must be non-nil' ].
	document := aGt2Document
]

{ #category : #accessing }
Gt2SceneInformingEventHandler >> eventClass [
	^ self subclassResponsibility
]

{ #category : #'api - event managing' }
Gt2SceneInformingEventHandler >> wantsEvent: anEvent [
	^ anEvent class = self eventClass
]
