Class {
	#name : #Gt2Annotation,
	#superclass : #PRAbstractAnnotation,
	#traits : 'TBlDebug + TGt2DocumentConstants + TGt2DocumentUtility',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait + TGt2DocumentUtility classTrait',
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #testing }
Gt2Annotation class >> isAbstract [
	^ self name = #Gt2Annotation 
]

{ #category : #'private - cache' }
Gt2Annotation >> annotationCacheValueClass [
	^ Gt2AnnotationCacheValue
]

{ #category : #'private - actions' }
Gt2Annotation >> browseReferenceFrom: anEvent [
	"Subclasses should define actual action"
	self subclassResponsibility
]

{ #category : #'private - cache' }
Gt2Annotation >> cacheKey [
	^ Gt2AnnotationCacheKey new
		name: self tag;
		parameters: self parameters
]

{ #category : #'private - cache' }
Gt2Annotation >> cachedIsExpanded [
	<return: #Boolean>
	self gtDocument
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | 
			^ aCachedValue isExpanded ifNil: [ self expandedParameterValue ] ]
		ifAbsentPut: [ self annotationCacheValueClass new
				isExpanded: self expandedParameterValue ].
	^ self expandedParameterValue
]

{ #category : #'private - cache' }
Gt2Annotation >> cachedIsExpanded: aBoolean [
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue isExpanded: aBoolean ]
		ifAbsentPut: [ 
			self annotationCacheValueClass new isExpanded: aBoolean ]
]

{ #category : #'private - cache' }
Gt2Annotation >> cachedPreview [
	<return: #BlElement or: nil>
	^ self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue preview ] 
		ifAbsent: [ nil ]
]

{ #category : #'private - cache' }
Gt2Annotation >> cachedPreview: anElement [
	self gtDocument 
		cacheAt: self cacheKey
		ifPresent: [ :aCachedValue | aCachedValue preview: anElement ]
		ifAbsentPut: [ 
			self annotationCacheValueClass new 
				preview: anElement;
				isExpanded: true ]
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> defaultShowSelector [
	^ self constants defaultShowSelector
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> expandedDefaultValue [
	^ false
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> expandedEmptyValue [
	^ true
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> expandedParameterValue [
	^ self utility
		booleanValueOf: self constants expandedParameterName 
		in: self parameters 
		emptyValue: [ self expandedEmptyValue ] 
		defaultValue: [ self expandedDefaultValue ]
]

{ #category : #'announcement handling' }
Gt2Annotation >> handleDocumentUpdateRequestedAnnouncement: aGt2DocumentUpdateRequestedAnnouncement [
	
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> heightParameterValue [
	^ self utility 
		valueOf: self constants heightParameterName
		in: self parameters
		value: [ :aNumber | aNumber isNumber 
			ifTrue: [ aNumber ]
			ifFalse: [ self constants defaultPreviewHeight ] ]
		emptyValue: [ self constants defaultPreviewHeight ]
		defaultValue: [ self constants defaultPreviewHeight ]
]

{ #category : #testing }
Gt2Annotation >> isPreviewCached [
	"Subclasses can cache previews"
	^ false
]

{ #category : #testing }
Gt2Annotation >> isPreviewDefined [
	"Return true if a preview object is defined"
	^ self subclassResponsibility
]

{ #category : #testing }
Gt2Annotation >> isReferenceDefined [
	"Return true if a referenced object is defined"
	^ self subclassResponsibility
]

{ #category : #accessing }
Gt2Annotation >> objectToPreview [
	"Subclasses should define what object to preview"
	^ self subclassResponsibility
]

{ #category : #'private - styling' }
Gt2Annotation >> previewAttributes [
	^ {Gt2CachedAttribute new
		attribute:
			(Gt2ResizablePreviewAttribute new
				result: self objectToPreview;
				showSelector: self showParameterValue;
				height: self heightParameterValue);
		cache: self cachedPreview;
		onCachingDo:
				[ :aCachedElement :theAttribute | self cachedPreview: aCachedElement ]}
]

{ #category : #accessing }
Gt2Annotation >> referenceParameterName [
	"Return an annotation parameter name that holds a referenced object"
	^ self constants fileParameterName
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> showEmptyValue [
	^ self defaultShowSelector
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> showParameterValue [
	<return: #Symbol>
	^ self utility 
		valueOf: self constants showParameterName
		in: self parameters
		value: [ :aString | aString isString 
			ifFalse: [ self showEmptyValue ] 
			ifTrue: [ aString asSymbol ] ]
		emptyValue: [ self showEmptyValue ]
		defaultValue: [ self defaultShowSelector ]
]

{ #category : #'private - styling' }
Gt2Annotation >> styleExpandingPreviewInText: aBlRope [
	| theAttributes |
	self isPreviewDefined
		ifFalse: [ ^ self ].
	theAttributes := Gt2CachedTextExpandButtonAttributeStencil new
		attributesCreatingBlock: [ self previewAttributes ];
		isExpanded: self cachedIsExpanded;
		onCachingDo: [ :aBoolean :theAttribute | self cachedIsExpanded: aBoolean ];
		create.
	(aBlRope from: self stop to: self stop) attributes: theAttributes
]

{ #category : #'api - style' }
Gt2Annotation >> styleInText: aBlRope [
	"Subclasses can add more styling"
	(aBlRope 
			from: self start 
			to: self stop)
				foreground: self constants subtleColor.
]

{ #category : #'private - styling' }
Gt2Annotation >> styleLinkInText: aBlRope [
	| aLinkColor aNodeToStyle theAttributes |
	aLinkColor := self utility linkColor: self isReferenceDefined.
	aNodeToStyle := self utility 
		parameterNodeNamed: self referenceParameterName forAnnotation: self.
	theAttributes := Array with: (BlTextForegroundAttribute new
					paint: aLinkColor).
	self isReferenceDefined ifTrue: [ 
		theAttributes := theAttributes , {
				BrTextHoverStylableAttribute new attribute: (BlTextUnderlineAttribute new paint: aLinkColor).
				BrTextClickAttribute new 
					action: [ :aText :aTarget :anEditorElement :anEvent | 
						self browseReferenceFrom: anEvent ] } ].

	(aBlRope  
		from: aNodeToStyle start 
		to: aNodeToStyle stop) 
			attributes: theAttributes.
]
