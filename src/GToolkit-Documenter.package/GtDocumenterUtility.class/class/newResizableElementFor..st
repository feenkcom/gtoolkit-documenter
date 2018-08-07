brick
newResizableElementFor: aWrappedElement
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
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c textFlow pushLine.
			c vertical exact: 300 ];
		addChild: aScalableElement; 
		addChild: aResizer.
	 ^ aContainer