private-annotations
annotationParameterActionsFor: parameterString startAt: parameterStart
	self parameterRegex
		matchesIn: parameterString
		subexpressionsDo: [ :str :parts | 
			| name value nameWithoutEquals hasEquals |
			name := parts first.
			value := parts last.
			name isNil
				ifTrue: [ name := value.
					value := '' ].
			nameWithoutEquals := name copyWithout: $=.
			hasEquals := name ~= nameWithoutEquals.
			^ (position between: parameterStart and: parameterStart + nameWithoutEquals size - 1)
				ifTrue: [ self
						parametersStartingWith: (name first: position - parameterStart + 1)
						delete:
							(hasEquals
								ifTrue: [ parameterStart + nameWithoutEquals size - position ]
								ifFalse: [ 0 ])
						includeDefaultValues: hasEquals not ]
				ifFalse: [ self
						parameterValueActionsForClass: self annotationClass
						name: nameWithoutEquals
						startingWith: (value first: position - (parameterStart + name size - 1)) ] ].
	^ #()