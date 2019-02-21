Class {
	#name : #GtRemovedFromSceneEventHandler,
	#superclass : #GtSceneInformingEventHandler,
	#category : #'GToolkit-Documenter-Brick'
}

{ #category : #accessing }
GtRemovedFromSceneEventHandler >> eventClass [ 
	^ GtRemovedFromSceneEvent
]

{ #category : #'api - event managing' }
GtRemovedFromSceneEventHandler >> handleEvent: anEvent [
	self document unsubscribeFromSystem
]
