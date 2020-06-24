Class {
	#name : #GtExamplesAnnotation,
	#superclass : #GtAnnotation,
	#instVars : [
		'referencedClasses',
		'referencedMethods',
		'referencedPackages',
		'exampleGroup'
	],
	#category : #'GToolkit-Documenter-Annotations'
}

{ #category : #accessing }
GtExamplesAnnotation class >> possibleParameters [
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
GtExamplesAnnotation class >> tag [
	^ self constants examplesAnnotationName
]

{ #category : #visiting }
GtExamplesAnnotation >> accept: aVisitor [
	^ aVisitor visitGt2ExamplesAnnotation: self
]

{ #category : #accessing }
GtExamplesAnnotation >> allExamples [ 
	<return: #Array of: #GtExampleResult >
	^ self exampleGroup examples
]

{ #category : #'private - cache' }
GtExamplesAnnotation >> annotationCacheValueClass [
	^ GtExamplesAnnotationCacheValue
]

{ #category : #'private - actions' }
GtExamplesAnnotation >> browseReferenceFrom: anEvent [
	anEvent modifiers isShift ifTrue: [ ^ self ].
	self hasExample ifFalse: [ ^ self inform: 'There is no defined example' ].
	anEvent target phlow spawnObject: self cachedExampleGroup
]

{ #category : #'private - cache' }
GtExamplesAnnotation >> cachedExampleGroup [
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
GtExamplesAnnotation >> defaultShowSelector [
	^ self constants defaultExamplesShowSelector
]

{ #category : #testing }
GtExamplesAnnotation >> doesReferenceExist [
	^ self hasExample
]

{ #category : #'private - cache' }
GtExamplesAnnotation >> exampleGroup [
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
GtExamplesAnnotation >> handleClassAddedOrRemovedAnnouncement: aClassAnnouncement [ 
	((self isAffectedByClassChange: aClassAnnouncement classAffected originalName)
		or: [ self isAffectedByPackageChange: aClassAnnouncement packageAffected name ])
				ifFalse: [ ^ self ].
	self rebuildExampleGroup
]

{ #category : #'announcement handling' }
GtExamplesAnnotation >> handleClassRenamedAnnouncement: aClassRenamed [
	((self isAffectedByClassChange: aClassRenamed newName)
		or: [ (self isAffectedByClassChange: aClassRenamed oldName) or: [ 
				 self isAffectedByPackageChange: aClassRenamed packageAffected name ] ])
		ifFalse: [ ^ self ].
	self rebuildExampleGroup
]

{ #category : #'announcement handling' }
GtExamplesAnnotation >> handleClassRepackagedAnnouncement: aClassRepackaged [
	((self isAffectedByPackageChange: aClassRepackaged newPackage name)
		or: [ self isAffectedByPackageChange: aClassRepackaged oldPackage name ])
			ifFalse: [ ^ self ].
	self rebuildExampleGroup
]

{ #category : #'announcement handling' }
GtExamplesAnnotation >> handleMethodAnnouncement: aMethodModified [
	((self 
		isAffectedByMethodChange: aMethodModified selector 
		of: aMethodModified classAffected originalName) or: [ 
			aMethodModified methodPackage notNil and: [ 
				self isAffectedByPackageChange: aMethodModified methodPackage name ] ])
					ifFalse: [ ^ self ].
	self rebuildExampleGroup
]

{ #category : #'announcement handling' }
GtExamplesAnnotation >> handlePackageRenamedAnnouncement: aRPackageRenamed [
	((self isAffectedByPackageChange: aRPackageRenamed newName) or: [ 
		self isAffectedByPackageChange: aRPackageRenamed oldName ])
			ifFalse: [ ^ self ].
	self rebuildExampleGroup
]

{ #category : #testing }
GtExamplesAnnotation >> hasErrors [
	^ self hasExample and: [ self cachedExampleGroup numberOfErrors isZero not ]
]

{ #category : #testing }
GtExamplesAnnotation >> hasExample [
	| aGroup |
	aGroup := self cachedExampleGroup.
	^ aGroup notNil and: [ aGroup examples notEmpty ]
]

{ #category : #testing }
GtExamplesAnnotation >> hasFailures [
	^ self hasExample and: [ self cachedExampleGroup numberOfFailures isZero not ]
]

{ #category : #testing }
GtExamplesAnnotation >> hasFailuresOrErrors [
	^ self hasExample and: [ self cachedExampleGroup numberOfFailuresAndErrors isZero not ]
]

{ #category : #testing }
GtExamplesAnnotation >> hasResults [
	^ self hasExample and: [ self cachedExampleGroup numberOfResults isZero not ]
]

{ #category : #testing }
GtExamplesAnnotation >> hasSuccesses [
	^ self hasExample and: [ self cachedExampleGroup numberOfSuccesses isZero not ]
]

{ #category : #testing }
GtExamplesAnnotation >> isAffectedByClassChange: aClassName [
	^ (self referencedClasses anySatisfy: [ :eachClass | 
			eachClass name = aClassName ]) or: [ 
			self referencedMethods anySatisfy: [ :eachMethod | 
				eachMethod parentName = aClassName ] ]
]

{ #category : #testing }
GtExamplesAnnotation >> isAffectedByMethodChange: aSelector of: aClassName [
	^ (self referencedMethods anySatisfy: [ :eachMethod | 
				eachMethod parentName = aClassName and: [ eachMethod selector = aSelector ] ])
			or: [ self isAffectedByClassChange: aClassName ]
]

{ #category : #testing }
GtExamplesAnnotation >> isAffectedByPackageChange: aPackageName [
	^ (self referencedPackages anySatisfy: [ :eachPackage | 
			eachPackage name = aPackageName ])
]

{ #category : #testing }
GtExamplesAnnotation >> isPreviewDefined [
	^ self hasExample
]

{ #category : #'private - styling' }
GtExamplesAnnotation >> issuesButtonLabel [
	<return: #BlRope>
	| anAmount |
	anAmount := self cachedExampleGroup numberOfFailuresAndErrors.
	^ anAmount asString,
		(' issue' asPluralBasedOn: anAmount)
]

{ #category : #'private - cache' }
GtExamplesAnnotation >> newExampleGroup [
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
GtExamplesAnnotation >> objectToPreview [
	^ self cachedExampleGroup
]

{ #category : #'private - actions' }
GtExamplesAnnotation >> rebuildExampleGroup [
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
GtExamplesAnnotation >> referencedClasses [
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
GtExamplesAnnotation >> referencedMethods [
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
GtExamplesAnnotation >> referencedPackages [
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
GtExamplesAnnotation >> registerToSystemChanges [
	self gtDocument systemAnnouncer
		when: MethodAdded , MethodModified , MethodRemoved
			send: #handleMethodAnnouncement:
			to: self
			for: self gtSubscriber;
		when: ClassAdded , ClassRemoved
			send: #handleClassAddedOrRemovedAnnouncement:
			to: self
			for: self gtSubscriber;
		when: ClassRenamed
			send: #handleClassRenamedAnnouncement:
			to: self
			for: self gtSubscriber;
		when: ClassRepackaged
			send: #handleClassRepackagedAnnouncement:
			to: self
			for: self gtSubscriber;
		when: RPackageRenamed
			send: #handlePackageRenamedAnnouncement:
			to: self
			for: self gtSubscriber;
		when: GtDocumentUpdateRequestedAnnouncement
			send: #handleDocumentUpdateRequestedAnnouncement:
			to: self
			for: self gtSubscriber
]

{ #category : #'private - styling' }
GtExamplesAnnotation >> resultsLabelAttribute [
	| aGroup |
	aGroup := self cachedExampleGroup.
	^ GtExamplesStatusLabelAttribute new
		beAppend;
		total: aGroup numberOfExamples;
		results: aGroup numberOfResults;
		successes: aGroup numberOfSuccesses;
		issues: aGroup numberOfFailuresAndErrors
]

{ #category : #'private - styling' }
GtExamplesAnnotation >> runButtonAttribute [
	^ GtButtonAttribute new
		beAppend;
		stencil: (GtButtonStencilBuilder new
			label: self runButtonLabel;
			icon: self constants runButtonIcon;
			action: [ self runExamples ])
]

{ #category : #'private - styling' }
GtExamplesAnnotation >> runButtonLabel [
	<return: #BlRope>
	| anAmount |
	anAmount := self cachedExampleGroup numberOfExamples.
	^ self constants runButtonLabel, ' ',
		anAmount asString, (' example' asPluralBasedOn: anAmount)
]

{ #category : #'private - actions' }
GtExamplesAnnotation >> runExamples [
	self cachedExampleGroup runAll.
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | 
			"hack, preview should update itself"
			aCachedValue preview: nil ]
		ifAbsent: [ "ignore" ].
	self gtDocument styleTextRequest
]

{ #category : #'private - styling' }
GtExamplesAnnotation >> styleLinkInText: aBlRope [
	self hasChildren ifFalse: [ ^ self ].
	self utility styleLinkInText: aBlRope forNode: self withLinkAt: self children first
]

{ #category : #'private - styling' }
GtExamplesAnnotation >> styleResultsInText: aBlRope [
	self hasResults ifFalse: [ ^ self ].
	(aBlRope from: self start to: self stop) 
		attribute: self resultsLabelAttribute
]

{ #category : #'private - styling' }
GtExamplesAnnotation >> styleRunButtonInText: aBlRope [
	self hasExample ifFalse: [ ^ self ].
	(aBlRope from: self start to: self stop) 
		attribute: self runButtonAttribute
]

{ #category : #'api - style' }
GtExamplesAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self styleLinkInText: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
	self styleRunButtonInText: aBlRope.
	self styleResultsInText: aBlRope.
	self registerToSystemChanges.
]

{ #category : #'api - style' }
GtExamplesAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	(self nodeStyler: aBlRope)
		if: self hasChildren 
			do: [ :aStyler | aStyler 
				keepChildDisplayed: self children first;
				autoHideNode ]
]

{ #category : #'private - styling' }
GtExamplesAnnotation >> successButtonLabel [
	<return: #BlRope>
	| anAmount |
	anAmount := self cachedExampleGroup numberOfSuccesses.
	^ anAmount asString,
		(anAmount = 1 ifTrue: [ ' success' ] ifFalse: [ ' successes' ])
]
