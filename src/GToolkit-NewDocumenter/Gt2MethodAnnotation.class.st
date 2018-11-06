Class {
	#name : #Gt2MethodAnnotation,
	#superclass : #Gt2Annotation,
	#instVars : [
		'referencedMethod'
	],
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #accessing }
Gt2MethodAnnotation class >> possibleParameters [
	^ {
		self constants nameParameterName.
		self constants expandedViewParameterName 
		}
]

{ #category : #rendering }
Gt2MethodAnnotation class >> tag [
	^ self constants methodAnnotationName
]

{ #category : #'api - actions' }
Gt2MethodAnnotation >> browseMethodFrom: anEvent [
	self isMethodDefined ifFalse: [ ^ self inform: 'Method does not exists' ].
	anEvent target fireEvent: (GtPhlowObjectToSpawn new 
		object: self referencedMethod;
		sourceElement: anEvent target)
]

{ #category : #'as yet unclassified' }
Gt2MethodAnnotation >> handleMethodAnnouncement: aMethodModified [ 
	
]

{ #category : #testing }
Gt2MethodAnnotation >> isMethodDefined [
	"Return true if a method is defined in the system"
	^ self referencedMethod notNil and: [ self referencedMethod isDefined ]
]

{ #category : #accessing }
Gt2MethodAnnotation >> referencedMethod [
	<return: #RGMethodDefinition or: nil>
	^ referencedMethod ifNil: [ referencedMethod := GtDocumenterUtility 
		valueOf: self constants nameParameterName
		in: self parameters 
		value: [ :aValue | GtSystemUtility methodDefinitionFromString: aValue ] 
		emptyValue: [ nil ] 
		defaultValue: [ nil ] ]
]

{ #category : #'api - style' }
Gt2MethodAnnotation >> registerToSystemChangesFor: aBlRope [
	self gtDocument
		subscribe: MethodAdded, MethodModified, MethodRemoved
			send: #handleMethodAnnouncement:
			to: self
			for: aBlRope;
		subscribe: ClassAdded, ClassRemoved
			send: #handleClassAddedOrRemovedAnnouncement:
			to: self
			for: aBlRope;
		subscribe: ClassRenamed
			send: #handleClassRenamedAnnouncement:
			to: self
			for: aBlRope;
		subscribe: GtDocumentUpdateRequestedAnnouncement
			send: #handleDocumentUpdateRequestedAnnouncement:
			to: self
			for: aBlRope.
]

{ #category : #'api - style' }
Gt2MethodAnnotation >> styleInText: aBlRope [
	super styleInText: aBlRope.
	self styleReferenceParameterInText: aBlRope.
	self registerToSystemChangesFor: aBlRope.
]

{ #category : #'api - style' }
Gt2MethodAnnotation >> styleReferenceParameterInText: aBlRope [
	| aLinkColor aNodeToStyle theAttributes |
	aLinkColor := Gt2DocumentUtility linkColor: self isMethodDefined.
	aNodeToStyle := Gt2DocumentUtility 
		parameterNodeNamed: self constants nameParameterName forAnnotation: self.
	theAttributes := Array with: (BlTextForegroundAttribute new
					paint: aLinkColor).
	self isMethodDefined ifTrue: [ 
		theAttributes := theAttributes , {
				BrTextHoverAttribute new 
					removableTextAttribute: (BlTextBackgroundAttribute paint: (Color gray alpha: 0.2)).
				BrTextClickAttribute new 
					action: [ :aText :aTarget :anEvent | 
						self browseMethodFrom: anEvent ] } ].

	(aBlRope  
		from: aNodeToStyle start 
		to: aNodeToStyle stop) 
			attributes: theAttributes.
]
