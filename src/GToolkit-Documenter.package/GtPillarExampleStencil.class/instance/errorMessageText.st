instance creation
errorMessageText
	<return: #BlRopedText>

	self documentPart isMethodClassDefined ifFalse: [ 
		^ ('Example class (', self documentPart methodClassName , ') is not defined (yet).') asRopedText ].

	self documentPart isMethodDefined ifFalse: [ 
		^ ('Example method (', self documentPart methodName asString, ') is not defined (yet).') asRopedText ].

	^ ('Something wrong with ', self documentPart methodName) asRopedText