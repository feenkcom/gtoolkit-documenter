"
I contain common element creation methods shared by various documenter stencils
"
Trait {
	#name : #TGtPillarPreviewStencil,
	#category : #'GToolkit-Documenter-Brick-Stencils'
}

{ #category : #'instance creation' }
TGtPillarPreviewStencil >> newCompositeElement [
	<return: #BlElement>
	^ BlElement new look: GtPillarExpandedPreviewLook + GtPillarResizablePreviewLook
]

{ #category : #'instance creation' }
TGtPillarPreviewStencil >> newLeftAlignedToolbarElement [
	<return: #BlElement>
	^ BlElement new look: GtPillarLeftAlignedToolbarLook new
]

{ #category : #'instance creation' }
TGtPillarPreviewStencil >> newResizerBarElementOn: aResizableElement [
	<return: #BlElement>
	
	^ BlElement new
		look: BrMaterialResizerBottomBarLook new;
		addEventHandler: (BlResizerBottomListener new resizeTarget: aResizableElement; minimumExtent: 0@75)
]

{ #category : #'instance creation' }
TGtPillarPreviewStencil >> newRightAlignedToolbarElement [
	<return: #BlElement>
	^ BlElement new look: GtPillarRightAlignedToolbarLook new
]

{ #category : #'instance creation' }
TGtPillarPreviewStencil >> newSlimButton [
	<return: #BlElement>

	^ BrButton new
		look: BrGlamorousButtonWithLabelLook + GtPillarSlimButtonLook
]
