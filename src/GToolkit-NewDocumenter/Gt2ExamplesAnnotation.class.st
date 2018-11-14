Class {
	#name : #Gt2ExamplesAnnotation,
	#superclass : #Gt2Annotation,
	#instVars : [
		'referencedClasses',
		'referencedMethods',
		'referencedPackages',
		'exampleGroup'
	],
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #accessing }
Gt2ExamplesAnnotation class >> possibleParameters [
	^ {
		self constants methodsParameterName.
		self constants classesParameterName.
		self constants packagesParameterName.
		self constants expandedParameterName.
		self constants showParameterName.
		self constants heightParameterName.
		}
]

{ #category : #protected }
Gt2ExamplesAnnotation class >> tag [
	^ self constants examplesAnnotationName
]

{ #category : #'private - cache' }
Gt2ExamplesAnnotation >> annotationCacheValueClass [
	^ Gt2ExamplesAnnotationCacheValue
]

{ #category : #'private - actions' }
Gt2ExamplesAnnotation >> browseReferenceFrom: anEvent [
	anEvent modifiers isShift ifTrue: [ ^ self ].
	self hasExample ifFalse: [ ^ self inform: 'There is no defined example' ].
	anEvent target fireEvent: (GtPhlowObjectToSpawn new 
		object: self cachedExampleGroup;
		sourceElement: anEvent target)
]

{ #category : #'private - actions' }
Gt2ExamplesAnnotation >> browseResultsFrom: aWidget [
	| aResult |
	self hasExample ifFalse: [ ^ self inform: 'There is no defined example' ].
	aResult := self cachedExampleGroup numberOfFailures isZero 
		ifTrue: [ self cachedExampleGroup ]
		ifFalse: [ GtExampleGroup withAll: (self cachedExampleGroup select: [ :each | each isFailure ]) ].
	aWidget fireEvent: (GtPhlowObjectToSpawn new 
		object: aResult;
		sourceElement: aWidget)
]

{ #category : #'private - cache' }
Gt2ExamplesAnnotation >> cachedExampleGroup [
	<return: #GtExampleGroup or: nil>
	| aNewExampleGroup |
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | 
			aNewExampleGroup := aCachedValue exampleGroup.
			aNewExampleGroup ifNil: [ 
				aNewExampleGroup := self newExampleGroup.
				aCachedValue epicea: aNewExampleGroup ] ]
		ifAbsentPut: [ 
			aNewExampleGroup := self newExampleGroup.
			self annotationCacheValueClass new 
				exampleGroup: aNewExampleGroup;
				isExpanded: self expandedParameterValue ].
	^ aNewExampleGroup
]

{ #category : #'accessing - parameter values' }
Gt2ExamplesAnnotation >> defaultShowSelector [
	^ self constants defaultExamplesShowSelector
]

{ #category : #'private - cache' }
Gt2ExamplesAnnotation >> exampleGroup [
	<return: #GtExampleGroup>
	| theMethods theClasses thePackages |
	exampleGroup ifNotNil: [ ^ exampleGroup ].
	theMethods := self referencedMethods flatCollect: [ :eachMethodDef | 
			eachMethodDef isDefined ifTrue: [ eachMethodDef compiledMethod gtExamples ] ifFalse: [ #() ] ].
	theClasses := self referencedClasses flatCollect: [ :eachClassDef | 
			eachClassDef isDefined ifTrue: [ eachClassDef realClass gtExamples ] ifFalse: [ #() ] ].
	thePackages := self referencedPackages flatCollect: [ :eachPackageDef | 
			(RPackageOrganizer default includesPackageNamed: eachPackageDef name) 
				ifTrue: [ eachPackageDef realPackage gtExamplesContained ] ifFalse: [ #() ] ].
	^ exampleGroup := GtExampleGroup withAll: theMethods, theClasses, thePackages
]

{ #category : #testing }
Gt2ExamplesAnnotation >> hasErrors [
	^ self hasExample and: [ self cachedExampleGroup numberOfErrors isZero not ]
]

{ #category : #testing }
Gt2ExamplesAnnotation >> hasExample [
	| aGroup |
	aGroup := self cachedExampleGroup.
	^ aGroup notNil and: [ aGroup examples notEmpty ]
]

{ #category : #testing }
Gt2ExamplesAnnotation >> hasFailures [
	^ self hasExample and: [ self cachedExampleGroup numberOfFailures isZero not ]
]

{ #category : #testing }
Gt2ExamplesAnnotation >> hasFailuresOrErrors [
	^ self hasExample and: [ self cachedExampleGroup numberOfFailuresAndErrors isZero not ]
]

{ #category : #'private - styling' }
Gt2ExamplesAnnotation >> infoButtonAttribute [
	^ Gt2ButtonAttribute new
		beAppend;
		equality: self constants infoButtonLabel;
		stencil: (Gt2ButtonStencilBuilder new
			label: self infoButtonLabel;
			icon: self constants infoButtonIcon;
			action: [ :aWidget | self browseResultsFrom: aWidget ])
]

{ #category : #'private - styling' }
Gt2ExamplesAnnotation >> infoButtonLabel [
	<return: #BlRope>
	| anAmount |
	anAmount := self cachedExampleGroup numberOfFailuresAndErrors.
	^ anAmount asString,
		(' issue' asPluralBasedOn: anAmount)
]

{ #category : #testing }
Gt2ExamplesAnnotation >> isPreviewDefined [
	^ self hasExample
]

{ #category : #testing }
Gt2ExamplesAnnotation >> isReferenceDefined [
	^ self hasExample
]

{ #category : #'private - cache' }
Gt2ExamplesAnnotation >> newExampleGroup [
	<return: #GtExampleGroup>
	| theMethods theClasses thePackages |
	theMethods := self referencedMethods flatCollect: [ :eachMethodDef | 
			eachMethodDef isDefined ifTrue: [ eachMethodDef compiledMethod gtExamples ] ifFalse: [ #() ] ].
	theClasses := self referencedClasses flatCollect: [ :eachClassDef | 
			eachClassDef isDefined ifTrue: [ eachClassDef realClass gtExamples ] ifFalse: [ #() ] ].
	thePackages := self referencedPackages flatCollect: [ :eachPackageDef | 
			(RPackageOrganizer default includesPackageNamed: eachPackageDef name) 
				ifTrue: [ eachPackageDef realPackage gtExamplesContained ] ifFalse: [ #() ] ].
	^ GtExampleGroup withAll: theMethods, theClasses, thePackages
]

{ #category : #accessing }
Gt2ExamplesAnnotation >> objectToPreview [
	^ self cachedExampleGroup
]

{ #category : #'accessing - parameter values' }
Gt2ExamplesAnnotation >> referencedClasses [
	<return: #Array of: #RGClassDefinition>
	^ referencedClasses ifNil: [ 
			referencedClasses := self utility 
				valueOf: self constants classesParameterName 
				in: self parameters 
				value: [ :aValue | 
					aValue isArray ifFalse: [ #() ].
					self utility classDefinitionsFromArray: aValue ] 
				emptyValue: [ #() ]
				defaultValue: [ #() ] ]
]

{ #category : #'accessing - parameter values' }
Gt2ExamplesAnnotation >> referencedMethods [
	<return: #Array of: #RGMethodDefinition>
	^ referencedMethods ifNil: [ 
			referencedMethods := self utility 
				valueOf: self constants methodsParameterName 
				in: self parameters 
				value: [ :aValue | 
					aValue isArray ifFalse: [ #() ].
					self utility methodDefinitionsFromArray: aValue ] 
				emptyValue: [ #() ]
				defaultValue: [ #() ] ]
]

{ #category : #'accessing - parameter values' }
Gt2ExamplesAnnotation >> referencedPackages [
	<return: #Array of: #RGPackage>
	^ referencedPackages ifNil: [ 
			referencedPackages := self utility 
				valueOf: self constants packagesParameterName 
				in: self parameters 
				value: [ :aValue | 
					aValue isArray ifFalse: [ #() ].
					self utility packageDefinitionsFromArray: aValue ] 
				emptyValue: [ #() ]
				defaultValue: [ #() ] ]
]

{ #category : #'private - styling' }
Gt2ExamplesAnnotation >> runButtonAttribute [
	^ Gt2ButtonAttribute new
		beAppend;
		equality: self constants runButtonLabel;
		stencil: (Gt2ButtonStencilBuilder new
			label: self runButtonLabel;
			icon: self constants runButtonIcon;
			action: [ self runExamples ])
]

{ #category : #'private - styling' }
Gt2ExamplesAnnotation >> runButtonLabel [
	<return: #BlRope>
	| anAmount |
	anAmount := self cachedExampleGroup numberOfExamples.
	^ self constants runButtonLabel, ' ',
		anAmount asString, (' example' asPluralBasedOn: anAmount)
]

{ #category : #'private - actions' }
Gt2ExamplesAnnotation >> runExamples [
	self cachedExampleGroup runAll.
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | 
			"hack, preview should update itself"
			aCachedValue preview: nil ]
		ifAbsent: [ "ignore" ].
	self gtDocument styleTextRequest
]

{ #category : #'api - style' }
Gt2ExamplesAnnotation >> styleInText: aBlRope [
	super styleInText: aBlRope.
	self styleLinkInText: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
	self styleRunButtonInText: aBlRope.
	self styleInfoButtonInText: aBlRope.
]

{ #category : #'private - styling' }
Gt2ExamplesAnnotation >> styleInfoButtonInText: aBlRope [
	self hasFailuresOrErrors ifFalse: [ ^ self ].
	(aBlRope from: self stop to: self stop) 
		attribute: self infoButtonAttribute
]

{ #category : #'private - styling' }
Gt2ExamplesAnnotation >> styleRunButtonInText: aBlRope [
	self hasExample ifFalse: [ ^ self ].
	(aBlRope from: self stop to: self stop) 
		attribute: self runButtonAttribute
]
