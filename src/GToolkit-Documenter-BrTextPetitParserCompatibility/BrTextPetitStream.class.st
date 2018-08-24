Class {
	#name : #BrTextPetitStream,
	#superclass : #PPStream,
	#category : 'GToolkit-Documenter-BrTextPetitParserCompatibility'
}

{ #category : #accessing }
BrTextPetitStream >> next: anInteger [
	^ (super next: anInteger) asString
]

{ #category : #accessing }
BrTextPetitStream >> peek [
	^ super peek asString
]
