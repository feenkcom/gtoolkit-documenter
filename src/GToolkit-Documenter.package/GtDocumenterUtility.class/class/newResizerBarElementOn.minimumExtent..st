brick
newResizerBarElementOn: aResizableElement minimumExtent: aPoint
	<return: #BlElement>
	
	^ BlElement new
		look: BrMaterialResizerBottomBarLook new;
		addEventHandler: (BlResizerBottomListener new 
			resizeTarget: aResizableElement; 
			minimumExtent: aPoint)