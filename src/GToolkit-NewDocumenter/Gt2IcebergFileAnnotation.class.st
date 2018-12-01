Class {
	#name : #Gt2IcebergFileAnnotation,
	#superclass : #Gt2Annotation,
	#traits : 'TStylingModesWorkInProgress',
	#classTraits : 'TStylingModesWorkInProgress classTrait',
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #accessing }
Gt2IcebergFileAnnotation class >> possibleParameters [
	^ {
		self constants pathParameterName.
		self constants expandedParameterName.
		self constants showParameterName.
		self constants heightParameterName.
		}
]

{ #category : #protected }
Gt2IcebergFileAnnotation class >> tag [
	^ self constants icebergFileAnnotationName 
]

{ #category : #visitor }
Gt2IcebergFileAnnotation >> accept: aVisitor [
	^ aVisitor visitGt2IcebergFileAnnotation: self
]

{ #category : #'private - actions' }
Gt2IcebergFileAnnotation >> browseReferenceFrom: aBlClickEvent [ 
	aBlClickEvent modifiers isShift ifTrue: [ ^ self ].
	self isReferenceDefined ifFalse: [ ^ self inform: 'Input file does not exist' ].
	aBlClickEvent target 
		fireEvent: (GtPhlowObjectToSpawn new
			object: self fileReference;
			sourceElement: aBlClickEvent target)
]

{ #category : #'api - style' }
Gt2IcebergFileAnnotation >> cursorLeftInText: aBlRope [
	self utility hideAllButLinkInText: aBlRope forAnnotation: self
]

{ #category : #'accessing - parameter values' }
Gt2IcebergFileAnnotation >> fileReference [
	<return: #FileReference or: nil>
	^ self utility 
		valueOf: self constants pathParameterName
		in: self parameters
		value: [ :aValue | 
					| aFile |
					aValue isString 
						ifFalse: [ nil ]
						ifTrue: [ 
							aFile := self utility icebergFileReferenceFrom: aValue.
							aFile exists ifTrue: [ aFile ] ifFalse: [ nil ] ] ]
		emptyValue: [ nil ] 
		defaultValue: [ nil ]
]

{ #category : #testing }
Gt2IcebergFileAnnotation >> isPreviewDefined [
	^ self isReferenceDefined
]

{ #category : #testing }
Gt2IcebergFileAnnotation >> isReferenceDefined [
	^ self fileReference ifNotNil: #exists ifNil: false
]

{ #category : #accessing }
Gt2IcebergFileAnnotation >> objectToPreview [
	^ self fileReference
]

{ #category : #'accessing - parameter values' }
Gt2IcebergFileAnnotation >> path [
	<return: #String or: nil>
	^ self utility 
		valueOf: self constants pathParameterName
		in: self parameters
		value: [ :aValue | 
					aValue isString 
						ifFalse: [ nil ]
						ifTrue: [ aValue ] ]
		emptyValue: [ nil ] 
		defaultValue: [ nil ]
]

{ #category : #accessing }
Gt2IcebergFileAnnotation >> referenceParameterName [
	"Return an annotation parameter name that holds a referenced object"
	^ self constants pathParameterName
]

{ #category : #'api - style' }
Gt2IcebergFileAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self styleLinkInText: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
]

{ #category : #'api - style' }
Gt2IcebergFileAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	(self utility mayHideAllButLinkInText: aBlRope forAnnotation: self) ifFalse: [ ^ self ].
	self utility styleCursorAttributeInText: aBlRope forNode: self.
]
