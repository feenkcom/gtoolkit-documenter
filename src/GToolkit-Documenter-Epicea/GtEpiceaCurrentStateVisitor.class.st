Class {
	#name : #GtEpiceaCurrentStateVisitor,
	#superclass : #EpOldStateVisitor,
	#instVars : [
		'theEnvironment'
	],
	#category : #'GToolkit-Documenter-Epicea'
}

{ #category : #'instance creation' }
GtEpiceaCurrentStateVisitor class >> inEnvironment: anEnvironment [

	^ self basicNew 
		initializeWith: anEnvironment;
		yourself
]

{ #category : #private }
GtEpiceaCurrentStateVisitor >> behaviorNamed: aSymbol ifPresent: presentBlock [

	^ (theEnvironment classOrTraitNamed: aSymbol) 
		ifNil: [ self ]
		ifNotNil: presentBlock
]

{ #category : #initialization }
GtEpiceaCurrentStateVisitor >> initializeWith: anEnvironment [

	self initialize.
	theEnvironment := anEnvironment.
]

{ #category : #visitor }
GtEpiceaCurrentStateVisitor >> stringForBehavior: aClassOrTrait [
	^ theEnvironment
		at: aClassOrTrait name
		ifPresent: [ :existingBehavior | self stringForExistingBehavior: existingBehavior ]
		ifAbsent: [ '' ]
]

{ #category : #visitor }
GtEpiceaCurrentStateVisitor >> stringForExistingBehavior: aClassOrTrait [
	^ String streamContents: [ :stream |
		stream
			nextPutAll: aClassOrTrait definition;
			nextPut: $.;
			cr; cr;
			nextPutAll: aClassOrTrait theMetaClass definition ]
]

{ #category : #visitor }
GtEpiceaCurrentStateVisitor >> visitMethodChange: aChange [
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
GtEpiceaCurrentStateVisitor >> visitMethodModification: aMethodModification [
	^ self visitMethodChange: aMethodModification
]

{ #category : #visiting }
GtEpiceaCurrentStateVisitor >> visitMethodRemoval: aMethodRemoval [
	^ self visitMethodChange: aMethodRemoval
]
