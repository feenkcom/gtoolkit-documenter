Class {
	#name : #Gt2DocumentConstants,
	#superclass : #Object,
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #'pillar annotation names' }
Gt2DocumentConstants class >> changesAnnotationName [
	^ #changes2
]

{ #category : #'pillar annotation names' }
Gt2DocumentConstants class >> classAnnotationName [
	^ #class2
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> codeExpandedParameterName [
	^ #codeExpanded
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> codeHeightParameterName [
	^ #codeHeight
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> codeShowParameterName [
	^ #codeShow
]

{ #category : #'pillar parameter default values' }
Gt2DocumentConstants class >> defaultPreviewHeight [
	^ 300
]

{ #category : #ui }
Gt2DocumentConstants class >> defaultRunButtonLabel [
	"Default label used for example for button labels, [[[label=Run]]]"
	^ 'Run'
]

{ #category : #'pillar parameter default values' }
Gt2DocumentConstants class >> defaultShowSelector [
	^ #gtViewsFor:
]

{ #category : #'pillar annotation names' }
Gt2DocumentConstants class >> exampleAnnotationName [
	^ #example2
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> expandedParameterName [
	^ #expanded
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> fileParameterName [
	^ #file
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> heightParameterName [
	^ #height
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

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> resultExpandedParameterName [
	^ #resultExpanded
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> resultHeightParameterName [
	^ #resultHeight
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> resultShowParameterName [
	^ #resultShow
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> showParameterName [
	^ #show
]

{ #category : #colors }
Gt2DocumentConstants class >> subtleColor [
	^ Color gray
]
