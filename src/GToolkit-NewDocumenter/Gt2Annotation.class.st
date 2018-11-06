Class {
	#name : #Gt2Annotation,
	#superclass : #PRAbstractAnnotation,
	#traits : 'TBlDebug + TGt2DocumentConstants',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait',
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
Gt2Annotation >> expandedDefaultValue [
	^ false
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> expandedEmptyValue [
	^ false
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> expandedParameterValue [
	^ Gt2DocumentUtility
		booleanValueOf: self constants expandedParameterName 
		in: self parameters 
		emptyValue: [ self expandedEmptyValue ] 
		defaultValue: [ self expandedDefaultValue ]
]

{ #category : #'announcement handling' }
Gt2Annotation >> handleDocumentUpdateRequestedAnnouncement: aGt2DocumentUpdateRequestedAnnouncement [
	
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

{ #category : #accessing }
Gt2Annotation >> referenceParameterName [
	"Return an annotation parameter name that holds a referenced object"
	^ self subclassResponsibility
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> showDefaultValue [
	^ self constants showDefaultValue
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> showEmptyValue [
	^ self constants showDefaultValue
]

{ #category : #'accessing - parameter values' }
Gt2Annotation >> showParameterValue [
	<return: #Symbol>
	^ Gt2DocumentUtility 
		valueOf: self constants showParameterName
		in: self parameters
		value: [ :aString | aString isString 
			ifFalse: [ self showEmptyValue ] 
			ifTrue: [ aString asSymbol ] ]
		emptyValue: [ self showEmptyValue ]
		defaultValue: [ self showDefaultValue ]
]

{ #category : #'private - styling' }
Gt2Annotation >> styleExpandingPreviewInText: aBlRope [
	| theAttributes |
	self isPreviewDefined ifFalse: [ ^ self ].
	theAttributes := BrTextExpandButtonAttributeBuilder new
		attributesCreatingBlock: [ { Gt2PreviewAttribute new
			result: self objectToPreview;
			showSelector: self showParameterValue } ];
		isExpanded: self expandedParameterValue;
		build.
	(aBlRope from: self stop to: self stop)
		attributes: theAttributes.
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
	aLinkColor := Gt2DocumentUtility linkColor: self isReferenceDefined.
	aNodeToStyle := Gt2DocumentUtility 
		parameterNodeNamed: self referenceParameterName forAnnotation: self.
	theAttributes := Array with: (BlTextForegroundAttribute new
					paint: aLinkColor).
	self isReferenceDefined ifTrue: [ 
		theAttributes := theAttributes , {
				BrTextHoverAttribute new 
					removableTextAttribute: (BlTextUnderlineAttribute new paint: aLinkColor).
				BrTextClickAttribute new 
					action: [ :aText :aTarget :anEvent | 
						self browseReferenceFrom: anEvent ] } ].

	(aBlRope  
		from: aNodeToStyle start 
		to: aNodeToStyle stop) 
			attributes: theAttributes.
]
