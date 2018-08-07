pillar
booleanValueOf: aString in: aDictionary emptyValue: emptyBooleanOrBlock defaultValue: defaultBooleanOrBlock
	^ self 
		valueOf: aString
		in: aDictionary
		value: [ :aValue | self convertToBoolean: aValue ]
		emptyValue: emptyBooleanOrBlock
		defaultValue: defaultBooleanOrBlock