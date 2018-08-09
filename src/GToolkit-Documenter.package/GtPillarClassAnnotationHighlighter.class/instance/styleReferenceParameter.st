private - styling
styleReferenceParameter
	"Make class name clickable and red if the class does not exist"
	| aClassParameterNode aClassColor theAttributes |
	self isClassDefined 
		ifTrue: [ aClassColor := Color blue muchDarker ]
		ifFalse: [ aClassColor := Color red ].
	aClassParameterNode := self pillarNode children first children
		detect: [ :eachParameter | 
			eachParameter key = self constants nameParameterName ] 
		ifFound: [ :aParameter | aParameter ]
		ifNone: [ self pillarNode ].

	theAttributes := Array with: (BrTextForegroundAttribute new
					paint: aClassColor;	
					beNotOverwritableByStyler).
	self isClassDefined ifTrue: [ 
		theAttributes := theAttributes , {
				BrTextHoverAttribute new 
					beNotOverwritableByStyler;
					removableTextAttribute: (BrTextBackgroundAttribute paint: (Color gray alpha: 0.2)).
				BrTextClickAttribute new 
					beNotOverwritableByStyler;
					action: [ :aText :aTarget :anEvent | 
						self pillarNode browseClassFrom: anEvent ] } ].

	(self targetText 
		from: aClassParameterNode start 
		to: aClassParameterNode stop) 
			attributes: theAttributes.