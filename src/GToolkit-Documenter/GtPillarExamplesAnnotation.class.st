Class {
	#name : #GtPillarExamplesAnnotation,
	#superclass : #PRAbstractAnnotation,
	#traits : 'GtDocumenterConstantsTrait + GtAssertingTrait',
	#classTraits : 'GtDocumenterConstantsTrait classTrait + GtAssertingTrait classTrait',
	#category : #'GToolkit-Documenter-Pillar - Nodes'
}

{ #category : #accessing }
GtPillarExamplesAnnotation class >> possibleParameters [
	^ {self constants methodsParameterName.
		self constants classesParameterName.
		self constants packagesParameterName.
		self constants showParameterName}
]

{ #category : #protected }
GtPillarExamplesAnnotation class >> tag [
	^ self constants examplesTag
]

{ #category : #visiting }
GtPillarExamplesAnnotation >> accept: aVisitor [
	^ aVisitor visitGtPillarExamplesAnnotation: self
]

{ #category : #'accessing - parameter values' }
GtPillarExamplesAnnotation >> classesParameterValue [
	^ GtDocumenterUtility 
		valueOf: self constants classesParameterName 
		in: self parameters 
		value: [ :aValue | 
			self assert: aValue isArray.
			GtDocumenterUtility classDefinitionsFromArray: aValue ] 
		emptyValue: [ #() ]
		defaultValue: [ #() ]
]

{ #category : #accessing }
GtPillarExamplesAnnotation >> exampleGroup [
	| theMethods theClasses thePackages |
	theMethods := self methodsParameterValue flatCollect: [ :eachMethodDef | 
			eachMethodDef isDefined ifTrue: [ eachMethodDef compiledMethod gtExamples ] ifFalse: [ #() ] ].
	theClasses := self classesParameterValue flatCollect: [ :eachClassDef | 
			eachClassDef isDefined ifTrue: [ eachClassDef realClass gtExamples ] ifFalse: [ #() ] ].
	thePackages := self packagesParameterValue flatCollect: [ :eachPackageDef | 
			(RPackageOrganizer default includesPackageNamed: eachPackageDef name) 
				ifTrue: [ eachPackageDef realPackage gtExamplesContained ] ifFalse: [ #() ] ].
	^ GtExampleGroup new examples: theMethods, theClasses, thePackages
]

{ #category : #testing }
GtPillarExamplesAnnotation >> hasExamples [
	^ self exampleGroup size isZero not
]

{ #category : #'accessing - parameter values' }
GtPillarExamplesAnnotation >> methodsParameterValue [
	^ GtDocumenterUtility 
		valueOf: self constants methodsParameterName 
		in: self parameters 
		value: [ :aValue | 
			self assert: aValue isArray.
			GtDocumenterUtility methodDefinitionsFromArray: aValue ] 
		emptyValue: [ #() ]
		defaultValue: [ #() ]
]

{ #category : #'accessing - parameter values' }
GtPillarExamplesAnnotation >> packagesParameterValue [
	^ GtDocumenterUtility 
		valueOf: self constants packagesParameterName 
		in: self parameters 
		value: [ :aValue | 
			self assert: aValue isArray.
			GtDocumenterUtility packageDefinitionsFromArray: aValue ] 
		emptyValue: [ #() ]
		defaultValue: [ #() ]
]

{ #category : #'accessing - parameter values' }
GtPillarExamplesAnnotation >> showParameterValue [
	<return: #Symbol>
	^ GtDocumenterUtility 
		valueOf: self constants showParameterName
		in: self parameters
		value: [ :aString | aString asSymbol ]
		emptyValue: [ self constants defaultShowExamplesMethodName ]
		defaultValue: [ self constants defaultShowExamplesMethodName ]
]
