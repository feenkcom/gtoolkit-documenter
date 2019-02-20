Class {
	#name : #XdDocsAnnotation,
	#superclass : #GtAnnotation,
	#instVars : [
		'client'
	],
	#category : #'GToolkit-Documenter-XDoc-Model'
}

{ #category : #accessing }
XdDocsAnnotation class >> possibleParameters [
	^ {
		self constants expandedParameterName.
		self constants heightParameterName.
		}
]

{ #category : #protected }
XdDocsAnnotation class >> tag [
	^ self constants xdocListAnnotationName
]

{ #category : #accessing }
XdDocsAnnotation >> accept: aVisitor [
	^ aVisitor visitGt2XDocsAnnotation: self
]

{ #category : #'private - actions' }
XdDocsAnnotation >> browseReferenceFrom: anEvent [
	"Ignore, should not happen"
]

{ #category : #accessing }
XdDocsAnnotation >> client [
	<return: #XdClient>
	^ client
]

{ #category : #accessing }
XdDocsAnnotation >> client: anXdClient [
	self
		assert: [ anXdClient notNil ] 
		description: [ 'XDoc client must be non-nil' ].
	client := anXdClient.
]

{ #category : #'api - style' }
XdDocsAnnotation >> cursorLeftInText: aBlRope [
	self utility hideMarkupsInText: aBlRope start: self start stop: self stop
]

{ #category : #'accessing - parameter values' }
XdDocsAnnotation >> defaultShowSelector [
	^ self constants defaultXDocsShowSelector
]

{ #category : #testing }
XdDocsAnnotation >> doesReferenceExist [
	"Return true if a referenced object is defined"
	^ false
]

{ #category : #'accessing - parameter values' }
XdDocsAnnotation >> expandedDefaultValue [
	^ true
]

{ #category : #initialization }
XdDocsAnnotation >> initialize [
	super initialize.
	client := XdClient new.
]

{ #category : #testing }
XdDocsAnnotation >> isPreviewDefined [
	"Return true if a preview object is defined"
	^ true
]

{ #category : #accessing }
XdDocsAnnotation >> objectToPreview [
	"Subclasses should define what object to preview"
	^ self client
]

{ #category : #'api - style' }
XdDocsAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
]

{ #category : #'api - style' }
XdDocsAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	self utility mayHideMarkupsInText: aBlRope start: self start stop: self stop forNode: self.
	self utility styleCursorAttributeInText: aBlRope forNode: self.
]
