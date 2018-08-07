pillar
convertToBoolean: aStringOrBoolean 
	<return: #Boolean or: nil>
	| aValue |
	aStringOrBoolean = true ifTrue: [ ^ aStringOrBoolean ].
	aStringOrBoolean = false ifTrue: [ ^ aStringOrBoolean ].
	aValue := aStringOrBoolean asString asLowercase trimBoth.
	aValue = 'true' ifTrue: [ ^ true ].
	aValue = 'false' ifTrue: [ ^ false ].
	^ nil