Class {
	#name : #GtExampleAnnotation,
	#superclass : #GtAnnotation,
	#instVars : [
		'referencedExample',
		'example'
	],
	#category : #'GToolkit-Documenter-Model'
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

{ #category : #'private - actions' }
GtExampleAnnotation >> browseReferenceFrom: anEvent [ 
	anEvent modifiers isShift ifTrue: [ ^ self ].
	self isExampleDefined ifFalse: [ ^ self inform: 'Example method does not exist' ].
	anEvent target fireEvent: (GtPhlowObjectToSpawn new 
		object: self referencedExample;
		sourceElement: anEvent target)
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

{ #category : #'api - style' }
GtExampleAnnotation >> cursorLeftInText: aBlRope [
	self isExampleDefined 
		ifTrue: [ self utility hideMarkupsInText: aBlRope start: self start stop: self stop ]
		ifFalse: [ self utility hideAllButLinkInText: aBlRope forAnnotation: self ].
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

{ #category : #'accessing - parameter values' }
GtExampleAnnotation >> example [
	^ example ifNil: [ example := self referencedExample compiledMethod gtExample ]
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
	^ self referencedExample compiledMethod gtExample
]

{ #category : #'private - styling' }
GtExampleAnnotation >> previewAttributes [
	^ { GtCachedAttribute new attribute:
			(GtExamplePreviewAttribute new
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
		subscribe: GtDocumentUpdateRequestedAnnouncement
			send: #handleDocumentUpdateRequestedAnnouncement:
			to: self
			for: self gtSubscriber.
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
	self isExampleDefined 
		ifTrue: [ self utility mayHideMarkupsInText: aBlRope start: self start stop: self stop forNode: self ]
		ifFalse: [ (self utility mayHideAllButLinkInText: aBlRope forAnnotation: self) ifFalse: [ ^ self ] ].
	self utility stylePreviewInText: aBlRope forNode: self.
	self utility styleCursorAttributeInText: aBlRope forNode: self.
]
