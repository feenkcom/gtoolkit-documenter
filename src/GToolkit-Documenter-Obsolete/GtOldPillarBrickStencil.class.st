Class {
	#name : #GtOldPillarBrickStencil,
	#superclass : #BrStencil,
	#instVars : [
		'text',
		'editor',
		'codeSnippet'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #accessing }
GtOldPillarBrickStencil >> codeSnippet [
	^ codeSnippet
]

{ #category : #accessing }
GtOldPillarBrickStencil >> codeSnippet: anObject [
	codeSnippet := anObject
]

{ #category : #accessing }
GtOldPillarBrickStencil >> editor [
	^ editor
]

{ #category : #accessing }
GtOldPillarBrickStencil >> editor: anObject [
	editor := anObject
]

{ #category : #'instance creation' }
GtOldPillarBrickStencil >> newCompositeElement [
	<return: #BlElement>
	^ (BlElement new look: GtPillarCompositeLook new)
		margin: (BlInsets top: 5 left: 20 bottom: 5 right: 20)
]

{ #category : #'instance creation' }
GtOldPillarBrickStencil >> newEditorElementWithRopedText: aRopedText [
	<return: #BrEditorElement>
	| anEditor anEditorElement |
	
	anEditor := BrTextEditor new.
	anEditor text: aRopedText.

	anEditorElement := BrEditorElement new.
	anEditorElement editor: anEditor.
	anEditorElement look: GtPillarTextEditorLook new.
	
	^ anEditorElement
]

{ #category : #'instance creation' }
GtOldPillarBrickStencil >> newLeftAlignedToolbarElement [
	<return: #BlElement>
	^ BlElement new look: GtPillarLeftAlignedToolbarLook new
]

{ #category : #'instance creation' }
GtOldPillarBrickStencil >> newResizerBarElementOn: aResizableElement [
	<return: #BlElement>
	
	^ BlElement new
		look: BrMaterialResizerBottomBarLook new;
		addEventHandler: (BlResizerBottomListener new resizeTarget: aResizableElement; minimumExtent: 0@75)
]

{ #category : #'instance creation' }
GtOldPillarBrickStencil >> newRightAlignedToolbarElement [
	<return: #BlElement>
	^ BlElement new look: GtPillarRightAlignedToolbarLook new
]

{ #category : #'instance creation' }
GtOldPillarBrickStencil >> newSlimButtonElement [
	<return: #BlElement>
	| aButton aLook |

	aButton := BlElement new.
	aLook := BrMaterialToggleLabelledLook + GtPillarSlimButtonLook.
	aButton look: aLook.

	^ aButton
]

{ #category : #'instance creation' }
GtOldPillarBrickStencil >> newTransparentCompositeElement [
	<return: #BlElement>
	^ BlElement new look: GtPillarTransparentCompositeLook new
]

{ #category : #accessing }
GtOldPillarBrickStencil >> text [
	^ text
]

{ #category : #accessing }
GtOldPillarBrickStencil >> text: anObject [
	text := anObject
]
