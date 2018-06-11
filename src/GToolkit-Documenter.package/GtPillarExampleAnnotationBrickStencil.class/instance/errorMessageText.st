instance creation
errorMessageText
	<return: #BrRopedText>

	self annotation isMethodClassDefined ifFalse: [ 
		^ ('Example class (', self annotation methodClassName , ') is not defined (yet).') asRopedText ].

	self annotation isMethodDefined ifFalse: [ 
		^ ('Example method (', self annotation methodSelectorName , ') is not defined (yet).') asRopedText ].

	^ ('Something wrong with ', self annotation methodName) asRopedText