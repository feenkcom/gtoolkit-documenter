Class {
	#name : #Gt2RemovedFromSceneEventHandler,
	#superclass : #Gt2SceneInformingEventHandler,
	#category : #'GToolkit-NewDocumenter-Brick'
}

{ #category : #accessing }
Gt2RemovedFromSceneEventHandler >> eventClass [ 
	^ Gt2RemovedFromSceneEvent
]

{ #category : #'api - event managing' }
Gt2RemovedFromSceneEventHandler >> handleEvent: anEvent [
	self document unsubscribeFromSystem
]
