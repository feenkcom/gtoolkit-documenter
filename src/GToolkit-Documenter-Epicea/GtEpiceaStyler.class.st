Class {
	#name : #GtEpiceaStyler,
	#superclass : #BrRBTextStyler,
	#category : #'GToolkit-Documenter-Epicea'
}

{ #category : #private }
GtEpiceaStyler >> resolveStyleFor: aVariableNode [
	aVariableNode binding ifNil: [^#default].
	aVariableNode isArg ifTrue: [ ^#methodArg].
	aVariableNode isTemp ifTrue: [ ^#tempVar].
	aVariableNode isGlobal ifTrue: [ ^#globalVar].
	aVariableNode isInstance ifTrue: [ ^#instVar]. 
	^#globalVar.
]
