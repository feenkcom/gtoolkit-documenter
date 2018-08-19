brick
newResizableElementFor: aWrappedElement height: aHeightInteger
	<return: #BlElement>
	| aResizer aContainer |

	aContainer := BlElement new.

	aResizer := BlElement new
		look: BrMaterialResizerBottomBarLook new;
		addEventHandler: (BlResizerBottomListener new resizeTarget: aContainer; minimumExtent: 0@75).
	aWrappedElement constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	aContainer 
		look: GtPillarExpandedPreviewLook;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: aHeightInteger ];
		addChild: aWrappedElement;
		addChild: aResizer.
	 ^ aContainer