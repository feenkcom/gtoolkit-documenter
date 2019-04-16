Class {
	#name : #GtMethodAnnotation,
	#superclass : #GtAnnotation,
	#instVars : [
		'referencedMethod'
	],
	#category : #'GToolkit-Documenter-Annotations'
}

{ #category : #accessing }
GtMethodAnnotation class >> possibleParameters [
	^ {
		self constants nameParameterName.
		self constants expandedParameterName.
		self constants showParameterName.
		self constants heightParameterName.
		}
]

{ #category : #rendering }
GtMethodAnnotation class >> tag [
	^ self constants methodAnnotationName
]

{ #category : #visitor }
GtMethodAnnotation >> accept: aVisitor [
	^ aVisitor visitGt2MethodAnnotation: self
]

{ #category : #'private - actions' }
GtMethodAnnotation >> browseReferenceFrom: anEvent [
	anEvent modifiers isShift ifTrue: [ ^ self ].
	self isMethodDefined ifFalse: [ ^ self inform: 'Method does not exist' ].
	anEvent target fireEvent: (GtPhlowObjectToSpawn new 
		object: self referencedMethod;
		sourceElement: anEvent target)
]

{ #category : #'api - style' }
GtMethodAnnotation >> cursorLeftInText: aBlRope [
	self utility hideAllButLinkInText: aBlRope forAnnotation: self
]

{ #category : #'accessing - parameter values' }
GtMethodAnnotation >> defaultShowSelector [
	^ self constants defaultMethodShowSelector
]

{ #category : #testing }
GtMethodAnnotation >> doesReferenceExist [
	"Return true if a referenced object is defined"
	^ self isMethodDefined 
]

{ #category : #'announcement handling' }
GtMethodAnnotation >> handleClassAddedOrRemovedAnnouncement: aClassAdded [ 
	(self referencedMethod notNil and: [ 
		aClassAdded classAffected originalName = self referencedMethod parentName ])
			ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #'announcement handling' }
GtMethodAnnotation >> handleClassRenamedAnnouncement: aClassRenamed [ 
	(self referencedMethod notNil and: [ 
			aClassRenamed newName = self referencedMethod parentName or: [ 
				aClassRenamed oldName = self referencedMethod parentName ] ])
			ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #'announcement handling' }
GtMethodAnnotation >> handleMethodAnnouncement: aMethodModified [ 
	(self referencedMethod notNil and: [ 
		aMethodModified classAffected name = self referencedMethod parentName  
			and: [ aMethodModified selector = self referencedMethod selector ]])
				ifFalse: [ ^ self ].
	self gtDocument styleTextRequest
]

{ #category : #testing }
GtMethodAnnotation >> isMethodDefined [
	"Return true if a method is defined in the system"
	^ self referencedMethod notNil and: [ self referencedMethod isDefined ]
]

{ #category : #testing }
GtMethodAnnotation >> isPreviewDefined [
	"Return true if a preview object is defined"
	^ self isMethodDefined
]

{ #category : #accessing }
GtMethodAnnotation >> objectToPreview [
	"Subclasses should define what object to preview"
	^ self referencedMethod
]

{ #category : #accessing }
GtMethodAnnotation >> referenceParameterName [
	"Return an annotation parameter name that holds a referenced object"
	^ self constants nameParameterName
]

{ #category : #'accessing - parameter values' }
GtMethodAnnotation >> referencedMethod [
	<return: #RGMethodDefinition or: nil>
	^ referencedMethod ifNil: [ referencedMethod := self utility 
		valueOf: self constants nameParameterName
		in: self parameters 
		value: [ :aValue | GtSystemUtility methodDefinitionFromString: aValue ] 
		emptyValue: [ nil ] 
		defaultValue: [ nil ] ]
]

{ #category : #subscriptions }
GtMethodAnnotation >> registerToSystemChanges [
	self gtDocument
		subscribe: MethodAdded, MethodRemoved
			send: #handleMethodAnnouncement:
			to: self
			for: self gtSubscriber;
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
GtMethodAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self styleLinkInText: aBlRope.
	(self nodeStyler: aBlRope) 
		if: self isMethodDefined
			do: [ :aStyler | aStyler 
				name: self referencedMethod;
				spawnObject: self referencedMethod;
				linkButton ].
	self styleExpandingPreviewInText: aBlRope.
	self registerToSystemChanges
]

{ #category : #'api - style' }
GtMethodAnnotation >> styleTextWithoutInteractions: aBlRope [
	| aLinkNode |
	aLinkNode := self utility linkNodeForAnnotation: self.
	(aBlRope from: aLinkNode start to: aLinkNode stop) glamorousCodeFont.
	self utility hideAllButLinkInText: aBlRope forAnnotation: self.
]

{ #category : #'api - style' }
GtMethodAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope.
	super styleTextWithoutMarkup: aBlRope.
	(self nodeStyler: aBlRope)
		if: self isMethodDefined 
		do: [ :aStyler | aStyler autoHideNode ]
		otherwise: [ :aStyler |
				aStyler 
					keepChildDisplayed: (self nodeFinder 
						annotationParameter: self referenceParameterName);
					autoHideNode ].
]
