"
An embedded GT-Example script.
I allow a script that has only parameters (there is no a script in the body), e.g.,

[[[example=GtPillarExampleScript class >># basicExample|height=400|expanded=true|show=gtPrintIn:]]]

"
Class {
	#name : #GtOldPillarExampleCodeblock,
	#superclass : #GtOldPillarCodeblock,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #visitor }
GtOldPillarExampleCodeblock >> accept: aVisitor [
	^ aVisitor visitGtPillarExampleCodeblock: self
]

{ #category : #accessing }
GtOldPillarExampleCodeblock >> example [
	^ self tokens exampleParameterValue
]

{ #category : #accessing }
GtOldPillarExampleCodeblock >> exampleCompiledMethod [
	<return: #CompiledMethod or: nil>
	^ self exampleMethodDefinition compiledMethod
]

{ #category : #accessing }
GtOldPillarExampleCodeblock >> exampleMethodDefinition [
	<return: #RGMethodDefinition>
	^ GtSystemUtility methodDefinitionFromString: self example
]

{ #category : #accessing }
GtOldPillarExampleCodeblock >> exampleSourceCode [
	| methodDefinition |
	methodDefinition := self exampleMethodDefinition.
	methodDefinition isDefined ifFalse: [ ^ methodDefinition printString ].
	^ String streamContents: [ :aStream | 
		aStream nextPutAll: methodDefinition methodClass name.
		aStream nextPutAll: ' >> '.
		aStream nextPutAll: methodDefinition sourceCode ].
]

{ #category : #testing }
GtOldPillarExampleCodeblock >> hasText [
	"Answer where the example also includes a script in the main body.
	Usually, it should be empty as the source code is in a given example method defined by 'example' parameter."
	^ text isEmptyOrNil not
]

{ #category : #accessing }
GtOldPillarExampleCodeblock >> height [
	^ self parameters 
		at: 'height'
		ifPresent: [ :aString | Number readFromString: aString ] 
		ifAbsent: [ nil ]
]

{ #category : #'accessing-delegated' }
GtOldPillarExampleCodeblock >> language [
	super language
		isSpecified ifFalse: [ ^ PRSmalltalkScriptLanguage default ].
	^ super language
]

{ #category : #accessing }
GtOldPillarExampleCodeblock >> shouldDisplayCode [
	^ self tokens shouldDisplayCode
]

{ #category : #accessing }
GtOldPillarExampleCodeblock >> show [
	^ self tokens showParameterValue
]

{ #category : #accessing }
GtOldPillarExampleCodeblock >> text [
	"Return script body. For examples it should be nil by default. 
	For that reasone we return an example source code"
	<return: #String or: nil>
	^ super text isEmptyOrNil 
		ifTrue: [ self exampleSourceCode ifNil: [ '' ] ]
		ifFalse: [ super text ]
]
