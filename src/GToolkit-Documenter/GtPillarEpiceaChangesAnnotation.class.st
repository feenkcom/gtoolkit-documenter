Class {
	#name : #GtPillarEpiceaChangesAnnotation,
	#superclass : #PRAbstractAnnotation,
	#traits : 'GtDocumenterConstantsTrait + GtAssertingTrait',
	#classTraits : 'GtDocumenterConstantsTrait classTrait + GtAssertingTrait classTrait',
	#category : #'GToolkit-Documenter-Pillar - Nodes'
}

{ #category : #accessing }
GtPillarEpiceaChangesAnnotation class >> possibleParameters [
	^ { self constants fileParameterName }
]

{ #category : #protected }
GtPillarEpiceaChangesAnnotation class >> tag [
	^ self constants changesTag
]

{ #category : #visitor }
GtPillarEpiceaChangesAnnotation >> accept: aVisitor [
	^ aVisitor visitGtPillarEpiceaChangesAnnotation: self
]

{ #category : #'accessing - parameters' }
GtPillarEpiceaChangesAnnotation >> methodName [
	<return: #String or: nil>
	^ GtDocumenterUtility 
		valueOf: self constants fileParameterName
		in: self parameters
		value: [ :aString | aString ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]
]

{ #category : #'accessing - parameters' }
GtPillarEpiceaChangesAnnotation >> showParameterValue [
	<return: #Symbol>
	^ GtDocumenterUtility 
		valueOf: self constants showParameterName
		in: self parameters
		value: [ :selector | selector asSymbol ]
		emptyValue: [ self constants defaultShowMethodName ]
		defaultValue: [ self constants defaultShowMethodName ]
]
