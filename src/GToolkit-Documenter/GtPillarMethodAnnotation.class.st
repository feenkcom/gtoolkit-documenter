Class {
	#name : #GtPillarMethodAnnotation,
	#superclass : #PRAbstractAnnotation,
	#traits : 'GtDocumenterConstantsTrait + GtAssertingTrait',
	#classTraits : 'GtDocumenterConstantsTrait classTrait + GtAssertingTrait classTrait',
	#category : 'GToolkit-Documenter-Pillar - Nodes'
}

{ #category : #protected }
GtPillarMethodAnnotation class >> possibleParameters [
	^ {
		self constants nameParameterName.
		self constants expandedViewParameterName 
		}
]

{ #category : #protected }
GtPillarMethodAnnotation class >> tag [
	^ #method
]

{ #category : #visitor }
GtPillarMethodAnnotation >> accept: aVisitor [
	^ aVisitor visitPillarMethodAnnotation: self
]

{ #category : #actions }
GtPillarMethodAnnotation >> browseMethodFrom: anEvent [
	| aMethodName aMethod |
	aMethodName := GtDocumenterUtility 
		valueOf: self constants nameParameterName 
		in: self parameters 
		value: [ :aValue | aValue ] 
		emptyValue: [ ^ self inform: 'Missing method name' ] 
		defaultValue: [ ^ self inform: 'Missing method name' ].
	aMethod := GtSystemUtility methodDefinitionFromString: aMethodName.
	aMethod isDefined ifFalse: [ ^ self inform: 'Method is not defined' ].
	anEvent target fireEvent: (GLMBlocObjectToSelect new toSelect: aMethod).
	anEvent target fireEvent: (GtPhlowObjectToSpawn new 
		object: self;
		sourceElement: anEvent target)
]

{ #category : #'accessing - parameter values' }
GtPillarMethodAnnotation >> expandedViewParameterValue [
	^ GtDocumenterUtility
		booleanValueOf: self constants expandedViewParameterName 
		in: self parameters 
		emptyValue: [ false ] 
		defaultValue: [ false ]
]
