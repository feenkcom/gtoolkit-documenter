Class {
	#name : #Gt2SceneInformingElement,
	#superclass : #BlElement,
	#category : #'GToolkit-NewDocumenter-Brick'
}

{ #category : #'hooks - children' }
Gt2SceneInformingElement >> onAddedToSceneGraph [
	self space when: BlSpaceClosedEvent do: [ :ann |
		self fireEvent: Gt2RemovedFromSceneEvent new ].
	self fireEvent: Gt2AddedToSceneEvent new.
]

{ #category : #'hooks - children' }
Gt2SceneInformingElement >> onRemovedFromSceneGraph [
	self fireEvent: Gt2RemovedFromSceneEvent new
]
