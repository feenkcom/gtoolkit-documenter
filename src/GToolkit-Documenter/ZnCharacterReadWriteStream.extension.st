Extension { #name : #ZnCharacterReadWriteStream }

{ #category : #'*GToolkit-Documenter' }
ZnCharacterReadWriteStream >> print: object [
	object printOn: self
]

{ #category : #'*GToolkit-Documenter' }
ZnCharacterReadWriteStream >> tab [
	self nextPut: Character tab
]
