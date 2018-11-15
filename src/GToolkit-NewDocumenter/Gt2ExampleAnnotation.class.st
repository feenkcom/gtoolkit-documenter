Class {
	#name : #Gt2ExampleAnnotation,
	#superclass : #Gt2Annotation,
	#instVars : [
		'referencedExample',
		'example'
	],
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #accessing }
Gt2ExampleAnnotation class >> possibleParameters [
	^ {
		self constants nameParameterName.
		self constants expandedParameterName.
		"source code"
		self constants codeHeightParameterName.
		self constants codeExpandedParameterName.
		self constants noCodeParameterName.
		"result"
		self constants previewHeightParameterName.
		self constants previewExpandedParameterName.
		self constants previewShowParameterName.
		}
]

{ #category : #protected }
Gt2ExampleAnnotation class >> tag [
	^ self constants exampleAnnotationName
]

{ #category : #visitor }
Gt2ExampleAnnotation >> accept: aVisitor [
	^ aVisitor visitGt2ExampleAnnotation: self
]

{ #category : #'private - actions' }
Gt2ExampleAnnotation >> browseReferenceFrom: anEvent [ 
	anEvent modifiers isShift ifTrue: [ ^ self ].
	self isExampleDefined ifFalse: [ ^ self inform: 'Example method does not exist' ].
	anEvent target fireEvent: (GtPhlowObjectToSpawn new 
		object: self referencedExample;
		sourceElement: anEvent target)
]

{ #category : #'accessing - parameter values' }
Gt2ExampleAnnotation >> codeExpanded [
	<return: #Boolean>
	^ self utility 
		booleanValueOf: self constants codeExpandedParameterName 
		in: self parameters 
		emptyValue: [ true ] 
		defaultValue: [ true ]
]

{ #category : #'accessing - parameter values' }
Gt2ExampleAnnotation >> codeHeight [
	^ self utility 
		valueOf: self constants codeHeightParameterName
		in: self parameters
		value: [ :aNumber | aNumber isNumber 
			ifTrue: [ aNumber ]
			ifFalse: [ self constants defaultPreviewHeight ] ]
		emptyValue: [ self constants defaultPreviewHeight ]
		defaultValue: [ self constants defaultPreviewHeight ]
]

{ #category : #compatibility }
Gt2ExampleAnnotation >> doNotDisplaySourceCodeParameterValue [
	<compatibility>
	^ self noCode
]

{ #category : #'accessing - parameter values' }
Gt2ExampleAnnotation >> example [
	^ example ifNil: [ example := self referencedExample compiledMethod gtExample ]
]

{ #category : #'accessing - parameter values' }
Gt2ExampleAnnotation >> expandedDefaultValue [
	^ true
]

{ #category : #'announcement handling' }
Gt2ExampleAnnotation >> handleClassAddedOrRemovedAnnouncement: aClassAdded [ 
	(self referencedExample notNil and: [ 
		aClassAdded classAffected originalName = self referencedExample parentName ])
			ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #'announcement handling' }
Gt2ExampleAnnotation >> handleClassRenamedAnnouncement: aClassRenamed [ 
	(self referencedExample notNil and: [ 
			aClassRenamed newName = self referencedExample parentName or: [ 
				aClassRenamed oldName = self referencedExample parentName ] ])
			ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #'announcement handling' }
Gt2ExampleAnnotation >> handleMethodAnnouncement: aMethodModified [ 
	(self referencedExample notNil and: [ 
		aMethodModified classAffected name = self referencedExample parentName  
			and: [ aMethodModified selector = self referencedExample selector ]])
				ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #compatibility }
Gt2ExampleAnnotation >> hasCaption [
	<compatibility>
	^ false
]

{ #category : #compatibility }
Gt2ExampleAnnotation >> hasLabel [
	<compatibility>
	^ false
]

{ #category : #testing }
Gt2ExampleAnnotation >> isExampleDefined [
	"Return true if an example method is defined in the system"
	^ self referencedExample notNil and: [ self referencedExample isDefined ]
]

{ #category : #compatibility }
Gt2ExampleAnnotation >> isMethodDefined [
	<compatibility>
	^ self isExampleDefined
]

{ #category : #testing }
Gt2ExampleAnnotation >> isPreviewDefined [
	^ self isExampleDefined
]

{ #category : #testing }
Gt2ExampleAnnotation >> isReferenceDefined [
	^ self isExampleDefined
]

{ #category : #compatibility }
Gt2ExampleAnnotation >> methodDefinition [
	<compatibility>
	^ self referencedExample
]

{ #category : #compatibility }
Gt2ExampleAnnotation >> methodName [
	<compatibility>
	^ self referencedExample fullName
]

{ #category : #'accessing - parameter values' }
Gt2ExampleAnnotation >> noCode [
	<return: #Boolean>
	^ self utility 
		booleanValueOf: self constants noCodeParameterName 
		in: self parameters 
		emptyValue: [ true ] 
		defaultValue: [ false ]
]

{ #category : #accessing }
Gt2ExampleAnnotation >> objectToPreview [
	^ self referencedExample compiledMethod gtExample
]

{ #category : #'private - styling' }
Gt2ExampleAnnotation >> previewAttributes [
	^ { Gt2CachedAttribute new attribute:
			(Gt2ExamplePreviewAttribute new
				beAppend;
				example: self example;
				codeExpanded: self codeExpanded;
				codeHeight: self codeHeight;
				noCode: self noCode;
				previewExpanded: self previewExpanded;
				previewShowSelector: self previewShowSelector;
				previewHeight: self previewHeight);
		cache: self cachedPreview;
		onCachingDo: [ :aCachedElement :theAttribute | 
			self cachedPreview: aCachedElement ] }
]

{ #category : #'accessing - parameter values' }
Gt2ExampleAnnotation >> previewExpanded [
	<return: #Boolean>
	^ self utility 
		booleanValueOf: self constants previewExpandedParameterName 
		in: self parameters 
		emptyValue: [ true ] 
		defaultValue: [ false ]
]

{ #category : #'accessing - parameter values' }
Gt2ExampleAnnotation >> previewHeight [
	^ self utility 
		valueOf: self constants previewHeightParameterName
		in: self parameters
		value: [ :aNumber | aNumber isNumber 
			ifTrue: [ aNumber ]
			ifFalse: [ self constants defaultPreviewHeight ] ]
		emptyValue: [ self constants defaultPreviewHeight ]
		defaultValue: [ self constants defaultPreviewHeight ]
]

{ #category : #'accessing - parameter values' }
Gt2ExampleAnnotation >> previewShowSelector [
	<return: #Symbol>
	^ self utility 
		valueOf: self constants previewShowParameterName
		in: self parameters
		value: [ :aString | aString isString 
			ifFalse: [ self showEmptyValue ] 
			ifTrue: [ aString asSymbol ] ]
		emptyValue: [ self showEmptyValue ]
		defaultValue: [ self defaultShowSelector ]
]

{ #category : #accessing }
Gt2ExampleAnnotation >> referenceParameterName [
	^ self constants nameParameterName 
]

{ #category : #accessing }
Gt2ExampleAnnotation >> referencedExample [
	<return: #RGMethodDefinition or: nil>
	^ referencedExample ifNil: [ referencedExample := self utility 
		valueOf: self constants nameParameterName
		in: self parameters 
		value: [ :aValue | 
			aValue isString 
				ifTrue: [ GtSystemUtility methodDefinitionFromString: aValue ]
				ifFalse: [ nil ] ] 
		emptyValue: [ nil ] 
		defaultValue: [ nil ] ]
]

{ #category : #subscriptions }
Gt2ExampleAnnotation >> registerToSystemChanges [
	self gtDocument
		subscribe: MethodAdded, MethodRemoved
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
		subscribe: Gt2DocumentUpdateRequestedAnnouncement
			send: #handleDocumentUpdateRequestedAnnouncement:
			to: self
			for: self gtSubscriber.
]

{ #category : #'api - style' }
Gt2ExampleAnnotation >> styleText: aBlRope [
	super styleText: aBlRope.
	self styleLinkInText: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
	self registerToSystemChanges
]
