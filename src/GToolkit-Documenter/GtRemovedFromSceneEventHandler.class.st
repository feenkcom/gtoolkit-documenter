Class {
	#name : #GtRemovedFromSceneEventHandler,
	#superclass : #GtSceneInformingEventHandler,
	#category : #'GToolkit-Documenter-Brick'
}

{ #category : #accessing }
GtRemovedFromSceneEventHandler >> eventClass [ 
	^ BlElementRemovedFromSceneGraphEvent
]

{ #category : #'api - event managing' }
GtRemovedFromSceneEventHandler >> handleEvent: anEvent [
	self document unsubscribeFromSystem
]
