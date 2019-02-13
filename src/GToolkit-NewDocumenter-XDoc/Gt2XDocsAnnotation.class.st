Class {
	#name : #Gt2XDocsAnnotation,
	#superclass : #Gt2Annotation,
	#instVars : [
		'client'
	],
	#category : #'GToolkit-NewDocumenter-XDoc-Model'
}

{ #category : #accessing }
Gt2XDocsAnnotation class >> possibleParameters [
	^ {
		self constants expandedParameterName.
		self constants heightParameterName.
		}
]

{ #category : #protected }
Gt2XDocsAnnotation class >> tag [
	^ self constants xdocListAnnotationName
]

{ #category : #accessing }
Gt2XDocsAnnotation >> accept: aVisitor [
	^ aVisitor visitGt2XDocsAnnotation: self
]

{ #category : #'private - actions' }
Gt2XDocsAnnotation >> browseReferenceFrom: anEvent [
	"Ignore, should not happen"
]

{ #category : #accessing }
Gt2XDocsAnnotation >> client [
	<return: #XdClient>
	^ client
]

{ #category : #accessing }
Gt2XDocsAnnotation >> client: anXdClient [
	self
		assert: [ anXdClient notNil ] 
		description: [ 'XDoc client must be non-nil' ].
	client := anXdClient.
]

{ #category : #'api - style' }
Gt2XDocsAnnotation >> cursorLeftInText: aBlRope [
	self utility hideMarkupsInText: aBlRope start: self start stop: self stop
]

{ #category : #'accessing - parameter values' }
Gt2XDocsAnnotation >> defaultShowSelector [
	^ self constants defaultXDocsShowSelector
]

{ #category : #testing }
Gt2XDocsAnnotation >> doesReferenceExist [
	"Return true if a referenced object is defined"
	^ false
]

{ #category : #'accessing - parameter values' }
Gt2XDocsAnnotation >> expandedDefaultValue [
	^ true
]

{ #category : #initialization }
Gt2XDocsAnnotation >> initialize [
	super initialize.
	client := XdClient new.
]

{ #category : #testing }
Gt2XDocsAnnotation >> isPreviewDefined [
	"Return true if a preview object is defined"
	^ true
]

{ #category : #accessing }
Gt2XDocsAnnotation >> objectToPreview [
	"Subclasses should define what object to preview"
	^ self client
]

{ #category : #'api - style' }
Gt2XDocsAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
]

{ #category : #'api - style' }
Gt2XDocsAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	self utility mayHideMarkupsInText: aBlRope start: self start stop: self stop forNode: self.
	self utility styleCursorAttributeInText: aBlRope forNode: self.
]
