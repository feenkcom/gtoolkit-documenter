Class {
	#name : #GtPillarExampleAnnotationHtmlWriter,
	#superclass : #GtPillarWriter,
	#category : #'GToolkit-Documenter-Pillar - Writers'
}

{ #category : #writing }
GtPillarExampleAnnotationHtmlWriter >> write [
	self node doNotDisplaySourceCodeParameterValue ifFalse: [ self writeSourceCode ].
	self writeExampleResult.
]

{ #category : #writing }
GtPillarExampleAnnotationHtmlWriter >> writeExampleResult [
	| figure fileName directory fileReference |
	self node isMethodDefined ifFalse: [ ^ self ].
	figure := PRFigure new.
	figure label: 'figure-' , self node methodName.
	figure
		add: (PRText content: 'Result of ' , self node methodName).
	self flag: 'fix this hack'.
	fileName := self node methodName identityHash asString asLowercase.
	fileName := GtFileUtility 
		secureFileName: fileName 
		extension: 'svg'.
	figure reference: 'file://gt-figures/' , fileName.
	self writer visitFigure: figure.
	directory := self writer configuration outputDirectory asFileReference / 'gt-figures'.
	directory ensureCreateDirectory.
	fileReference := directory / fileName.
	self writeExampleToFile: fileReference
]

{ #category : #writing }
GtPillarExampleAnnotationHtmlWriter >> writeExampleToFile: aFileReference [ 
	| anExampleReturnValue aContainer aView |
	
	anExampleReturnValue := self node methodDefinition compiledMethod gtExample returnValue.
	
	aContainer := GtPillarExporterContainerElement new.
	"recommended size"
	aContainer size: 500@300.

	aView := GtPhlowView sequentialExplicit 
		on: anExampleReturnValue 
		perform: self node previewShowSelector.
	aView asElementDo: [ :anElement | aContainer addChild: anElement ].
	
	aContainer forceLayout.

	aFileReference ensureDelete.
	BlSvgExporter new element: aContainer; fileName: aFileReference; export.

]

{ #category : #writing }
GtPillarExampleAnnotationHtmlWriter >> writeSourceCode [
	self canvas tag
		name: 'figure';
		parameterAt: 'class' put: 'gtexample-src';
		with: [ 
					self canvas tag
						name: 'pre';
						with: [ 
									| code language |
									code := self canvas tag
										name: 'code';
										yourself.
									language := PRSmalltalkScriptLanguage default.
									language isSyntaxHighlightingPossible
										ifTrue: [ code parameterAt: 'class' put: language printString ].
									code with: [ self node isMethodDefined 
										ifTrue: [ self canvas lines: self node methodDefinition sourceCode ]
										ifFalse: [ self canvas lines: self node methodDefinition printString ] ] ].
					self canvas tag
						name: 'figcaption';
						with: [ 
									self node hasLabel
										ifTrue: [ 
											self createAnchorWith: self node label.
											self writer writeCounterForScript: self node ].
									self node hasCaption
										ifTrue: [ self visitAll: self node caption children ] ] ].
	self canvas newLine
]
