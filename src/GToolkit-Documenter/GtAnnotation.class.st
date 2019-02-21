Class {
	#name : #GtAnnotation,
	#superclass : #PRAbstractAnnotation,
	#traits : 'TBlDebug + TGt2DocumentConstants + TGt2DocumentUtility',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait + TGt2DocumentUtility classTrait',
	#category : #'GToolkit-Documenter-Model'
}

{ #category : #accessing }
GtAnnotation class >> constants [
	^ GtDocumentConstants
]

{ #category : #testing }
GtAnnotation class >> isAbstract [
	^ self name = #GtAnnotation 
]

{ #category : #private }
GtAnnotation class >> utility [
	^ GtDocumentUtility
]

{ #category : #'private - actions' }
GtAnnotation >> browseReferenceFrom: anEvent [
	"Subclasses should define actual action"
	self subclassResponsibility
]

{ #category : #accessing }
GtAnnotation >> constants [
	^ GtDocumentConstants
]

{ #category : #'api - style' }
GtAnnotation >> cursorNearbyInText: aBlRope [
	self utility cursorNeabyInText: aBlRope forNode: self
]

{ #category : #'accessing - parameter values' }
GtAnnotation >> defaultShowSelector [
	^ self constants defaultShowSelector
]

{ #category : #testing }
GtAnnotation >> doesReferenceExist [
	"Return true if a referenced object is defined"
	^ self subclassResponsibility
]

{ #category : #'announcement handling' }
GtAnnotation >> handleDocumentUpdateRequestedAnnouncement: aGt2DocumentUpdateRequestedAnnouncement [
	
]

{ #category : #'accessing - parameter values' }
GtAnnotation >> heightParameterValue [
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
GtAnnotation >> isPreviewDefined [
	"Return true if a preview object is defined"
	^ self subclassResponsibility
]

{ #category : #accessing }
GtAnnotation >> objectToPreview [
	"Subclasses should define what object to preview"
	^ self subclassResponsibility
]

{ #category : #'private - styling' }
GtAnnotation >> previewAttributes [
	^ {GtCachedAttribute new
		attribute:
			(GtResizablePreviewAttribute new
				result: self objectToPreview;
				showSelector: self showParameterValue;
				height: self heightParameterValue);
		cache: self cachedPreview;
		onCachingDo:
				[ :aCachedElement :theAttribute | self cachedPreview: aCachedElement ]}
]

{ #category : #accessing }
GtAnnotation >> referenceParameterName [
	"Return an annotation parameter name that holds a referenced object"
	^ self constants nameParameterName
]

{ #category : #'accessing - parameter values' }
GtAnnotation >> showEmptyValue [
	^ self defaultShowSelector
]

{ #category : #'accessing - parameter values' }
GtAnnotation >> showParameterValue [
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
GtAnnotation >> styleExpandingPreviewInText: aBlRope [
	self utility styleExpandingPreviewInText: aBlRope forNode: self
]

{ #category : #'private - styling' }
GtAnnotation >> styleLinkInText: aBlRope [
	self utility styleLinkInText: aBlRope forAnnotationNode: self
]

{ #category : #'api - style' }
GtAnnotation >> styleTextWithMarkup: aBlRope [
	"Subclasses can add more styling"
	self utility subtleMarkupsInText: aBlRope start: self start stop: self stop
]

{ #category : #private }
GtAnnotation >> utility [
	^ GtDocumentUtility
]
