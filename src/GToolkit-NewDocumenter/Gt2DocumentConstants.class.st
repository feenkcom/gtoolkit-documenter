Class {
	#name : #Gt2DocumentConstants,
	#superclass : #Object,
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> expandedViewParameterName [
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

{ #category : #colors }
Gt2DocumentConstants class >> subtleColor [
	^ Color gray
]
