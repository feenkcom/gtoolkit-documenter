Class {
	#name : #GtPillarClassAnnotationHighlighter,
	#superclass : #GtPillarNodeHighlighter,
	#instVars : [
		'referencedClass'
	],
	#category : #'GToolkit-Documenter-Pillar - Highlighter'
}

{ #category : #'api - actions' }
GtPillarClassAnnotationHighlighter >> highlight [
	self initializeReferencedClass.
	self stylePillarNodeText.
	self styleReferenceParameter.
	self styleExpandingView
]

{ #category : #initialization }
GtPillarClassAnnotationHighlighter >> initializeReferencedClass [
	referencedClass := GtDocumenterUtility 
		valueOf: self constants nameParameterName
		in: self pillarNode parameters 
		value: [ :aValue | GtSystemUtility classDefinitionFromString: aValue ] 
		emptyValue: [ "do nothing" ] 
		defaultValue: [ "do nothing" ]
]

{ #category : #'private - testing' }
GtPillarClassAnnotationHighlighter >> isClassDefined [
	^ referencedClass notNil and: [ referencedClass isDefined ]
]

{ #category : #'private - styling' }
GtPillarClassAnnotationHighlighter >> styleExpandingView [
	| anAttributeCreatingBlock |
	self isClassDefined ifFalse: [ ^ self ].
	anAttributeCreatingBlock := [ GtPillarClassReferenceAttribute new
		classReference: referencedClass ].
	self pillarNode expandedViewParameterValue
		ifTrue: [ self styleExpandedTextExpandAttribute: anAttributeCreatingBlock ]
		ifFalse: [ self styleCollapsedTextExpandAttribute: anAttributeCreatingBlock ]
]

{ #category : #'private - styling' }
GtPillarClassAnnotationHighlighter >> styleReferenceParameter [
	"Make class name clickable and red if the class does not exist"
	| aClassParameterNode aClassColor theAttributes |
	self isClassDefined 
		ifTrue: [ aClassColor := BrGlamorousColors linkColor ]
		ifFalse: [ aClassColor := BrGlamorousColors linkWithErrorColor ].
	aClassParameterNode := self pillarNode children first children
		detect: [ :eachParameter | 
			eachParameter key = self constants nameParameterName ] 
		ifFound: [ :aParameter | aParameter ]
		ifNone: [ self pillarNode ].

	theAttributes := Array with: (BlTextForegroundAttribute new
					paint: aClassColor;	
					beNotOverwritableByStyler).
	self isClassDefined ifTrue: [ 
		theAttributes := theAttributes , {
				BrTextHoverStylableAttribute new 
					beNotOverwritableByStyler;
					attribute: (BlTextBackgroundAttribute paint: (Color gray alpha: 0.2)).
				BrTextClickAttribute new 
					beNotOverwritableByStyler;
					action: [ :aText :aTarget :anEditorElement :anEvent | 
						self pillarNode browseClassFrom: anEvent ] } ].

	(self targetText 
		from: aClassParameterNode start 
		to: aClassParameterNode stop) 
			attributes: theAttributes.
]
