private - styling
styleReferenceParameter
	"Make class name clickable and red if the class does not exist"
	| aMethodParameterNode aClassColor theAttributes |
	aClassColor := self isMethodDefined 
		ifTrue: [ Color blue muchDarker ]
		ifFalse: [ Color red ].
	aMethodParameterNode := self pillarNode children first children
		detect: [ :eachParameter | 
			eachParameter key = self pillarNode defaultParameterName or: [ 
				eachParameter value isNil ] ] 
		ifFound: [ :aParameter | aParameter ]
		ifNone: [ self pillarNode ].

	theAttributes := Array with: (BrTextForegroundAttribute new
					paint: aClassColor;	
					beNotOverwritableByStyler).
	self isMethodDefined ifTrue: [ 
		theAttributes := theAttributes , {
				BrTextHoverAttribute new 
					beNotOverwritableByStyler;
					textAttribute: (BrTextBackgroundAttribute paint: (Color gray alpha: 0.2));
					leaveTextAttribute: (BrTextBackgroundAttribute paint: Color transparent).
				BrTextClickAttribute new 
					beNotOverwritableByStyler;
					action: [ :aText :aTarget :anEvent | 
						self pillarNode browseMethodFrom: anEvent ] } ].

	(self targetText 
		from: aMethodParameterNode start 
		to: aMethodParameterNode stop) 
			attributes: theAttributes.