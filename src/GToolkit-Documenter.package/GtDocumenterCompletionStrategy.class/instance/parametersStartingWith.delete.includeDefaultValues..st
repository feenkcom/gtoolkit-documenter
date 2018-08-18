private-annotations
parametersStartingWith: aString delete: anInteger includeDefaultValues: aBoolean
	self annotationClass
		ifNotNil: [ :class | 
			^ ((class possibleParameters select: [ :each | aString isEmpty or: [ each beginsWith: aString ] ])
				collect: [ :each | 
					self
						complete: each , '='
						with: (each allButFirst: aString size) , '='
						deleting: anInteger
						at: position
						prefixSize: aString size ])
				,
					(aBoolean
						ifTrue: [ self defaultParameterValueActionsFor: class startingWith: aString ]
						ifFalse: [ #() ]) ].
	^ #()