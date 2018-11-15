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
Gt2ExamplesAnnotation >> browseIssuesFrom: aWidget [
	| aResult |
	self hasFailuresOrErrors ifFalse: [ ^ self inform: 'There are not issues' ].
	aResult := self cachedExampleGroup numberOfFailuresAndErrors isZero 
		ifTrue: [ self cachedExampleGroup ]
		ifFalse: [ GtExampleGroup withAll: (self cachedExampleGroup 
			select: [ :each | each isFailure or: [ each isError ] ]) ].
	aWidget fireEvent: (GtPhlowObjectToSpawn new 
		object: aResult;
		sourceElement: aWidget)
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
Gt2ExamplesAnnotation >> browseSuccessesFrom: aWidget [
	| aResult |
	self hasSuccesses ifFalse: [ ^ self inform: 'There are no issues' ].
	aResult := self cachedExampleGroup numberOfSuccesses isZero 
		ifTrue: [ self cachedExampleGroup ]
		ifFalse: [ GtExampleGroup withAll: (self cachedExampleGroup 
			select: [ :each | each isSuccess ]) ].
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
				aCachedValue exampleGroup: aNewExampleGroup ] ]
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

{ #category : #'announcement handling' }
Gt2ExamplesAnnotation >> handleClassAddedOrRemovedAnnouncement: aClassAnnouncement [ 
	((self isAffectedByClassChange: aClassAnnouncement classAffected originalName)
		or: [ self isAffectedByPackageChange: aClassAnnouncement packageAffected name ])
				ifFalse: [ ^ self ].
	self rebuildExampleGroup
]

{ #category : #'announcement handling' }
Gt2ExamplesAnnotation >> handleClassRenamedAnnouncement: aClassRenamed [
	((self isAffectedByClassChange: aClassRenamed newName)
		or: [ (self isAffectedByClassChange: aClassRenamed oldName) or: [ 
				 self isAffectedByPackageChange: aClassRenamed packageAffected name ] ])
		ifFalse: [ ^ self ].
	self rebuildExampleGroup
]

{ #category : #'announcement handling' }
Gt2ExamplesAnnotation >> handleClassRepackagedAnnouncement: aClassRepackaged [
	((self isAffectedByPackageChange: aClassRepackaged newPackage name)
		or: [ self isAffectedByPackageChange: aClassRepackaged oldPackage name ])
			ifFalse: [ ^ self ].
	self rebuildExampleGroup
]

{ #category : #'announcement handling' }
Gt2ExamplesAnnotation >> handleMethodAnnouncement: aMethodModified [
	((self 
		isAffectedByMethodChange: aMethodModified selector 
		of: aMethodModified classAffected originalName) or: [ 
			 self isAffectedByPackageChange: aMethodModified methodPackage name ])
				ifFalse: [ ^ self ].
	self rebuildExampleGroup
]

{ #category : #'announcement handling' }
Gt2ExamplesAnnotation >> handlePackageRenamedAnnouncement: aRPackageRenamed [
	((self isAffectedByPackageChange: aRPackageRenamed newName) or: [ 
		self isAffectedByPackageChange: aRPackageRenamed oldName ])
			ifFalse: [ ^ self ].
	self rebuildExampleGroup
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

{ #category : #testing }
Gt2ExamplesAnnotation >> hasResults [
	^ self hasExample and: [ self cachedExampleGroup numberOfResults isZero not ]
]

{ #category : #testing }
Gt2ExamplesAnnotation >> hasSuccesses [
	^ self hasExample and: [ self cachedExampleGroup numberOfSuccesses isZero not ]
]

{ #category : #testing }
Gt2ExamplesAnnotation >> isAffectedByClassChange: aClassName [
	^ (self referencedClasses anySatisfy: [ :eachClass | 
			eachClass name = aClassName ]) or: [ 
			self referencedMethods anySatisfy: [ :eachMethod | 
				eachMethod parentName = aClassName ] ]
]

{ #category : #testing }
Gt2ExamplesAnnotation >> isAffectedByMethodChange: aSelector of: aClassName [
	^ (self referencedMethods anySatisfy: [ :eachMethod | 
				eachMethod parentName = aClassName and: [ eachMethod selector = aSelector ] ])
			or: [ self isAffectedByClassChange: aClassName ]
]

{ #category : #testing }
Gt2ExamplesAnnotation >> isAffectedByPackageChange: aPackageName [
	^ (self referencedPackages anySatisfy: [ :eachPackage | 
			eachPackage name = aPackageName ])
]

{ #category : #testing }
Gt2ExamplesAnnotation >> isPreviewDefined [
	^ self hasExample
]

{ #category : #testing }
Gt2ExamplesAnnotation >> isReferenceDefined [
	^ self hasExample
]

{ #category : #'private - styling' }
Gt2ExamplesAnnotation >> issuesButtonAttribute [
	^ Gt2ButtonAttribute new
		beAppend;
		equality: self constants issuesButtonLabel;
		stencil: (Gt2ButtonStencilBuilder new
			label: self issuesButtonLabel;
			icon: self constants infoButtonIcon;
			action: [ :aWidget | self browseIssuesFrom: aWidget ])
]

{ #category : #'private - styling' }
Gt2ExamplesAnnotation >> issuesButtonLabel [
	<return: #BlRope>
	| anAmount |
	anAmount := self cachedExampleGroup numberOfFailuresAndErrors.
	^ anAmount asString,
		(' issue' asPluralBasedOn: anAmount)
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

{ #category : #'private - actions' }
Gt2ExamplesAnnotation >> rebuildExampleGroup [
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | 
			"hack, preview should update itself"
			aCachedValue preview: nil.
			aCachedValue exampleGroup: nil ]
		ifAbsent: [ "ignore" ].
	self gtDocument styleTextRequest
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

{ #category : #subscriptions }
Gt2ExamplesAnnotation >> registerToSystemChanges [
	self gtDocument
		subscribe: MethodAdded, MethodModified, MethodRemoved
			send: #handleMethodAnnouncement:
			to: self
			for: self gtSubscriber;
		subscribe: ClassAdded, ClassRemoved
			send: #handleClassAddedOrRemovedAnnouncement:
			to: self
			for: self gtSubscriber;
		subscribe: ClassRenamed
			send: #handleClassRenamedAnnouncement:
			to: self
			for: self gtSubscriber;
		subscribe: ClassRepackaged
			send: #handleClassRepackagedAnnouncement:
			to: self
			for: self gtSubscriber;
		subscribe: RPackageRenamed
			send: #handlePackageRenamedAnnouncement:
			to: self
			for: self gtSubscriber;
		subscribe: Gt2DocumentUpdateRequestedAnnouncement
			send: #handleDocumentUpdateRequestedAnnouncement:
			to: self
			for: self gtSubscriber.
]

{ #category : #'private - styling' }
Gt2ExamplesAnnotation >> resultsLabelAttribute [
	| aGroup |
	aGroup := self cachedExampleGroup.
	^ Gt2ExamplesStatusLabelAttribute new
		beAppend;
		total: aGroup numberOfExamples;
		results: aGroup numberOfResults;
		successes: aGroup numberOfSuccesses;
		issues: aGroup numberOfFailuresAndErrors
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
	"self styleSuccessButtonInText: aBlRope.
	self styleIssueButtonInText: aBlRope."
	self styleResultsInText: aBlRope.
	self registerToSystemChanges.
]

{ #category : #'private - styling' }
Gt2ExamplesAnnotation >> styleIssueButtonInText: aBlRope [
	self hasFailuresOrErrors ifFalse: [ ^ self ].
	(aBlRope from: self stop to: self stop) 
		attribute: self issuesButtonAttribute
]

{ #category : #'private - styling' }
Gt2ExamplesAnnotation >> styleLinkInText: aBlRope [
	self hasChildren ifFalse: [ ^ self ].
	self utility styleLinkInText: aBlRope forNode: self withLinkAt: self children first
]

{ #category : #'private - styling' }
Gt2ExamplesAnnotation >> styleResultsInText: aBlRope [
	self hasResults ifFalse: [ ^ self ].
	(aBlRope from: self stop to: self stop) 
		attribute: self resultsLabelAttribute
]

{ #category : #'private - styling' }
Gt2ExamplesAnnotation >> styleRunButtonInText: aBlRope [
	self hasExample ifFalse: [ ^ self ].
	(aBlRope from: self stop to: self stop) 
		attribute: self runButtonAttribute
]

{ #category : #'private - styling' }
Gt2ExamplesAnnotation >> styleSuccessButtonInText: aBlRope [
	self hasSuccesses ifFalse: [ ^ self ].
	(aBlRope from: self stop to: self stop) 
		attribute: self successButtonAttribute
]

{ #category : #'private - styling' }
Gt2ExamplesAnnotation >> successButtonAttribute [
	^ Gt2ButtonAttribute new
		beAppend;
		equality: self constants successButtonLabel;
		stencil: (Gt2ButtonStencilBuilder new
			label: self successButtonLabel;
			icon: self constants infoButtonIcon;
			action: [ :aWidget | self browseSuccessesFrom: aWidget ])
]

{ #category : #'private - styling' }
Gt2ExamplesAnnotation >> successButtonLabel [
	<return: #BlRope>
	| anAmount |
	anAmount := self cachedExampleGroup numberOfSuccesses.
	^ anAmount asString,
		(anAmount = 1 ifTrue: [ ' success' ] ifFalse: [ ' successes' ])
]
