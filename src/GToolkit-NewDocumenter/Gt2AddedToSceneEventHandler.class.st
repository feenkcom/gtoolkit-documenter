Class {
	#name : #Gt2AddedToSceneEventHandler,
	#superclass : #Gt2SceneInformingEventHandler,
	#category : #'GToolkit-NewDocumenter-Brick'
}

{ #category : #accessing }
Gt2AddedToSceneEventHandler >> eventClass [
	^ Gt2AddedToSceneEvent
]

{ #category : #'api - event managing' }
Gt2AddedToSceneEventHandler >> handleEvent: anEvent [
	self document updateAndSubscribeToSystem
]
