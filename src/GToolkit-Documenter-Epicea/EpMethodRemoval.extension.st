Extension { #name : #EpMethodRemoval }

{ #category : #'*GToolkit-Documenter-Epicea' }
EpMethodRemoval >> xdEquals: anEpEvent [
	^ (super xdEquals: anEpEvent) and: [ 
		self methodRemoved = anEpEvent methodRemoved ]
]
