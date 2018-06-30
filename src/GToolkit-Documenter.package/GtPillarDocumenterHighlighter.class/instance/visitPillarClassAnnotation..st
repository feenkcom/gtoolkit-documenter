visiting
visitPillarClassAnnotation: aGtPillarClassAnnotation 
	| aClassParameterNode |
	aClassParameterNode := aGtPillarClassAnnotation children first children
		detect: [ :eachParameter | 
			eachParameter key = aGtPillarClassAnnotation defaultParameterName or: [ 
				eachParameter value isNil ] ] 
		ifNone: [ self inform: 'a'. aGtPillarClassAnnotation ].
	self targetText 
		attributes: {
			BrTextForegroundAttribute paint: Color gray }
		from: aGtPillarClassAnnotation start 
		to: aGtPillarClassAnnotation stop.
	self targetText 
		attributes: {
			BrTextHoverAttribute new 
				beNotOverwritableByStyler;
				textAttribute: (BrTextForegroundAttribute paint: Color blue);
				leaveTextAttribute: (BrTextForegroundAttribute paint: Color gray).
			BrTextClickAttribute new 
				beNotOverwritableByStyler;
				action: [ :aText :aTarget :anEvent | 
					aGtPillarClassAnnotation browseClassFrom: anEvent ] }
		from: aClassParameterNode start 
		to: aClassParameterNode stop.