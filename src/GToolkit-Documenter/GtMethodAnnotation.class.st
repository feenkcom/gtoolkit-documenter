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
		"customized name"
		self constants labelParameterName.
		"full view"
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
	anEvent target phlow spawnObject: self referencedMethod
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
GtMethodAnnotation >> isLabelParameterValueDefined [
	"Return true if an inlined parameter is properly defined"
	<return: #Boolean>
	^ self utility 
		valueOf: self constants labelParameterName 
		in: self parameters
		value: [ :aSymbol | true ]
		emptyValue: [ false ]
		defaultValue: [ false ].
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

{ #category : #'accessing - parameter values' }
GtMethodAnnotation >> labelParameterValue [
	<return: #Symbol>
	^ self utility 
		valueOf: self constants labelParameterName 
		in: self parameters
		value: [ :aSymbol | aSymbol isSymbol 
			ifTrue: [ aSymbol ]
			ifFalse: [ aSymbol asString ] ]
		emptyValue: [ self constants defaultInlineValue ]
		defaultValue: [ self constants defaultInlineValue ]
]

{ #category : #'private - accessing' }
GtMethodAnnotation >> labelText [
	"Return a displayed class name (that can be anything)"
	<return: #String>
	| anInlineValue |
	anInlineValue := self labelParameterValue.
	anInlineValue isSymbol ifFalse: [ ^ anInlineValue asString ].
	^ [ (anInlineValue value: self referencedMethod) asString ]
		on: Error 
		do: [ :anException | anException printString ]
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
		when: MethodAdded , MethodRemoved
			send: #handleMethodAnnouncement:
			to: self
			for: self gtSubscriber;
		when: ClassAdded , ClassRemoved
			send: #handleClassAddedOrRemovedAnnouncement:
			to: self
			for: self gtSubscriber;
		when: ClassRenamed
			send: #handleClassRenamedAnnouncement:
			to: self
			for: self gtSubscriber;
		when: GtDocumentUpdateRequestedAnnouncement
			send: #handleDocumentUpdateRequestedAnnouncement:
			to: self
			for: self gtSubscriber
]

{ #category : #'api - style' }
GtMethodAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self styleLinkInText: aBlRope.
	(self nodeStyler: aBlRope) 
		if: self isMethodDefined
			do: [ :aStyler | aStyler 
				name: [ self labelText ];
				spawnObject: [ self referencedMethod ];
				splitCamelCase;
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
