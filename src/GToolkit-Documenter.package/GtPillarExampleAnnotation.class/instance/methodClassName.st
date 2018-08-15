accessing
methodClassName
	<return: #String>
	^ self methodDefinition 
		ifNotNil: [ :aMethodDefinition | aMethodDefinition parent name ]
		ifNil: [ 'undefined' ]