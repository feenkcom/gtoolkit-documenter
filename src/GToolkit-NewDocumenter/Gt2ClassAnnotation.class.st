Class {
	#name : #Gt2ClassAnnotation,
	#superclass : #Gt2Annotation,
	#instVars : [
		'referencedClass'
	],
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #accessing }
Gt2ClassAnnotation class >> possibleParameters [
	^ {
		self constants nameParameterName.
		self constants expandedParameterName.
		self constants showParameterName.
		self constants heightParameterName.
		}
]

{ #category : #protected }
Gt2ClassAnnotation class >> tag [
	^ self constants classAnnotationName
]

{ #category : #visitor }
Gt2ClassAnnotation >> accept: aVisitor [
	^ aVisitor visitGt2ClassAnnotation: self
]

{ #category : #'private - actions' }
Gt2ClassAnnotation >> browseReferenceFrom: anEvent [
	anEvent modifiers isShift ifTrue: [ ^ self ].
	self isClassDefined ifFalse: [ ^ self inform: 'Class does not exist' ].
	anEvent target fireEvent: (GtPhlowObjectToSpawn new 
		object: self referencedClass realClass;
		sourceElement: anEvent target)
]

{ #category : #'api - style' }
Gt2ClassAnnotation >> cursorLeftInText: aBlRope [
	self utility hideAllButLinkInText: aBlRope forAnnotation: self
]

{ #category : #'accessing - parameter values' }
Gt2ClassAnnotation >> defaultShowSelector [
	^ self constants defaultClassShowSelector
]

{ #category : #'announcement handling' }
Gt2ClassAnnotation >> handleClassAddedOrRemovedAnnouncement: aClassAnnouncement [ 
	(self referencedClass notNil and: [ 
		(aClassAnnouncement classAffected name = self referencedClass name) or: [ 
			aClassAnnouncement classAffected originalName = self referencedClass name ]])
				ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #'announcement handling' }
Gt2ClassAnnotation >> handleClassRenamedAnnouncement: aClassRenamed [ 
	(self referencedClass notNil and: [ 
			aClassRenamed newName = self referencedClass name or: [ 
				aClassRenamed oldName = self referencedClass name ]])
					ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #testing }
Gt2ClassAnnotation >> isClassDefined [
	^ self referencedClass notNil and: [ self referencedClass isDefined ]
]

{ #category : #testing }
Gt2ClassAnnotation >> isPreviewDefined [
	"Return true if a preview object is defined"
	^ self isClassDefined
]

{ #category : #testing }
Gt2ClassAnnotation >> isReferenceDefined [
	"Return true if a referenced object is defined"
	^ self isClassDefined
]

{ #category : #accessing }
Gt2ClassAnnotation >> objectToPreview [
	"Subclasses should define what object to preview"
	^ self referencedClass realClass
]

{ #category : #accessing }
Gt2ClassAnnotation >> referenceParameterName [
	"Return an annotation parameter name that holds a referenced object"
	^ self constants nameParameterName
]

{ #category : #accessing }
Gt2ClassAnnotation >> referencedClass [
	<return: #RGClassDefinition or: nil>
	^ referencedClass ifNil: [ referencedClass := 
		self utility 
			valueOf: self constants nameParameterName
			in: self parameters 
			value: [ :aValue | GtSystemUtility classDefinitionFromString: aValue ] 
			emptyValue: [ nil ] 
			defaultValue: [ nil ] ]
]

{ #category : #subscriptions }
Gt2ClassAnnotation >> registerToSystemChanges [
	self gtDocument
		subscribe: ClassAdded, ClassRemoved
			send: #handleClassAddedOrRemovedAnnouncement:
			to: self
			for: self gtSubscriber;
		subscribe: ClassRenamed
			send: #handleClassRenamedAnnouncement:
			to: self
			for: self gtSubscriber;
		subscribe: Gt2DocumentUpdateRequestedAnnouncement
			send: #handleDocumentUpdateRequestedAnnouncement:
			to: self
			for: self gtSubscriber.
]

{ #category : #'api - style' }
Gt2ClassAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self styleLinkInText: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
	self registerToSystemChanges
]

{ #category : #'api - style' }
Gt2ClassAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	(self utility hideAllButLinkInText: aBlRope forAnnotation: self) ifFalse: [ ^ self ].
	self utility styleCursorAttributeInText: aBlRope forNode: self.
]
