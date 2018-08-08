private - styling
styleReferenceParameter
	"Make class name clickable and red if the class does not exist"
	| aClassParameterNode aClassColor |
	aClassColor := referencedMethod 
		ifNotNil: [ Color blue muchDarker ]
		ifNil: [ Color red ].
	aClassParameterNode := self pillarNode children first children
		detect: [ :eachParameter | 
			eachParameter key = self pillarNode defaultParameterName or: [ 
				eachParameter value isNil ] ] 
		ifFound: [ :aParameter | aParameter ]
		ifNone: [ self pillarNode ].

	(self targetText 
		from: aClassParameterNode start 
		to: aClassParameterNode stop)
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
						self pillarNode browseMethodFrom: anEvent ] }