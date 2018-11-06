Class {
	#name : #Gt2DocumentUtility,
	#superclass : #Object,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#category : #'GToolkit-NewDocumenter-Utility'
}

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
