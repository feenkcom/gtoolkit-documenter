accessing
possibleParameters
	^ {#name.
		self constants showParameterName.
		self constants expandedViewParameterName.
		self constants expandedPreviewParemeterName.
		#noCode}