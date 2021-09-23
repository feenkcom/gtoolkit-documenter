Class {
	#name : 'GtIcebergFileAnnotation',
	#superclass : 'GtAnnotation',
	#category : 'GToolkit-Documenter-Annotations'
}

{ #category : 'accessing' }
GtIcebergFileAnnotation class >> possibleParameters [
	^ {
		self constants pathParameterName.
		self constants expandedParameterName.
		self constants showParameterName.
		self constants heightParameterName.
		}
]

{ #category : 'protected' }
GtIcebergFileAnnotation class >> tag [
	^ self constants icebergFileAnnotationName 
]

{ #category : 'visitor' }
GtIcebergFileAnnotation >> accept: aVisitor [
	^ aVisitor visitGt2IcebergFileAnnotation: self
]

{ #category : 'private - actions' }
GtIcebergFileAnnotation >> browseReferenceFrom: aBlClickEvent [ 
	aBlClickEvent modifiers isShift ifTrue: [ ^ self ].
	self doesReferenceExist ifFalse: [ ^ self inform: 'Input file does not exist' ].
	aBlClickEvent target phlow spawnObject: self fileReference
]

{ #category : 'testing' }
GtIcebergFileAnnotation >> doesReferenceExist [
	^ self fileReference ifNotNil: #exists ifNil: false
]

{ #category : 'accessing - parameter values' }
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

{ #category : 'testing' }
GtIcebergFileAnnotation >> isPreviewDefined [
	^ self doesReferenceExist
]

{ #category : 'testing' }
GtIcebergFileAnnotation >> isReferenceDefined [
	^ self fileReference notNil
]

{ #category : 'accessing' }
GtIcebergFileAnnotation >> objectToPreview [
	^ self fileReference
]

{ #category : 'accessing - parameter values' }
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

{ #category : 'accessing' }
GtIcebergFileAnnotation >> referenceParameterName [
	"Return an annotation parameter name that holds a referenced object"
	^ self constants pathParameterName
]

{ #category : 'accessing - parameter values' }
GtIcebergFileAnnotation >> referenceParameterValue [
	<return: #String>
	^ self utility 
		valueOf: self constants pathParameterName
		in: self parameters
		value: [ :aValue | aValue asString ]
		emptyValue: [ 'N/A' ] 
		defaultValue: [ 'N/A' ]
]

{ #category : 'api - style' }
GtIcebergFileAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self styleLinkInText: aBlRope.
	(self nodeStyler: aBlRope) 
		if: self isReferenceDefined
			do: [ :aStyler | aStyler 
				name: (self referenceParameterValue);
				spawnObject: self fileReference;
				splitURI;
				linkButton ].
	self styleExpandingPreviewInText: aBlRope.
]

{ #category : 'api - style' }
GtIcebergFileAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	(self nodeStyler: aBlRope)
		if: self isReferenceDefined 
			do: [ :aStyler | aStyler autoHideNode ]
			otherwise: [ :aStyler |
				aStyler 
					keepChildDisplayed: (self nodeFinder 
						annotationParameter: self referenceParameterName);
					autoHideNode ].
]
