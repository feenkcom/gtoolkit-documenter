Class {
	#name : #GtExampleAnnotation,
	#superclass : #GtAnnotation,
	#instVars : [
		'referencedExample',
		'example'
	],
	#category : #'GToolkit-Documenter-Annotations'
}

{ #category : #accessing }
GtExampleAnnotation class >> possibleParameters [
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
		"assign example result to a variable name"
		self constants returnVariableParameterName.
		}
]

{ #category : #protected }
GtExampleAnnotation class >> tag [
	^ self constants exampleAnnotationName
]

{ #category : #visitor }
GtExampleAnnotation >> accept: aVisitor [
	^ aVisitor visitGt2ExampleAnnotation: self
]

{ #category : #'private - cache' }
GtExampleAnnotation >> annotationCacheValueClass [
	^ GtExampleAnnotationCacheValue
]

{ #category : #'private - actions' }
GtExampleAnnotation >> browseReferenceFrom: anEvent [ 
	anEvent modifiers isShift ifTrue: [ ^ self ].
	self isExampleDefined ifFalse: [ ^ self inform: 'Example method does not exist' ].
	anEvent target phlow spawnObject: self referencedExample.
]

{ #category : #'private - cache' }
GtExampleAnnotation >> cachedExample [
	<return: #GtExampleWithResult>
	| anExampleOrNil |
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | 
			anExampleOrNil := aCachedValue example.
			anExampleOrNil ifNil: [ 
				anExampleOrNil := self example.
				aCachedValue example: anExampleOrNil ] ]
		ifAbsentPut: [ 
			anExampleOrNil := self example.
			self annotationCacheValueClass new 
				example: anExampleOrNil;
				isExpanded: self expandedParameterValue ].
	^ anExampleOrNil
]

{ #category : #testing }
GtExampleAnnotation >> canBeExecuted [
	"Return true if the example can be executed"
	^ self isPreviewDefined and: [ self example canBeExecuted ]
]

{ #category : #'accessing - parameter values' }
GtExampleAnnotation >> codeExpanded [
	<return: #Boolean>
	^ self utility 
		booleanValueOf: self constants codeExpandedParameterName 
		in: self parameters 
		emptyValue: [ true ] 
		defaultValue: [ true ]
]

{ #category : #'accessing - parameter values' }
GtExampleAnnotation >> codeHeight [
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
GtExampleAnnotation >> doNotDisplaySourceCodeParameterValue [
	<compatibility>
	^ self noCode
]

{ #category : #testing }
GtExampleAnnotation >> doesReferenceExist [
	^ self isExampleDefined
]

{ #category : #'private - cache' }
GtExampleAnnotation >> example [
	"You should use #cachedExample method by default, not this one."

	<return: #GtExampleWithResult>
	example
		ifNil: [ example := self referencedExample compiledMethod gtExample
				asExampleWithResult.
			self subscribeToExample ].
	^ example
]

{ #category : #'private - styling' }
GtExampleAnnotation >> examplePreviewAttributeClass [
	^ GtExamplePreviewAttribute
]

{ #category : #'accessing - parameter values' }
GtExampleAnnotation >> expandedDefaultValue [
	^ true
]

{ #category : #'announcement handling' }
GtExampleAnnotation >> handleClassAddedOrRemovedAnnouncement: aClassAdded [ 
	(self referencedExample notNil and: [ 
		aClassAdded classAffected originalName = self referencedExample parentName ])
			ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #'announcement handling' }
GtExampleAnnotation >> handleClassRenamedAnnouncement: aClassRenamed [ 
	(self referencedExample notNil and: [ 
			aClassRenamed newName = self referencedExample parentName or: [ 
				aClassRenamed oldName = self referencedExample parentName ] ])
			ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #'announcement handling' }
GtExampleAnnotation >> handleExampleExecuted: aGtExampleExecuted [
	self shouldSetResultVariable ifFalse: [ ^ self ].
	aGtExampleExecuted hasResult ifFalse: [ ^ self ].
	self gtDocument variableBindings 
		at: self resultVariableName put: aGtExampleExecuted returnValue.
	self gtDocument styleTextRequest
]

{ #category : #'announcement handling' }
GtExampleAnnotation >> handleMethodAnnouncement: aMethodModified [ 
	(self referencedExample notNil and: [ 
		aMethodModified classAffected name = self referencedExample parentName  
			and: [ aMethodModified selector = self referencedExample selector ]])
				ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #compatibility }
GtExampleAnnotation >> hasCaption [
	<compatibility>
	^ false
]

{ #category : #compatibility }
GtExampleAnnotation >> hasLabel [
	<compatibility>
	^ false
]

{ #category : #testing }
GtExampleAnnotation >> isExampleDefined [
	"Return true if an example method is defined in the system"
	^ self referencedExample notNil and: [ self referencedExample isDefined ]
]

{ #category : #compatibility }
GtExampleAnnotation >> isMethodDefined [
	<compatibility>
	^ self isExampleDefined
]

{ #category : #testing }
GtExampleAnnotation >> isPreviewDefined [
	^ self isExampleDefined
]

{ #category : #compatibility }
GtExampleAnnotation >> methodDefinition [
	<compatibility>
	^ self referencedExample
]

{ #category : #compatibility }
GtExampleAnnotation >> methodName [
	<compatibility>
	^ self referencedExample fullName
]

{ #category : #'private - styling' }
GtExampleAnnotation >> newExamplePreviewAttribute [
	^ self examplePreviewAttributeClass new
		beAppend;
		example: self cachedExample;
		codeExpanded: self codeExpanded;
		codeHeight: self codeHeight;
		noCode: self noCode;
		previewExpanded: self previewExpanded;
		previewShowSelector: self previewShowSelector;
		previewHeight: self previewHeight
]

{ #category : #'accessing - parameter values' }
GtExampleAnnotation >> noCode [
	<return: #Boolean>
	^ self utility 
		booleanValueOf: self constants noCodeParameterName 
		in: self parameters 
		emptyValue: [ true ] 
		defaultValue: [ false ]
]

{ #category : #accessing }
GtExampleAnnotation >> objectToPreview [
	^ self cachedExample
]

{ #category : #'private - styling' }
GtExampleAnnotation >> previewAttributes [
	^ {(GtCachedAttribute new
			attribute: self newExamplePreviewAttribute;
			cache: self cachedPreview;
			onCachingDo: [ :aCachedElement :theAttribute | 
				self cachedPreview: aCachedElement ])}
]

{ #category : #'accessing - parameter values' }
GtExampleAnnotation >> previewExpanded [
	<return: #Boolean>
	^ self utility 
		booleanValueOf: self constants previewExpandedParameterName 
		in: self parameters 
		emptyValue: [ true ] 
		defaultValue: [ false ]
]

{ #category : #'accessing - parameter values' }
GtExampleAnnotation >> previewHeight [
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
GtExampleAnnotation >> previewShowSelector [
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
GtExampleAnnotation >> referenceParameterName [
	^ self constants nameParameterName 
]

{ #category : #accessing }
GtExampleAnnotation >> referencedExample [
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
GtExampleAnnotation >> registerToSystemChanges [
	self gtDocument
		when: MethodAdded , MethodRemoved
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
		when: GtDocumentUpdateRequestedAnnouncement
			send: #handleDocumentUpdateRequestedAnnouncement:
			to: self
			for: self gtSubscriber
]

{ #category : #'accessing - parameter values' }
GtExampleAnnotation >> resultVariableName [
	<return: #Symbol or: nil>
	^ self utility 
		valueOf: self constants returnVariableParameterName
		in: self parameters
		value: [ :aString | (aString isString or: [ aString isSymbol ])
			ifTrue: [ aString asSymbol ]
			ifFalse: [ nil ] ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]
]

{ #category : #testing }
GtExampleAnnotation >> shouldSetResultVariable [
	<return: #Boolean>
	^ self resultVariableName isNotNil
]

{ #category : #'api - style' }
GtExampleAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self styleLinkInText: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
	self registerToSystemChanges
]

{ #category : #'api - style' }
GtExampleAnnotation >> styleTextWithoutInteractions: aBlRope [
	| aLinkNode |
	aLinkNode := self utility linkNodeForAnnotation: self.
	(aBlRope from: aLinkNode start to: aLinkNode stop) glamorousCodeFont.
	self utility hideAllButLinkInText: aBlRope forAnnotation: self.
]

{ #category : #'api - style' }
GtExampleAnnotation >> styleTextWithoutMarkup: aBlRope [ 
	super styleTextWithoutMarkup: aBlRope.
	self utility subtleMarkupsInText: aBlRope start: self start stop: self stop.
	self styleLinkInText: aBlRope.
	self registerToSystemChanges.
	(self nodeStyler: aBlRope)
		if: self isExampleDefined 
			do: [ :aStyler | aStyler autoHideNode ]
			otherwise: [ :aStyler |
				aStyler 
					keepChildDisplayed: (self nodeFinder 
						annotationParameter: self referenceParameterName);
					autoHideNode ]. 
	self utility stylePreviewInText: aBlRope forNode: self.
]

{ #category : #subscriptions }
GtExampleAnnotation >> subscribeToExample [
	^ example announcer weak
		when: GtExampleExecuted
		send: #handleExampleExecuted:
		to: self
]
