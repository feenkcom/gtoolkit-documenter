instance creation
errorMessageText
	<return: #BrRopedText>

	self documentPart isMethodClassDefined ifFalse: [ 
		^ ('Example class (', self documentPart methodClassName , ') is not defined (yet).') asRopedText ].

	self documentPart isMethodDefined ifFalse: [ 
		^ ('Example method (', self documentPart methodSelectorName , ') is not defined (yet).') asRopedText ].

	^ ('Something wrong with ', self documentPart methodName) asRopedText