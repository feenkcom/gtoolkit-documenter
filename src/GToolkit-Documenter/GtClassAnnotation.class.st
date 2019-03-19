Class {
	#name : #GtClassAnnotation,
	#superclass : #GtAnnotation,
	#instVars : [
		'referencedClass'
	],
	#category : #'GToolkit-Documenter-Model'
}

{ #category : #accessing }
GtClassAnnotation class >> possibleParameters [
	^ {
		self constants nameParameterName.
		self constants expandedParameterName.
		self constants showParameterName.
		self constants heightParameterName.
		}
]

{ #category : #protected }
GtClassAnnotation class >> tag [
	^ self constants classAnnotationName
]

{ #category : #visitor }
GtClassAnnotation >> accept: aVisitor [
	^ aVisitor visitGt2ClassAnnotation: self
]

{ #category : #'private - actions' }
GtClassAnnotation >> browseReferenceFrom: anEvent [
	anEvent modifiers isShift ifTrue: [ ^ self ].
	self isClassDefined ifFalse: [ ^ self inform: 'Class does not exist' ].
	anEvent target fireEvent: (GtPhlowObjectToSpawn new 
		object: self referencedClass realClass;
		sourceElement: anEvent target)
]

{ #category : #'api - style' }
GtClassAnnotation >> cursorLeftInText: aBlRope [
	self utility hideMarkupsInText: aBlRope start: self start stop: self stop
]

{ #category : #'accessing - parameter values' }
GtClassAnnotation >> defaultShowSelector [
	^ self constants defaultClassShowSelector
]

{ #category : #testing }
GtClassAnnotation >> doesReferenceExist [
	"Return true if a referenced object is defined"
	^ self isClassDefined
]

{ #category : #'announcement handling' }
GtClassAnnotation >> handleClassAddedOrRemovedAnnouncement: aClassAnnouncement [ 
	(self referencedClass notNil and: [ 
		(aClassAnnouncement classAffected name = self referencedClass name) or: [ 
			aClassAnnouncement classAffected originalName = self referencedClass name ]])
				ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #'announcement handling' }
GtClassAnnotation >> handleClassRenamedAnnouncement: aClassRenamed [ 
	(self referencedClass notNil and: [ 
			aClassRenamed newName = self referencedClass name or: [ 
				aClassRenamed oldName = self referencedClass name ]])
					ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #testing }
GtClassAnnotation >> isClassDefined [
	^ self referencedClass notNil and: [ self referencedClass isDefined ]
]

{ #category : #testing }
GtClassAnnotation >> isPreviewDefined [
	"Return true if a preview object is defined"
	^ self isClassDefined
]

{ #category : #accessing }
GtClassAnnotation >> objectToPreview [
	"Subclasses should define what object to preview"
	^ self referencedClass realClass
]

{ #category : #accessing }
GtClassAnnotation >> referenceParameterName [
	"Return an annotation parameter name that holds a referenced object"
	^ self constants nameParameterName
]

{ #category : #accessing }
GtClassAnnotation >> referencedClass [
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
GtClassAnnotation >> registerToSystemChanges [
	self gtDocument
		subscribe: ClassAdded, ClassRemoved
			send: #handleClassAddedOrRemovedAnnouncement:
			to: self
			for: self gtSubscriber;
		subscribe: ClassRenamed
			send: #handleClassRenamedAnnouncement:
			to: self
			for: self gtSubscriber;
		subscribe: GtDocumentUpdateRequestedAnnouncement
			send: #handleDocumentUpdateRequestedAnnouncement:
			to: self
			for: self gtSubscriber.
]

{ #category : #'api - style' }
GtClassAnnotation >> styleLinkButtonInText: aBlRope [
	(aBlRope from: self start to: self stop) 
		attribute: (GtButtonAttribute new
			beAppend;
			stencil: (GtButtonStencilBuilder new
				label: self referencedClass name;
				icon: BrGlamorousIcons inspect;
				action: [ :button | button phlow spawnObject: self referencedClass realClass] ))
]

{ #category : #'api - style' }
GtClassAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self styleLinkInText: aBlRope.
	self styleLinkButtonInText: aBlRope.
	self styleExpandingPreviewInText: aBlRope.
	self registerToSystemChanges
]

{ #category : #'api - style' }
GtClassAnnotation >> styleTextWithoutInteractions: aBlRope [
	| aLinkNode |
	aLinkNode := self utility linkNodeForAnnotation: self.
	(aBlRope from: aLinkNode start to: aLinkNode stop) glamorousCodeFont.
	self utility hideAllButLinkInText: aBlRope forAnnotation: self.
]

{ #category : #'api - style' }
GtClassAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	self utility mayHideMarkupsInText: aBlRope start: self start stop: self stop forNode: self.
"	(self utility mayHideAllButLinkInText: aBlRope forAnnotation: self) ifFalse: [ ^ self ].
"	self utility styleCursorAttributeInText: aBlRope forNode: self.
]
