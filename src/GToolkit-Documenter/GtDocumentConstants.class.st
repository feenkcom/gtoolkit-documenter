Class {
	#name : #GtDocumentConstants,
	#superclass : #Object,
	#category : #'GToolkit-Documenter-Utility'
}

{ #category : #ui }
GtDocumentConstants class >> applyButtonIcon [
	^ BrGlamorousIcons accept
]

{ #category : #ui }
GtDocumentConstants class >> applyButtonLabel [
	^ 'Apply'
]

{ #category : #'pillar annotation names' }
GtDocumentConstants class >> changesAnnotationName [
	^ #changes
]

{ #category : #files }
GtDocumentConstants class >> changesFileExtension [
	^ '.ombu'
]

{ #category : #'pillar annotation names' }
GtDocumentConstants class >> classAnnotationName [
	^ #class
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> classesParameterName [
	^ #classes
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> codeExpandedParameterName [
	^ #codeExpanded
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> codeHeightParameterName [
	^ #codeHeight
]

{ #category : #ui }
GtDocumentConstants class >> createButtonIcon [
	^ BrGlamorousIcons edit
]

{ #category : #ui }
GtDocumentConstants class >> createButtonLabel [
	^ 'Create'
]

{ #category : #text }
GtDocumentConstants class >> cursorNearbyDistance [
	^ 0
]

{ #category : #'pillar parameter default values' }
GtDocumentConstants class >> defaultChangesShowSelector [
	^ #gtPreviewFor:
]

{ #category : #'pillar parameter default values' }
GtDocumentConstants class >> defaultClassShowSelector [
	^ #gtDefinitionFor:
]

{ #category : #'pillar parameter default values' }
GtDocumentConstants class >> defaultCodeHeight [
	"Zero means use a default Coder value"
	^ 0
]

{ #category : #'pillar parameter default values' }
GtDocumentConstants class >> defaultExamplesShowSelector [
	^ #gtExpandableExamplesFor: "#gtExamplesFor:"
]

{ #category : #'pillar parameter default values' }
GtDocumentConstants class >> defaultFigureShowSelector [
	^ #gtFigureFor:
]

{ #category : #'pillar parameter default values' }
GtDocumentConstants class >> defaultMethodShowSelector [
	^ #gtSourceFor:
]

{ #category : #'pillar parameter default values' }
GtDocumentConstants class >> defaultPreviewExpanded [
	^ false
]

{ #category : #'pillar parameter default values' }
GtDocumentConstants class >> defaultPreviewHeight [
	^ 300
]

{ #category : #'pillar parameter default values' }
GtDocumentConstants class >> defaultShowSelector [
	^ #gtViewsFor:
]

{ #category : #ui }
GtDocumentConstants class >> documentUserDataKey [
	^ #gtDocument
]

{ #category : #ui }
GtDocumentConstants class >> editButtonIcon [
	^ BrGlamorousIcons edit
]

{ #category : #ui }
GtDocumentConstants class >> editButtonLabel [
	^ 'Edit'
]

{ #category : #ui }
GtDocumentConstants class >> editingModeIcon [
	^ BrGlamorousIcons edit 
]

{ #category : #colors }
GtDocumentConstants class >> errorColor [
	^ BrGlamorousColors errorBorderColor
]

{ #category : #'pillar annotation names' }
GtDocumentConstants class >> exampleAnnotationName [
	^ #example
]

{ #category : #'pillar annotation names' }
GtDocumentConstants class >> examplesAnnotationName [
	^ #examples
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> expandedParameterName [
	^ #expanded
]

{ #category : #files }
GtDocumentConstants class >> exportedResultsDirectoryName [
	<return: #String>
	^ 'gt-figures'
]

{ #category : #files }
GtDocumentConstants class >> exportedResultsDirectoryPath [
	<return: #RelativePath>
	^ Path * self exportedResultsDirectoryName
]

{ #category : #files }
GtDocumentConstants class >> exportedResultsExtension [
	<return: #String>
	^ 'png'
]

{ #category : #text }
GtDocumentConstants class >> headerFontSize [
	^ 27
]

{ #category : #text }
GtDocumentConstants class >> headerLevelStep [
	^ 2
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> heightParameterName [
	^ #height
]

{ #category : #ui }
GtDocumentConstants class >> horizontalLineHeight [
	^ 1
]

{ #category : #'pillar annotation names' }
GtDocumentConstants class >> icebergFileAnnotationName [
	^ #icebergFile
]

{ #category : #files }
GtDocumentConstants class >> icebergRepositoriesLocation [
	<return: #FileReference>
	^ GtIcebergUtility repositoriesLocation
]

{ #category : #ui }
GtDocumentConstants class >> infoButtonIcon [
	^ BrGlamorousIcons inspect
]

{ #category : #'pillar annotation names' }
GtDocumentConstants class >> inputFileAnnotationName [
	^ PRInputFileAnnotation tag
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> inputVariablesParameterName [
	^ #variables
]

{ #category : #'changes diff' }
GtDocumentConstants class >> insertLineColor [
	^ Color green muchDarker
]

{ #category : #'changes diff' }
GtDocumentConstants class >> insertLineIdentificator [
	^ '+ '
]

{ #category : #ui }
GtDocumentConstants class >> issuesButtonLabel [
	^ 'Issues'
]

{ #category : #text }
GtDocumentConstants class >> labelFontSize [
	^ 12
]

{ #category : #colors }
GtDocumentConstants class >> linkColor [
	^ BrGlamorousColors linkColor
]

{ #category : #colors }
GtDocumentConstants class >> linkWithErrorColor [
	^ BrGlamorousColors linkWithErrorColor
]

{ #category : #files }
GtDocumentConstants class >> localGtDirectory [
	<return: #FileReference>
	^ GtFileUtilityConstants localGtDirectory
]

{ #category : #'changes diff' }
GtDocumentConstants class >> matchLineColor [
	^ Color black
]

{ #category : #'changes diff' }
GtDocumentConstants class >> matchLineIdentificator [
	^ '  '
]

{ #category : #'pillar annotation names' }
GtDocumentConstants class >> methodAnnotationName [
	^ #method
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> methodsParameterName [
	^ #methods
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> nameParameterName [
	^ #name
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> noCodeParameterName [
	^ #noCode
]

{ #category : #colors }
GtDocumentConstants class >> notAvailableColor [
	^ BrGlamorousColors lightBorderColor
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> packagesParameterName [
	^ #packages
]

{ #category : #'pillar annotation names' }
GtDocumentConstants class >> parametrizedExampleAnnotationName [
	^ #paramExample
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> pathParameterName [
	^ #path
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> previewExpandedParameterName [
	^ #previewExpanded
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> previewHeightParameterName [
	^ #previewHeight
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> previewShowParameterName [
	^ #previewShow
]

{ #category : #ui }
GtDocumentConstants class >> readingModeIcon [
	^ BrGlamorousIcons edit
]

{ #category : #'changes diff' }
GtDocumentConstants class >> removeLineColor [
	^ Color red muchDarker
]

{ #category : #'changes diff' }
GtDocumentConstants class >> removeLineIdentificator [
	^ '- '
]

{ #category : #ui }
GtDocumentConstants class >> resultsLabel [
	^ 'Results'
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> returnVariableParameterName [
	^ #return
]

{ #category : #ui }
GtDocumentConstants class >> runButtonIcon [
	^ BrGlamorousIcons play
]

{ #category : #ui }
GtDocumentConstants class >> runButtonLabel [
	"Default label used for example for button labels, [[[label=Run]]]"
	^ 'Run'
]

{ #category : #ui }
GtDocumentConstants class >> saveButtonIcon [
	^ self applyButtonIcon
]

{ #category : #ui }
GtDocumentConstants class >> saveButtonLabel [
	^ 'Save'
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> showParameterName [
	^ #show
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> slidesAnnotationName [
	^ #slides
]

{ #category : #'pillar parameter names' }
GtDocumentConstants class >> slidesParameterName [
	^ #list
]

{ #category : #colors }
GtDocumentConstants class >> subtleColor [
	^ Color gray
]

{ #category : #ui }
GtDocumentConstants class >> successButtonLabel [
	^ 'Success'
]

{ #category : #colors }
GtDocumentConstants class >> successColor [
	^ BrGlamorousColors successBorderColor
]

{ #category : #text }
GtDocumentConstants class >> superscriptFontSize [
	^ 9
]

{ #category : #'variable bindings' }
GtDocumentConstants class >> thisDocument [
	^ #'thisDocument'
]
