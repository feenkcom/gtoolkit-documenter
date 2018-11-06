Class {
	#name : #Gt2Annotation,
	#superclass : #PRAbstractAnnotation,
	#traits : 'TBlDebug + TGt2DocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait',
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #testing }
Gt2Annotation class >> isAbstract [
	^ self name = #Gt2Annotation 
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> expandedDefaultValue [
	^ false
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> expandedEmptyValue [
	^ false
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> expandedParameterValue [
	^ Gt2DocumentUtility
		booleanValueOf: self constants expandedParameterName 
		in: self parameters 
		emptyValue: [ self expandedEmptyValue ] 
		defaultValue: [ self expandedDefaultValue ]
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> showDefaultValue [
	^ self constants showDefaultValue
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> showEmptyValue [
	^ self constants showDefaultValue
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> showParameterValue [
	<return: #Symbol>
	^ Gt2DocumentUtility 
		valueOf: self constants showParameterName
		in: self parameters
		value: [ :aString | aString isString 
			ifFalse: [ self showEmptyValue ] 
			ifTrue: [ aString asSymbol ] ]
		emptyValue: [ self showEmptyValue ]
		defaultValue: [ self showDefaultValue ]
]

{ #category : #'api - style' }
Gt2Annotation >> styleInText: aBlRope [
	"Subclasses can add another styling"
	(aBlRope 
			from: self start 
			to: self stop)
				foreground: self constants subtleColor.
]
