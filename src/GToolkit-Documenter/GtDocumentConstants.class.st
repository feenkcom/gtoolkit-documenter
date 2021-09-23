Class {
	#name : 'GtDocumentConstants',
	#superclass : 'Object',
	#category : 'GToolkit-Documenter-Utility'
}

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> alignmentParameterName [
	^ #alignment
]

{ #category : 'pillar parameter default values' }
GtDocumentConstants class >> alignmentTypes [
	^ AlignmentStrategy allSubclasses collect: #strategyName
]

{ #category : 'ui' }
GtDocumentConstants class >> applyButtonIcon [
	^ BrGlamorousVectorIcons accept
]

{ #category : 'ui' }
GtDocumentConstants class >> applyButtonLabel [
	^ 'Apply'
]

{ #category : 'pillar annotation names' }
GtDocumentConstants class >> changesAnnotationName [
	^ #changes
]

{ #category : 'files' }
GtDocumentConstants class >> changesFileExtension [
	^ '.ombu'
]

{ #category : 'pillar annotation names' }
GtDocumentConstants class >> classAnnotationName [
	^ #class
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> classesParameterName [
	^ #classes
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> codeExpandedParameterName [
	^ #codeExpanded
]

{ #category : 'ui' }
GtDocumentConstants class >> confluenceButtonIcon [
	^ BrGlamorousIcons cloud
]

{ #category : 'ui' }
GtDocumentConstants class >> createButtonIcon [
	^ BrGlamorousIcons edit
]

{ #category : 'ui' }
GtDocumentConstants class >> createButtonLabel [
	^ 'Create'
]

{ #category : 'text' }
GtDocumentConstants class >> cursorNearbyDistance [
	^ 0
]

{ #category : 'pillar parameter default values' }
GtDocumentConstants class >> defaultAlignment [
	^ ParagraphWidthAlignmentStrategy strategyName.
]

{ #category : 'pillar parameter default values' }
GtDocumentConstants class >> defaultChangesShowSelector [
	^ #gtPreviewFor:
]

{ #category : 'pillar parameter default values' }
GtDocumentConstants class >> defaultClassShowSelector [
	^ #gtDefinitionFor:
]

{ #category : 'pillar parameter default values' }
GtDocumentConstants class >> defaultExamplesShowSelector [
	^ #gtExpandableExamplesFor: "#gtExamplesFor:"
]

{ #category : 'file export' }
GtDocumentConstants class >> defaultExportFigureWidth [
	"Exported figure width wihout considering the scale factor at ${method:GtDocumentConstants class>>#exportFigureScaleFactor}$"
	^ 800
]

{ #category : 'pillar parameter default values' }
GtDocumentConstants class >> defaultFigureShowSelector [
	^ #gtFigureFor:
]

{ #category : 'pillar parameter default values' }
GtDocumentConstants class >> defaultInlineValue [
	^ #yourself
]

{ #category : 'pillar parameter default values' }
GtDocumentConstants class >> defaultMethodShowSelector [
	^ #gtBasicSourceFor:
]

{ #category : 'pillar parameter default values' }
GtDocumentConstants class >> defaultPreviewExpanded [
	^ false
]

{ #category : 'pillar parameter default values' }
GtDocumentConstants class >> defaultPreviewHeight [
	^ 300
]

{ #category : 'pillar parameter default values' }
GtDocumentConstants class >> defaultShowSelector [
	^ #gtViewsFor:
]

{ #category : 'ui' }
GtDocumentConstants class >> documentUserDataKey [
	^ #gtDocument
]

{ #category : 'ui' }
GtDocumentConstants class >> editButtonIcon [
	^ BrGlamorousIcons edit
]

{ #category : 'ui' }
GtDocumentConstants class >> editButtonLabel [
	^ 'Edit'
]

{ #category : 'ui' }
GtDocumentConstants class >> editingModeIcon [
	^ BrGlamorousIcons edit 
]

{ #category : 'colors' }
GtDocumentConstants class >> errorColor [
	^ BrGlamorousColors errorBorderColor
]

{ #category : 'pillar annotation names' }
GtDocumentConstants class >> exampleAnnotationName [
	^ #example
]

{ #category : 'pillar annotation names' }
GtDocumentConstants class >> examplesAnnotationName [
	^ #examples
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> expandedParameterName [
	^ #expanded
]

{ #category : 'pillar annotation names' }
GtDocumentConstants class >> explanationAnnotationName [
	^ #explanation
]

{ #category : 'file export' }
GtDocumentConstants class >> exportFigureScaleFactor [
	"Scale factor that is used then exporting to PNG (non-vector) format"
	^ 2
]

{ #category : 'files' }
GtDocumentConstants class >> exportedResultsDirectoryName [
	<return: #String>
	^ 'gt-figures'
]

{ #category : 'files' }
GtDocumentConstants class >> exportedResultsDirectoryPath [
	<return: #RelativePath>
	^ Path * self exportedResultsDirectoryName
]

{ #category : 'files' }
GtDocumentConstants class >> exportedResultsExtension [
	<return: #String>
	^ 'png'
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> fullViewParameterName [
	^ #full
]

{ #category : 'margins' }
GtDocumentConstants class >> headerBottomMargin [
	^ self paragraphBottomMargin
]

{ #category : 'text' }
GtDocumentConstants class >> headerFontSizeMultiplier [
	^ 1.5
]

{ #category : 'text' }
GtDocumentConstants class >> headerLevelStep [
	^ 2
]

{ #category : 'margins' }
GtDocumentConstants class >> headerMarginForLevel: aLevelNumber [
	^ BlInsets 
		top: ((6 - (aLevelNumber)) min: 1) * self headerTopMargin 
		left: 0 
		bottom: self headerBottomMargin 
		right: 0
]

{ #category : 'margins' }
GtDocumentConstants class >> headerTopMargin [
	^ self paragraphTopMargin * 5
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> heightParameterName [
	^ #height
]

{ #category : 'ui' }
GtDocumentConstants class >> horizontalLineHeight [
	^ 1
]

{ #category : 'pillar annotation names' }
GtDocumentConstants class >> icebergFileAnnotationName [
	^ #icebergFile
]

{ #category : 'files' }
GtDocumentConstants class >> icebergRepositoriesLocation [
	<return: #FileReference>
	^ GtResourcesUtility default repositoriesLocation
]

{ #category : 'ui' }
GtDocumentConstants class >> infoButtonIcon [
	^ BrGlamorousVectorIcons inspect
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> inlineParameterName [
	self 
		deprecated: 'Please use #labelParameterName instead.'
		transformWith: '`@receiver inlineParameterName' -> '`@receiver labelParameterName'.
	^ self labelParameterName
]

{ #category : 'pillar annotation names' }
GtDocumentConstants class >> inputFileAnnotationName [
	^ PRInputFileAnnotation tag
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> inputVariablesParameterName [
	^ #variables
]

{ #category : 'changes diff' }
GtDocumentConstants class >> insertLineColor [
	^ Color green muchDarker
]

{ #category : 'changes diff' }
GtDocumentConstants class >> insertLineIdentificator [
	^ '+ '
]

{ #category : 'ui' }
GtDocumentConstants class >> issuesButtonLabel [
	^ 'Issues'
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> labelParameterName [
	^ #label
]

{ #category : 'colors' }
GtDocumentConstants class >> linkColor [
	^ BrGlamorousColors linkColor
]

{ #category : 'colors' }
GtDocumentConstants class >> linkWithErrorColor [
	^ BrGlamorousColors linkWithErrorColor
]

{ #category : 'files' }
GtDocumentConstants class >> localGtDirectory [
	<return: #FileReference>
	^ GtResourcesUtilityConstants localGtDirectory
]

{ #category : 'changes diff' }
GtDocumentConstants class >> matchLineColor [
	^ Color black
]

{ #category : 'changes diff' }
GtDocumentConstants class >> matchLineIdentificator [
	^ '  '
]

{ #category : 'pillar annotation names' }
GtDocumentConstants class >> methodAnnotationName [
	^ #method
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> methodsParameterName [
	^ #methods
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> nameParameterName [
	^ #name
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> noCodeParameterName [
	^ #noCode
]

{ #category : 'colors' }
GtDocumentConstants class >> notAvailableColor [
	^ BrGlamorousColors lightBorderColor
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> packagesParameterName [
	^ #packages
]

{ #category : 'margins' }
GtDocumentConstants class >> paragraphBottomMargin [
	^ 5
]

{ #category : 'margins' }
GtDocumentConstants class >> paragraphMargin [
	^ BlInsets 
		top: self paragraphTopMargin
		left: 0 
		bottom: self paragraphBottomMargin 
		right: 0
]

{ #category : 'margins' }
GtDocumentConstants class >> paragraphTopMargin [
	^ 5
]

{ #category : 'pillar annotation names' }
GtDocumentConstants class >> parametrizedExampleAnnotationName [
	^ #paramExample
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> pathParameterName [
	^ #path
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> previewExpandedParameterName [
	^ #previewExpanded
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> previewHeightParameterName [
	^ #previewHeight
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> previewShowParameterName [
	^ #previewShow
]

{ #category : 'ui' }
GtDocumentConstants class >> readingModeIcon [
	^ BrGlamorousIcons edit
]

{ #category : 'changes diff' }
GtDocumentConstants class >> removeLineColor [
	^ Color red muchDarker
]

{ #category : 'changes diff' }
GtDocumentConstants class >> removeLineIdentificator [
	^ '- '
]

{ #category : 'ui' }
GtDocumentConstants class >> resultsLabel [
	^ 'Results'
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> returnVariableParameterName [
	^ #return
]

{ #category : 'ui' }
GtDocumentConstants class >> runButtonIcon [
	^ BrGlamorousVectorIcons play
]

{ #category : 'ui' }
GtDocumentConstants class >> runButtonLabel [
	"Default label used for example for button labels, [[[label=Run]]]"
	^ 'Run'
]

{ #category : 'ui' }
GtDocumentConstants class >> saveButtonIcon [
	^ self applyButtonIcon
]

{ #category : 'ui' }
GtDocumentConstants class >> saveButtonLabel [
	^ 'Save'
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> showParameterName [
	^ #show
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> slidesAnnotationName [
	^ #slides
]

{ #category : 'pillar parameter names' }
GtDocumentConstants class >> slidesParameterName [
	^ #list
]

{ #category : 'colors' }
GtDocumentConstants class >> subtleColor [
	^ Color gray
]

{ #category : 'ui' }
GtDocumentConstants class >> successButtonLabel [
	^ 'Success'
]

{ #category : 'colors' }
GtDocumentConstants class >> successColor [
	^ BrGlamorousColors successBorderColor
]

{ #category : 'text' }
GtDocumentConstants class >> superscriptFontSize [
	^ 9
]

{ #category : 'variable bindings' }
GtDocumentConstants class >> thisDocument [
	^ #'thisDocument'
]
