accessing
possibleParameters
	^ {self constants methodsParameterName.
		self constants classesParameterName.
		self constants packagesParameterName.
		self constants showParameterName}