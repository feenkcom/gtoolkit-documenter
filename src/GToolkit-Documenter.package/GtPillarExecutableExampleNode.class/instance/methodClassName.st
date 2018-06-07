accessing
methodClassName
	<return: #String or: nil>
	^ self methodDefinition ifNotNil: [ :aMethodDefinition | aMethodDefinition parent name ]