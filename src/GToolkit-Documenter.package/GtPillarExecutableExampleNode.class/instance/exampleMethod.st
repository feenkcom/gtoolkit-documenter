accessing
exampleMethod
	<return: #CompiledMethod or: nil>
	^ self isMethodDefined
		ifTrue: [ self methodDefinition compiledMethod ] 
		ifFalse: [ nil ]