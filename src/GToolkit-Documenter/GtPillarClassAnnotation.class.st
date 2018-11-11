Class {
	#name : #GtPillarClassAnnotation,
	#superclass : #PRAbstractAnnotation,
	#traits : 'GtDocumenterConstantsTrait + GtAssertingTrait',
	#classTraits : 'GtDocumenterConstantsTrait classTrait + GtAssertingTrait classTrait',
	#category : #'GToolkit-Documenter-Pillar - Nodes'
}

{ #category : #protected }
GtPillarClassAnnotation class >> possibleParameters [
	^ {
		self constants nameParameterName.
		self constants expandedViewParameterName
		}
]

{ #category : #protected }
GtPillarClassAnnotation class >> tag [
	^ self constants classTag
]

{ #category : #visitor }
GtPillarClassAnnotation >> accept: aVisitor [
	^ aVisitor visitPillarClassAnnotation: self
]

{ #category : #'menu messages' }
GtPillarClassAnnotation >> browseClassFrom: anEvent [
	| aClassName aClass |
	aClassName := GtDocumenterUtility 
		valueOf: self constants nameParameterName 
		in: self parameters 
		value: [ :aValue | aValue asSymbol ] 
		emptyValue: [ ^ self inform: 'Missing class name' ] 
		defaultValue: [ ^ self inform: 'Missing class name' ].
	aClass := self class environment at: aClassName ifAbsent: [ ^ self inform: 'Class does not exist' ].
	anEvent target fireEvent: (GLMBlocObjectToSelect new toSelect: aClass).
	anEvent target fireEvent: (GtPhlowObjectToSpawn new 
		object: aClass;
		sourceElement: anEvent target)
]

{ #category : #'accessing - parameter values' }
GtPillarClassAnnotation >> expandedViewParameterValue [
	^ GtDocumenterUtility
		booleanValueOf: self constants expandedViewParameterName 
		in: self parameters 
		emptyValue: [ false ] 
		defaultValue: [ false ]
]
