Class {
	#name : #GtPillarMethodAnnotationHighlighter,
	#superclass : #GtPillarNodeHighlighter,
	#instVars : [
		'referencedMethod'
	],
	#category : #'GToolkit-Documenter-Pillar - Highlighter'
}

{ #category : #'api - actions' }
GtPillarMethodAnnotationHighlighter >> highlight [
	self initializeReferencedMethod.
	self stylePillarNodeText.
	self styleReferenceParameter.
	self styleExpandingView
]

{ #category : #private }
GtPillarMethodAnnotationHighlighter >> initializeReferencedMethod [
	referencedMethod := GtDocumenterUtility 
		valueOf: self constants nameParameterName
		in: self pillarNode parameters 
		value: [ :aValue | GtSystemUtility methodDefinitionFromString: aValue ] 
		emptyValue: [ nil ] 
		defaultValue: [ nil ]
]

{ #category : #'private - testing' }
GtPillarMethodAnnotationHighlighter >> isMethodDefined [
	"Return true if a method is defined in the system"
	^ referencedMethod notNil and: [ referencedMethod isDefined ]
]

{ #category : #'private - styling' }
GtPillarMethodAnnotationHighlighter >> styleExpandingView [
	| anAttributeCreatingBlock |
	self isMethodDefined ifFalse: [ ^ self ].
	anAttributeCreatingBlock := [ GtPillarMethodReferenceAttribute new
		methodReference: referencedMethod ].
	self pillarNode expandedViewParameterValue
		ifTrue: [ self styleExpandedTextExpandAttribute: anAttributeCreatingBlock ]
		ifFalse: [ self styleCollapsedTextExpandAttribute: anAttributeCreatingBlock ]
]

{ #category : #'private - styling' }
GtPillarMethodAnnotationHighlighter >> styleReferenceParameter [
	"Make class name clickable and red if the class does not exist"
	| aMethodParameterNode aClassColor theAttributes |
	aClassColor := self isMethodDefined 
		ifTrue: [ BrGlamorousColors linkColor ]
		ifFalse: [ BrGlamorousColors linkWithErrorColor ].
	aMethodParameterNode := self pillarNode children first children
		detect: [ :eachParameter | 
			eachParameter key = self pillarNode defaultParameterName or: [ 
				eachParameter value isNil ] ] 
		ifFound: [ :aParameter | aParameter ]
		ifNone: [ self pillarNode ].

	theAttributes := Array with: (BlTextForegroundAttribute new
					paint: aClassColor;	
					beNotOverwritableByStyler).
	self isMethodDefined ifTrue: [ 
		theAttributes := theAttributes , {
				BrTextHoverStylableAttribute new 
					beNotOverwritableByStyler;
					attribute: (BlTextBackgroundAttribute paint: (Color gray alpha: 0.2)).
				BrTextClickAttribute new 
					beNotOverwritableByStyler;
					action: [ :aText :aTarget :aTextEditor :anEvent | 
						self pillarNode browseMethodFrom: anEvent ] } ].

	(self targetText 
		from: aMethodParameterNode start 
		to: aMethodParameterNode stop) 
			attributes: theAttributes.
]
