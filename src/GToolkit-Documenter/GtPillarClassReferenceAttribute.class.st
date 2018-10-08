Class {
	#name : #GtPillarClassReferenceAttribute,
	#superclass : #GtPillarPharoTextEditorAttribute,
	#instVars : [
		'classReference'
	],
	#category : #'GToolkit-Documenter-Brick'
}

{ #category : #accessing }
GtPillarClassReferenceAttribute >> classReference [
	^ classReference
]

{ #category : #accessing }
GtPillarClassReferenceAttribute >> classReference: aClass [
	classReference := aClass asRingDefinition
]

{ #category : #initialization }
GtPillarClassReferenceAttribute >> initialize [
	super initialize.
	classReference := self class asRingDefinition.
]

{ #category : #'instance creation' }
GtPillarClassReferenceAttribute >> newStyler [
	^ BrRBTextStyler new workspace: GtHighlightingBindingStrategy new
]

{ #category : #accessing }
GtPillarClassReferenceAttribute >> textEditorText [
	<return: #BlText>
	^ self classReference isDefined 
		ifTrue: [ self classReference realClass definition asRopedText ]
		ifFalse: [ self classReference definition asRopedText ]
]
