Class {
	#name : #Gt2IcebergFileAnnotation,
	#superclass : #Gt2Annotation,
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
	self doesReferenceExist ifFalse: [ ^ self inform: 'Input file does not exist' ].
	aBlClickEvent target 
		fireEvent: (GtPhlowObjectToSpawn new
			object: self fileReference;
			sourceElement: aBlClickEvent target)
]

{ #category : #'api - style' }
Gt2IcebergFileAnnotation >> cursorLeftInText: aBlRope [
	self utility hideMarkupsInText: aBlRope start: self start stop: self stop
]

{ #category : #testing }
Gt2IcebergFileAnnotation >> doesReferenceExist [
	^ self fileReference ifNotNil: #exists ifNil: false
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
	^ self doesReferenceExist
]

{ #category : #testing }
Gt2IcebergFileAnnotation >> isReferenceDefined [
	^ self fileReference notNil
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

{ #category : #'accessing - parameter values' }
Gt2IcebergFileAnnotation >> referenceParameterValue [
	<return: #String>
	^ self utility 
		valueOf: self constants pathParameterName
		in: self parameters
		value: [ :aValue | aValue asString ]
		emptyValue: [ 'N/A' ] 
		defaultValue: [ 'N/A' ]
]

{ #category : #'api - style' }
Gt2IcebergFileAnnotation >> styleLinkButtonInText: aBlRope [
	(aBlRope from: self start to: self stop) 
		attribute: (Gt2ButtonAttribute new
			beAppend;
			stencil: (Gt2ButtonStencilBuilder new
				label: self referenceParameterValue;
				icon: BrGlamorousIcons inspect;
				action: [ :button | button phlow spawnObject: self fileReference] ))
]

{ #category : #'api - style' }
Gt2IcebergFileAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self styleLinkInText: aBlRope.
	self styleLinkButtonInText: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
]

{ #category : #'api - style' }
Gt2IcebergFileAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	self utility mayHideMarkupsInText: aBlRope start: self start stop: self stop forNode: self.
	self utility styleCursorAttributeInText: aBlRope forNode: self.
]
