brick
newResizableAndPannableElementFor: aWrappedElement height: aHeightInteger
	<return: #BlElement>
	| aScalableElement aResizer aContainer |

	aContainer := BlElement new.

	aScalableElement := BlPannableElement new.

	aScalableElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	aScalableElement contentElement: aWrappedElement.

	aResizer := BlElement new
		look: BrMaterialResizerBottomBarLook new;
		addEventHandler: (BlResizerBottomListener new resizeTarget: aContainer; minimumExtent: 0@75).

	aContainer 
		look: GtPillarExpandedPreviewLook;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: aHeightInteger ];
		addChild: aScalableElement; 
		addChild: aResizer.
	 ^ aContainer