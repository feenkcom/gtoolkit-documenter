Class {
	#name : #GtSceneInformingElement,
	#superclass : #BlElement,
	#category : #'GToolkit-Documenter-Brick'
}

{ #category : #'hooks - children' }
GtSceneInformingElement >> onAddedToSceneGraph [
	| eventHandler |
	eventHandler := BlEventHandler on: BlSpaceClosedEvent do: [ :ann |
		self fireEvent: GtRemovedFromSceneEvent new.
		self space removeEventHandler: eventHandler ].
	self space addEventHandler: eventHandler. 
	self fireEvent: GtAddedToSceneEvent new.
]

{ #category : #'hooks - children' }
GtSceneInformingElement >> onRemovedFromSceneGraph [
	self fireEvent: GtRemovedFromSceneEvent new
]
