Class {
	#name : #GtAnnotation,
	#superclass : #PRAbstractAnnotation,
	#traits : 'TBlDebug + TLepiterConstants + TGtDocumentUtility',
	#classTraits : 'TBlDebug classTrait + TLepiterConstants classTrait + TGtDocumentUtility classTrait',
	#category : #'GToolkit-Documenter-Annotations'
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

{ #category : #'api - style' }
GtAnnotation >> nodeFinder [
	^ GtNodeNodeFinder new
		node: self
]

{ #category : #'api - style' }
GtAnnotation >> nodeStyler: aBlText [
	^ GtStyledNodeBuilder new
		document: self gtDocument;
		node: self;
		text: aBlText
]

{ #category : #accessing }
GtAnnotation >> objectToPreview [
	"Subclasses should define what object to preview"
	^ self subclassResponsibility
]

{ #category : #'private - styling' }
GtAnnotation >> previewAttributes [
	^ {
		GtResizablePreviewAttribute new
			withCache: self selector: #cachedPreview;
			result: self objectToPreview;
			showSelector: self showParameterValue;
			height: self heightParameterValue
		}
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
