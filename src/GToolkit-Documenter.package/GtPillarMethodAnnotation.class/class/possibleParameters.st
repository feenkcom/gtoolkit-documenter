protected
possibleParameters
	^ {
		self constants referencedMethodParameterName.
		self constants expandedViewParameterName 
		}