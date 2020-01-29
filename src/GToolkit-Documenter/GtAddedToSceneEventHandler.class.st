Class {
	#name : #GtAddedToSceneEventHandler,
	#superclass : #GtSceneInformingEventHandler,
	#category : #'GToolkit-Documenter-Brick'
}

{ #category : #accessing }
GtAddedToSceneEventHandler >> eventClass [
	^ BlElementAddedToSceneGraphEvent
]

{ #category : #'api - event managing' }
GtAddedToSceneEventHandler >> handleEvent: anEvent [
	self document updateAndSubscribeToSystem
]
