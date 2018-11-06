Class {
	#name : #Gt2DocumentConstants,
	#superclass : #Object,
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #'pillar annotation names' }
Gt2DocumentConstants class >> classAnnotationName [
	^ #class2
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> expandedParameterName [
	^ #expanded
]

{ #category : #colors }
Gt2DocumentConstants class >> linkColor [
	^ BrGlamorousColors linkColor
]

{ #category : #colors }
Gt2DocumentConstants class >> linkWithErrorColor [
	^ BrGlamorousColors linkWithErrorColor
]

{ #category : #'pillar annotation names' }
Gt2DocumentConstants class >> methodAnnotationName [
	^ #method2
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> nameParameterName [
	^ #name
]

{ #category : #'pillar parameter default values' }
Gt2DocumentConstants class >> showDefaultValue [
	^ #gtViewsFor:
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> showParameterName [
	^ #show
]

{ #category : #colors }
Gt2DocumentConstants class >> subtleColor [
	^ Color gray
]
