Class {
	#name : #GtPillarInputFileAnnotationHighlighter,
	#superclass : #GtPillarNodeHighlighter,
	#instVars : [
		'fileReference'
	],
	#category : #'GToolkit-Documenter-Pillar - Highlighter'
}

{ #category : #'private - actions' }
GtPillarInputFileAnnotationHighlighter >> browseFileFrom: anEvent [
	fileReference exists ifFalse: [ ^ self inform: 'Input file does not exist' ].
	anEvent target fireEvent: (GLMBlocObjectToSelect new toSelect: fileReference).
	anEvent target fireEvent: (GtPhlowObjectToSpawn new 
		object: fileReference;
		sourceElement: anEvent target)
]

{ #category : #'api - actions' }
GtPillarInputFileAnnotationHighlighter >> highlight [
	self initializeFileReference.
	self stylePillarNodeText.
	self styleReferenceParameter.
	self styleExpandingView
]

{ #category : #initialization }
GtPillarInputFileAnnotationHighlighter >> initializeFileReference [
	GtDocumenterUtility 
		valueOf: self constants pathParameterName
		in: self pillarNode parameters 
		value: [ :aValue | 
			| aFile |
			aFile := aValue asFileReference.
			aFile exists ifTrue: [ fileReference := aFile. ^ self ].
			aFile := GtFileUtility 
					fileReferenceOfFileName: aValue 
					relativeTo: self documentDirectory.
			aFile exists ifTrue: [ fileReference := aFile ] ] 
		emptyValue: [ "do nothing" ] 
		defaultValue: [ "do nothing" ]
]

{ #category : #'private - testing' }
GtPillarInputFileAnnotationHighlighter >> isExistingFile [
	^ fileReference notNil and: [ fileReference exists ]
]

{ #category : #'private - styling' }
GtPillarInputFileAnnotationHighlighter >> styleExpandingView [
	| anAttributeCreatingBlock |
	self isExistingFile ifFalse: [ ^ self ].
	anAttributeCreatingBlock := [ GtPillarInputFileReferenceAttribute new
		fileReference: fileReference ].
	self styleCollapsedTextExpandAttribute: anAttributeCreatingBlock
]

{ #category : #'private - styling' }
GtPillarInputFileAnnotationHighlighter >> styleReferenceParameter [
	"Make class name clickable and red if the class does not exist"
	| aPathParameterNode aPathColor theAttributes |
	self isExistingFile 
		ifTrue: [ aPathColor := BrGlamorousColors linkColor ]
		ifFalse: [ aPathColor := BrGlamorousColors linkWithErrorColor ].
	aPathParameterNode := self pillarNode children first children
		detect: [ :eachParameter | 
			eachParameter key = self constants pathParameterName ] 
		ifFound: [ :aParameter | aParameter ]
		ifNone: [ self pillarNode ].

	theAttributes := Array with: (BlTextForegroundAttribute new
					paint: aPathColor;	
					beNotOverwritableByStyler).
	self isExistingFile ifTrue: [ 
		theAttributes := theAttributes , {
				BrTextHoverStylableAttribute new 
					beNotOverwritableByStyler;
					attribute: (BlTextBackgroundAttribute paint: (Color gray alpha: 0.2)).
				BrTextClickAttribute new 
					beNotOverwritableByStyler;
					action: [ :aText :aTarget :anEditorElement :anEvent | 
						self browseFileFrom: anEvent ] } ].

	(self targetText 
		from: aPathParameterNode start 
		to: aPathParameterNode stop) 
			attributes: theAttributes.
]
