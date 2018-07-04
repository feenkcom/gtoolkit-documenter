visiting
visitPillarClassAnnotation: aGtPillarClassAnnotation 
	| aClassParameterNode aClassColor |
	aClassColor := Color blue muchDarker.
	aClassParameterNode := aGtPillarClassAnnotation children first children
		detect: [ :eachParameter | 
			eachParameter key = aGtPillarClassAnnotation defaultParameterName or: [ 
				eachParameter value isNil ] ] 
		ifFound: [ :aParameter | 
			self document class environment 
				at: aParameter value asSymbol
				ifPresent: [ :aClass | "do nothing" ]
				ifAbsent: [ aClassColor := Color red ].
			aParameter ]
		ifNone: [ aGtPillarClassAnnotation ].
	self targetText 
		attributes: {
			BrTextForegroundAttribute paint: Color gray }
		from: aGtPillarClassAnnotation start 
		to: aGtPillarClassAnnotation stop.
	self targetText 
		attributes: {
			BrTextForegroundAttribute new
				paint: aClassColor;	
				beNotOverwritableByStyler.
			BrTextHoverAttribute new 
				beNotOverwritableByStyler;
				textAttribute: (BrTextBackgroundAttribute paint: (Color gray alpha: 0.2));
				leaveTextAttribute: (BrTextBackgroundAttribute paint: Color transparent).
			BrTextClickAttribute new 
				beNotOverwritableByStyler;
				action: [ :aText :aTarget :anEvent | 
					aGtPillarClassAnnotation browseClassFrom: anEvent ] }
		from: aClassParameterNode start 
		to: aClassParameterNode stop.