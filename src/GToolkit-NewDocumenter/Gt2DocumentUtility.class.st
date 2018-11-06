Class {
	#name : #Gt2DocumentUtility,
	#superclass : #Object,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#category : #'GToolkit-NewDocumenter-Utility'
}

{ #category : #'pillar - parameter values' }
Gt2DocumentUtility class >> booleanValueOf: aString in: aDictionary emptyValue: emptyBooleanOrBlock defaultValue: defaultBooleanOrBlock [
	^ self 
		valueOf: aString
		in: aDictionary
		value: [ :aValue | (self convertToBoolean: aValue) ifNil: emptyBooleanOrBlock ]
		emptyValue: emptyBooleanOrBlock
		defaultValue: defaultBooleanOrBlock
]

{ #category : #'pillar - parameter values' }
Gt2DocumentUtility class >> convertToBoolean: aStringOrBoolean [ 
	<return: #Boolean or: nil>
	| aValue |
	aStringOrBoolean = true ifTrue: [ ^ aStringOrBoolean ].
	aStringOrBoolean = false ifTrue: [ ^ aStringOrBoolean ].
	aValue := aStringOrBoolean asString asLowercase trimBoth.
	aValue = 'true' ifTrue: [ ^ true ].
	aValue = 'false' ifTrue: [ ^ false ].
	^ nil
]

{ #category : #'api - text style' }
Gt2DocumentUtility class >> linkColor: aBoolean [
	"aBoolean = true means that a link is valid.
	aBoolean = false means that a link is invalid."
	^ aBoolean 
		ifTrue: [ self constants linkColor ]
		ifFalse: [ self constants linkWithErrorColor ].
]

{ #category : #'api - text style' }
Gt2DocumentUtility class >> parameterNodeNamed: aParameterName forAnnotation: anAnnotation [
	"Return annotation's parameter AST node if exists.
	Return the given annotation otherwise"
	<return: #PRParameter or: #PRAbstractAnnotation>
	^ anAnnotation children first children
		detect: [ :eachParameter | 
			eachParameter key = aParameterName or: [ 
				eachParameter value isNil ] ] 
		ifFound: [ :aParameter | aParameter ]
		ifNone: [ anAnnotation ].
]

{ #category : #'pillar - parameter values' }
Gt2DocumentUtility class >> valueOf: aString in: aDictionary value: aValueBlock emptyValue: anEmptyBlock defaultValue: aDefaultBlock [
	^ aDictionary
		at: aString
		ifPresent: [ :aValue | 
			(aValue isNil or: [ aValue = '' ])
				ifTrue: [ anEmptyBlock cull: aValue ] 
				ifFalse: [ aValueBlock cull: aValue ] ]
		ifAbsent: [ aDefaultBlock value ]
]
