Extension { #name : #EpMethodModification }

{ #category : #'*GToolkit-Documenter-Epicea' }
EpMethodModification >> xdEquals: anEpEvent [
	^ (super xdEquals: anEpEvent) and: [ 
		self newMethod = anEpEvent newMethod and: [ 
			self oldMethod = anEpEvent oldMethod ] ]
]
