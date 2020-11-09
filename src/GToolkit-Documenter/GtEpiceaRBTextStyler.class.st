Class {
	#name : #GtEpiceaRBTextStyler,
	#superclass : #BrRBTextStyler,
	#category : #'GToolkit-Documenter-Epicea'
}

{ #category : #private }
GtEpiceaRBTextStyler >> resolveStyleFor: aVariableNode [
	| value |
	value := super resolveStyleFor: aVariableNode.
	^ value = #invalid
		ifTrue: [ #default ]
		ifFalse: [ value ]
]
