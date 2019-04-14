Class {
	#name : #GtIcebergFileAnnotation,
	#superclass : #GtAnnotation,
	#traits : 'TDocumentLinkStyler',
	#classTraits : 'TDocumentLinkStyler classTrait',
	#category : #'GToolkit-Documenter-Model'
}

{ #category : #accessing }
GtIcebergFileAnnotation class >> possibleParameters [
	^ {
		self constants pathParameterName.
		self constants expandedParameterName.
		self constants showParameterName.
		self constants heightParameterName.
		}
]

{ #category : #protected }
GtIcebergFileAnnotation class >> tag [
	^ self constants icebergFileAnnotationName 
]

{ #category : #visitor }
GtIcebergFileAnnotation >> accept: aVisitor [
	^ aVisitor visitGt2IcebergFileAnnotation: self
]

{ #category : #'private - actions' }
GtIcebergFileAnnotation >> browseReferenceFrom: aBlClickEvent [ 
	aBlClickEvent modifiers isShift ifTrue: [ ^ self ].
	self doesReferenceExist ifFalse: [ ^ self inform: 'Input file does not exist' ].
	aBlClickEvent target 
		fireEvent: (GtPhlowObjectToSpawn new
			object: self fileReference;
			sourceElement: aBlClickEvent target)
]

{ #category : #'api - style' }
GtIcebergFileAnnotation >> cursorLeftInText: aBlRope [
	self utility hideMarkupsInText: aBlRope start: self start stop: self stop
]

{ #category : #testing }
GtIcebergFileAnnotation >> doesReferenceExist [
	^ self fileReference ifNotNil: #exists ifNil: false
]

{ #category : #'accessing - parameter values' }
GtIcebergFileAnnotation >> fileReference [
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
GtIcebergFileAnnotation >> isPreviewDefined [
	^ self doesReferenceExist
]

{ #category : #testing }
GtIcebergFileAnnotation >> isReferenceDefined [
	^ self fileReference notNil
]

{ #category : #accessing }
GtIcebergFileAnnotation >> objectToPreview [
	^ self fileReference
]

{ #category : #'accessing - parameter values' }
GtIcebergFileAnnotation >> path [
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
GtIcebergFileAnnotation >> referenceParameterName [
	"Return an annotation parameter name that holds a referenced object"
	^ self constants pathParameterName
]

{ #category : #'accessing - parameter values' }
GtIcebergFileAnnotation >> referenceParameterValue [
	<return: #String>
	^ self utility 
		valueOf: self constants pathParameterName
		in: self parameters
		value: [ :aValue | aValue asString ]
		emptyValue: [ 'N/A' ] 
		defaultValue: [ 'N/A' ]
]

{ #category : #'api - style' }
GtIcebergFileAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self styleLinkInText: aBlRope.
	self styleLinkButtonInText: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
]

{ #category : #'api - style' }
GtIcebergFileAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	self utility mayHideMarkupsInText: aBlRope start: self start stop: self stop forNode: self.
	self utility styleCursorAttributeInText: aBlRope forNode: self.
]

{ #category : #'private - styling' }
GtIcebergFileAnnotation >> styledLinkButtonActionFrom: aButton [
	"Perform an action on mouse click"
	aButton phlow spawnObject: self fileReference
]

{ #category : #'private - styling' }
GtIcebergFileAnnotation >> styledLinkButtonText [
	"Return a button link name"
	<return: #String>
	^ self referenceParameterValue
]
