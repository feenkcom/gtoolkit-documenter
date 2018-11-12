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

{ #category : #'private - actions' }
Gt2Annotation >> browseReferenceFrom: anEvent [
	"Subclasses should define actual action"
	self subclassResponsibility
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> defaultShowSelector [
	^ self constants defaultShowSelector
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
	^ self constants nameParameterName
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
	self utility styleExpandingPreviewInText: aBlRope forNode: self
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
	self utility styleLinkInText: aBlRope forNode: self
]
