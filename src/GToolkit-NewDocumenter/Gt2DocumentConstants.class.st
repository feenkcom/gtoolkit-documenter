Class {
	#name : #Gt2DocumentConstants,
	#superclass : #Object,
	#category : #'GToolkit-NewDocumenter-Model'
}

{ #category : #ui }
Gt2DocumentConstants class >> applyButtonIcon [
	^ BrGlamorousIcons accept
]

{ #category : #ui }
Gt2DocumentConstants class >> applyButtonLabel [
	^ 'Apply'
]

{ #category : #'pillar annotation names' }
Gt2DocumentConstants class >> changesAnnotationName [
	^ #changes
]

{ #category : #'pillar parameter default values' }
Gt2DocumentConstants class >> changesDefinitionShowSelector [
	^ #gtPreviewFor:
]

{ #category : #files }
Gt2DocumentConstants class >> changesFileExtension [
	^ '.ombu'
]

{ #category : #'pillar annotation names' }
Gt2DocumentConstants class >> classAnnotationName [
	^ #class
]

{ #category : #'pillar parameter default values' }
Gt2DocumentConstants class >> classDefinitionShowSelector [
	^ #gtDefinitionFor:
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> codeExpandedParameterName [
	^ #codeExpanded
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> codeHeightParameterName [
	^ #codeHeight
]

{ #category : #ui }
Gt2DocumentConstants class >> createButtonIcon [
	^ BrGlamorousIcons edit
]

{ #category : #ui }
Gt2DocumentConstants class >> createButtonLabel [
	^ 'Create'
]

{ #category : #'pillar parameter default values' }
Gt2DocumentConstants class >> defaultCodeHeight [
	"Zero means use a default Coder value"
	^ 0
]

{ #category : #'pillar parameter default values' }
Gt2DocumentConstants class >> defaultPreviewExpanded [
	^ false
]

{ #category : #'pillar parameter default values' }
Gt2DocumentConstants class >> defaultPreviewHeight [
	^ 300
]

{ #category : #'pillar parameter default values' }
Gt2DocumentConstants class >> defaultShowSelector [
	^ #gtViewsFor:
]

{ #category : #ui }
Gt2DocumentConstants class >> documentUserDataKey [
	^ #gtDocument
]

{ #category : #ui }
Gt2DocumentConstants class >> editButtonIcon [
	^ BrGlamorousIcons edit
]

{ #category : #ui }
Gt2DocumentConstants class >> editButtonLabel [
	^ 'Edit'
]

{ #category : #'pillar annotation names' }
Gt2DocumentConstants class >> exampleAnnotationName [
	^ #example
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> expandedParameterName [
	^ #expanded
]

{ #category : #'pillar parameter default values' }
Gt2DocumentConstants class >> figureShowSelector [
	^ #gtPngFor:
]

{ #category : #text }
Gt2DocumentConstants class >> headerFontSize [
	^ 27
]

{ #category : #text }
Gt2DocumentConstants class >> headerLevelStep [
	^ 2
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> heightParameterName [
	^ #height
]

{ #category : #'pillar annotation names' }
Gt2DocumentConstants class >> icebergFileAnnotationName [
	^ #icebergFile
]

{ #category : #'pillar annotation names' }
Gt2DocumentConstants class >> inputFileAnnotationName [
	^ PRInputFileAnnotation tag
]

{ #category : #'changes diff' }
Gt2DocumentConstants class >> insertLineColor [
	^ Color green muchDarker
]

{ #category : #'changes diff' }
Gt2DocumentConstants class >> insertLineIdentificator [
	^ '+ '
]

{ #category : #colors }
Gt2DocumentConstants class >> linkColor [
	^ BrGlamorousColors linkColor
]

{ #category : #colors }
Gt2DocumentConstants class >> linkWithErrorColor [
	^ BrGlamorousColors linkWithErrorColor
]

{ #category : #files }
Gt2DocumentConstants class >> localGtDirectory [
	<return: #FileReference>
	^ Smalltalk imageDirectory / self localGtDirectoryName
]

{ #category : #files }
Gt2DocumentConstants class >> localGtDirectoryName [
	^ 'gt-extra'
]

{ #category : #'changes diff' }
Gt2DocumentConstants class >> matchLineColor [
	^ Color black
]

{ #category : #'changes diff' }
Gt2DocumentConstants class >> matchLineIdentificator [
	^ '  '
]

{ #category : #'pillar annotation names' }
Gt2DocumentConstants class >> methodAnnotationName [
	^ #method
]

{ #category : #'pillar parameter default values' }
Gt2DocumentConstants class >> methodDefinitionShowSelector [
	^ #gtSourceFor:
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> nameParameterName [
	^ #name
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> noCodeParameterName [
	^ #noCode
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> pathParameterName [
	^ #path
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> previewExpandedParameterName [
	^ #previewExpanded
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> previewHeightParameterName [
	^ #previewHeight
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> previewShowParameterName [
	^ #previewShow
]

{ #category : #'changes diff' }
Gt2DocumentConstants class >> removeLineColor [
	^ Color red muchDarker
]

{ #category : #'changes diff' }
Gt2DocumentConstants class >> removeLineIdentificator [
	^ '- '
]

{ #category : #ui }
Gt2DocumentConstants class >> runButtonIcon [
	^ BrGlamorousIcons play
]

{ #category : #ui }
Gt2DocumentConstants class >> runButtonLabel [
	"Default label used for example for button labels, [[[label=Run]]]"
	^ 'Run'
]

{ #category : #ui }
Gt2DocumentConstants class >> saveButtonIcon [
	^ self applyButtonIcon
]

{ #category : #ui }
Gt2DocumentConstants class >> saveButtonLabel [
	^ 'Save'
]

{ #category : #'pillar parameter names' }
Gt2DocumentConstants class >> showParameterName [
	^ #show
]

{ #category : #colors }
Gt2DocumentConstants class >> subtleColor [
	^ Color gray
]

{ #category : #text }
Gt2DocumentConstants class >> superscriptFontSize [
	^ 9
]
