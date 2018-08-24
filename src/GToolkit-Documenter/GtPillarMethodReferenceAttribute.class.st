Class {
	#name : #GtPillarMethodReferenceAttribute,
	#superclass : #GtPillarPharoTextEditorAttribute,
	#instVars : [
		'methodReference'
	],
	#category : 'GToolkit-Documenter-Brick'
}

{ #category : #initialization }
GtPillarMethodReferenceAttribute >> initialize [
	super initialize.
	methodReference := (self class >> #initialize) asRingDefinition.
]

{ #category : #accessing }
GtPillarMethodReferenceAttribute >> methodReference [
	^ methodReference
]

{ #category : #accessing }
GtPillarMethodReferenceAttribute >> methodReference: aMethod [
	methodReference := aMethod asRingDefinition
]

{ #category : #'instance creation' }
GtPillarMethodReferenceAttribute >> newStyler [
	^ BrRBTextStyler new 
			classOrMetaClass: self methodReference methodClass
]

{ #category : #accessing }
GtPillarMethodReferenceAttribute >> textEditorText [
	<return: #BlText>
	^ self methodReference sourceCode asRopedText
]
