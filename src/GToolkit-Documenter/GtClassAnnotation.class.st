Class {
	#name : #GtClassAnnotation,
	#superclass : #GtAnnotation,
	#instVars : [
		'referencedClass'
	],
	#category : #'GToolkit-Documenter-Annotations'
}

{ #category : #accessing }
GtClassAnnotation class >> possibleParameters [
	^ {
		self constants nameParameterName.
		"rendering"
		self constants labelParameterName.
		"full view"
		self constants fullViewParameterName.
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
	anEvent target phlow spawnObject: self referencedClass realClass
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
GtClassAnnotation >> isLabelParameterValueDefined [
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
GtClassAnnotation >> isPreviewDefined [
	"Return true if a preview object is defined"
	^ self isClassDefined
]

{ #category : #'accessing - parameter values' }
GtClassAnnotation >> labelParameterValue [
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
GtClassAnnotation >> labelText [
	"Return a displayed class name (that can be anything)"
	<return: #String>
	| anInlineValue |
	anInlineValue := self labelParameterValue.
	anInlineValue isSymbol ifFalse: [ ^ anInlineValue asString ].
	^ [ (anInlineValue value: self referencedClass realClass) asString ]
		on: Error 
		do: [ :anException | anException printString ]
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
GtClassAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	self styleLinkInText: aBlRope.
	(self nodeStyler: aBlRope) 
		if: self isClassDefined
			do: [ :aStyler | aStyler 
				name: [ self labelText ];
				spawnObject: [ self referencedClass realClass ];
				splitCamelCase;
				linkButton ].
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
	(self nodeStyler: aBlRope)
		if: self isClassDefined 
			do: [ :aStyler | aStyler autoHideNode ]
			otherwise: [ :aStyler |
				aStyler 
					keepChildDisplayed: (self nodeFinder 
						annotationParameter: self referenceParameterName);
					autoHideNode ].
]
