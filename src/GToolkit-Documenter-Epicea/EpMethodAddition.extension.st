Extension { #name : #EpMethodAddition }

{ #category : #'*GToolkit-Documenter-Epicea' }
EpMethodAddition >> xdEquals: anEpEvent [
	^ (super xdEquals: anEpEvent) and: [ 
		self methodAdded = anEpEvent methodAdded ]
]
