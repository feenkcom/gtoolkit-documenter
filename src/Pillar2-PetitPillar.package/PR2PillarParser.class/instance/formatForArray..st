grammar - Format
formatForArray: array
	^ (array first addAll: (array second collect: [ :each | each second ]))
		start: array first start;
		stop: array third stop