Extension { #name : #EpClassAddition }

{ #category : #'*GToolkit-Documenter-Epicea' }
EpClassAddition >> xdEquals: anEpEvent [
	^ (super xdEquals: anEpEvent) and: [ 
		self classAdded = anEpEvent classAdded ]
]
