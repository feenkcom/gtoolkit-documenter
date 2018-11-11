Class {
	#name : #Gt2EpiceaCurrentStateVisitor,
	#superclass : #EpOldStateVisitor,
	#instVars : [
		'theEnvironment'
	],
	#category : #'GToolkit-NewDocumenter-Epicea'
}

{ #category : #'instance creation' }
Gt2EpiceaCurrentStateVisitor class >> inEnvironment: anEnvironment [

	^ self basicNew 
		initializeWith: anEnvironment;
		yourself
]

{ #category : #private }
Gt2EpiceaCurrentStateVisitor >> behaviorNamed: aSymbol ifPresent: presentBlock [

	^ (theEnvironment classOrTraitNamed: aSymbol) 
		ifNil: [ self ]
		ifNotNil: presentBlock
]

{ #category : #initialization }
Gt2EpiceaCurrentStateVisitor >> initializeWith: anEnvironment [

	self initialize.
	theEnvironment := anEnvironment.
]

{ #category : #visitor }
Gt2EpiceaCurrentStateVisitor >> stringForBehavior: aClassOrTrait [
	^ theEnvironment
		at: aClassOrTrait name
		ifPresent: [ :existingBehavior | self stringForExistingBehavior: existingBehavior ]
		ifAbsent: [ '' ]
]

{ #category : #visitor }
Gt2EpiceaCurrentStateVisitor >> stringForExistingBehavior: aClassOrTrait [
	^ String streamContents: [ :stream |
		stream
			nextPutAll: aClassOrTrait definition;
			nextPut: $.;
			cr; cr;
			nextPutAll: aClassOrTrait theMetaClass definition ]
]

{ #category : #visitor }
Gt2EpiceaCurrentStateVisitor >> visitBehaviorChange: aChange [
	^ self stringForBehavior: aChange behaviorAffected
]

{ #category : #visitor }
Gt2EpiceaCurrentStateVisitor >> visitMethodChange: aChange [
	"Addition and Modification come here"
	self 
		behaviorNamed: aChange behaviorAffectedName
		ifPresent: [ :behavior | 
			^ behavior 
				compiledMethodAt: aChange methodAffectedSelector
				ifPresent: [ :method |
					self 
						printProtocol: method protocol
						sourceCode: method sourceCode ]
				ifAbsent: [ '' ] ].
	^ '' "If class is not present"
]

{ #category : #visiting }
Gt2EpiceaCurrentStateVisitor >> visitMethodModification: aMethodModification [
	^ self visitMethodChange: aMethodModification
]

{ #category : #visiting }
Gt2EpiceaCurrentStateVisitor >> visitMethodRemoval: aMethodRemoval [
	^ self visitMethodChange: aMethodRemoval
]
