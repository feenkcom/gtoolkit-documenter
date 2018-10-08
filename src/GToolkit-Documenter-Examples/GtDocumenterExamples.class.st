Class {
	#name : #GtDocumenterExamples,
	#superclass : #GtDocAbstractExamples,
	#category : 'GToolkit-Documenter-Examples'
}

{ #category : #'pillar card preview' }
GtDocumenterExamples >> basicCard [
	<gtExample>
	^ BrCard new
]

{ #category : #completer }
GtDocumenterExamples >> completer [
	<gtExample>
	^ GtDocumenter editorForText: ''
]

{ #category : #'examples - classes' }
GtDocumenterExamples >> documentWithExamplesAnnotationUsingClasses [
	<gtExample>
	<label: 'Pillar document with examples annotation'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithExamplesAnnotationUsingClasses.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument
]

{ #category : #'examples - methods' }
GtDocumenterExamples >> documentWithExamplesAnnotationUsingMethods [
	<gtExample>
	<label: 'Pillar document with examples annotation'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithExamplesAnnotationUsingMethods.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument
]

{ #category : #'examples - packages' }
GtDocumenterExamples >> documentWithExamplesAnnotationUsingPackages [
	<gtExample>
	<label: 'Pillar document with examples annotation'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithExamplesAnnotationUsingPackages.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument
]

{ #category : #'class - existing one' }
GtDocumenterExamples >> documentWithExistingClassAnnotation [
	<gtExample>
	<label: 'Pillar document with class annotation'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithExistingClassAnnotation.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument
]

{ #category : #'method - existing one' }
GtDocumenterExamples >> documentWithExistingMethodAnnotation [
	<gtExample>
	<label: 'Pillar document with method annotation'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithExistingMethodAnnotation.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument
]

{ #category : #'class - existing expanded' }
GtDocumenterExamples >> documentWithExpandedClassAnnotation [
	<gtExample>
	<label: 'Pillar document with class annotation'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithExpandedClassAnnotation.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument
]

{ #category : #'method - existing expanded' }
GtDocumenterExamples >> documentWithExpandedMethodAnnotation [
	<gtExample>
	<label: 'Pillar document with method annotation'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithExpandedMethodAnnotation.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument
]

{ #category : #'figure - basic' }
GtDocumenterExamples >> documentWithFigure [
	<gtExample>
	<label: 'Pillar document with figure'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithFigure.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument
]

{ #category : #'iceberg file' }
GtDocumenterExamples >> documentWithIcebergAnnotation [
	<gtExample>
	| aRootDocument |
	aRootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithIcebergAnnotation.
	self assert: aRootDocument exists.
	self assert: aRootDocument contents size > 1.
	^ aRootDocument
]

{ #category : #'class - missing one' }
GtDocumenterExamples >> documentWithNonExistingClassAnnotation [
	<gtExample>
	<label: 'Pillar document with class annotation'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithNonExistingClassAnnotation.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument
]

{ #category : #'method - missing one' }
GtDocumenterExamples >> documentWithNonExistingMethodAnnotation [
	<gtExample>
	<label: 'Pillar document with method annotation'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithNonExistingMethodAnnotation.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument
]

{ #category : #'figure - basic' }
GtDocumenterExamples >> figureContent [
	<gtExample>
	<label: 'Pharo log PNG contents'>
	^ PolymorphSystemSettings pharoLogoContents base64Decoded asByteArray
]

{ #category : #'figure - basic' }
GtDocumenterExamples >> figureFileName [
	<gtExample>
	<label: 'Figure file name'>
	^ 'figure.png'

]

{ #category : #'figure - basic' }
GtDocumenterExamples >> figureFileReference [
	<gtExample>
	<label: 'PNG figure file reference'>
	^ fileSystemExamples 
		addFileNamed: self figureFileName  withContent: self figureContent
]

{ #category : #'iceberg file' }
GtDocumenterExamples >> icebergFileName [
	<gtExample>
	| aFileReference aFileName aHomeDirectoryName |
	aFileReference := self icebergFileReference.
	aFileName := aFileReference pillarPrintString.
	self assert: aFileName isString.
	aHomeDirectoryName := FileLocator home asFileReference fullName.
	self assert: (aFileName beginsWith: aHomeDirectoryName) not.
	self assert: (aFileName beginsWith: 'Path *') not.
	^ aFileName
]

{ #category : #'iceberg file' }
GtDocumenterExamples >> icebergFileReference [
	<gtExample>
	| aDirectory aDocument aPath |
	aDirectory := GtIcebergUtility repositoriesLocation.
	self assert: aDirectory exists.
	self assert: aDirectory isDirectory.
	aDocument := aDirectory / 'feenkcom' / 'gtoolkit-documenter' / 'doc' / 'index.pillar'.
	self assert: aDocument exists.
	self assert: aDocument isFile.
	aPath := aDocument relativeTo: aDirectory.
	self assert: aPath isRelative.
	^ aPath
]

{ #category : #'pillar card preview' }
GtDocumenterExamples >> pillarCardPreviewOfExistingFigure [
	<gtExample>
	| aVisitor |
	aVisitor := self pillarCardPreviewVisitorOfExistingFigure.
	aVisitor previewCommand execute.
	self assert: aVisitor previewCommand result notNil.
	self assert: (aVisitor previewCommand result isKindOf: BlElement).
	^ aVisitor previewCommand result
]

{ #category : #'pillar card preview' }
GtDocumenterExamples >> pillarCardPreviewVisitor [
	<gtExample>
	^ GtPillarCardPreviewVisitor new
]

{ #category : #'pillar card preview' }
GtDocumenterExamples >> pillarCardPreviewVisitorOfExistingFigure [
	<gtExample>
	| aFileReference aVisitor aPillarNode aFigureFile |
	aFileReference := self documentWithFigure.
	aFigureFile := self figureFileReference.
	self assert: aFigureFile exists.
	aVisitor := self pillarCardPreviewVisitor.
	aVisitor fileReference: aFileReference.
	aPillarNode := PRPillarParserMain parse: aFileReference contents.
	self assert: aPillarNode notNil.
	self assert: aVisitor previewCommand isNil.
	aPillarNode accept: aVisitor.
	self assert: aVisitor previewCommand notNil.
	^ aVisitor
]

{ #category : #'pillar card preview' }
GtDocumenterExamples >> pillarCardPreviewWithTitleFigureAndDescription [
	<gtExample>
	| aCard |
	aCard := self basicCard.
	
	
	^ aCard
]

{ #category : #'examples - classes' }
GtDocumenterExamples >> pillarContentWithExamplesAnnotationUsingClasses [
	<gtExample>
	<label: 'Pillar content with examples annotation'>
	^ String streamContents: [ :aStream | 
		aStream 
			nextPutAll: '${';
			nextPutAll: self constants examplesTag;
			nextPutAll: ':';
			nextPutAll: self constants classesParameterName;
			nextPutAll: '=#(';
			nextPutAll: self referencedClass;
			nextPutAll: ')}$' ]

]

{ #category : #'examples - methods' }
GtDocumenterExamples >> pillarContentWithExamplesAnnotationUsingMethods [
	<gtExample>
	<label: 'Pillar content with examples annotation'>
	^ String streamContents: [ :aStream | 
		aStream 
			nextPutAll: '${';
			nextPutAll: self constants examplesTag;
			nextPutAll: ':';
			nextPutAll: self constants methodsParameterName;
			nextPutAll: '=#(';
			print: self referencedMethod;
			space;
			print: self referencedMethodTwo;
			nextPutAll: ')}$' ]

]

{ #category : #'examples - packages' }
GtDocumenterExamples >> pillarContentWithExamplesAnnotationUsingPackages [
	<gtExample>
	<label: 'Pillar content with examples annotation'>
	^ String streamContents: [ :aStream | 
		aStream 
			nextPutAll: '${';
			nextPutAll: self constants examplesTag;
			nextPutAll: ':';
			nextPutAll: self constants packagesParameterName;
			nextPutAll: '=#(';
			print: self class package name asString;
			nextPutAll: ')}$' ]
]

{ #category : #'class - existing one' }
GtDocumenterExamples >> pillarContentWithExistingClassAnnotation [
	<gtExample>
	<label: 'Pillar content with a class annotation'>
	^ '${class:', self referencedClass, '}$'

]

{ #category : #'method - existing one' }
GtDocumenterExamples >> pillarContentWithExistingMethodAnnotation [
	<gtExample>
	<label: 'Pillar content with a method annotation'>
	^ '${method:', self referencedMethod printString, '}$'

]

{ #category : #'class - existing expanded' }
GtDocumenterExamples >> pillarContentWithExpandedClassAnnotation [
	<gtExample>
	<label: 'Pillar content with a class annotation'>
	^ '${class:', self referencedClass, '|', self constants expandedViewParameterName, '}$'
]

{ #category : #'method - existing expanded' }
GtDocumenterExamples >> pillarContentWithExpandedMethodAnnotation [
	<gtExample>
	<label: 'Pillar content with a method annotation'>
	^ '${method:', self referencedMethod printString, '|', self constants expandedViewParameterName, '}$'
]

{ #category : #'figure - basic' }
GtDocumenterExamples >> pillarContentWithFigure [
	<gtExample>
	<label: 'Pillar content with Figure node'>
	^ '+Figure caption>file://', self figureFileName, '+'

]

{ #category : #'iceberg file' }
GtDocumenterExamples >> pillarContentWithIcebergAnnotation [
	<gtExample>
	^ '${', 
		GtPillarIcebergFileAnnotation tag, ':', 
		self icebergFileName, '}$'

]

{ #category : #'class - missing one' }
GtDocumenterExamples >> pillarContentWithNonExistingClassAnnotation [
	<gtExample>
	<label: 'Pillar content with a class annotation'>
	^ '${class:NonExistingClass}$'

]

{ #category : #'method - missing one' }
GtDocumenterExamples >> pillarContentWithNonExistingMethodAnnotation [
	<gtExample>
	<label: 'Pillar content with a method annotation'>
	^ '${method:', self referencedClass , '>>#notExistingMethod}$'

]

{ #category : #'class - existing one' }
GtDocumenterExamples >> referencedClass [
	<gtExample>
	^ self className
]

{ #category : #'method - existing one' }
GtDocumenterExamples >> referencedMethod [
	<gtExample>
	^ self class >> #referencedMethod
]

{ #category : #'method - existing one' }
GtDocumenterExamples >> referencedMethodTwo [
	<gtExample>
	^ self class >> #referencedMethodTwo
]

{ #category : #'pillar card preview' }
GtDocumenterExamples >> smallVerticalCard [
	<gtExample>
	| aCard |
	aCard := self basicCard.
	aCard
		size: 200@300;
		look: BrShadowLook + BrLabelLook + BrIconLook + BrDescriptionLook;
		background: Color white;
		margin: (BlInsets all: 10);
		padding: (BlInsets all: 10);
		layout: BlLinearLayout vertical.
	
	^ aCard
]

{ #category : #'examples - classes' }
GtDocumenterExamples >> textEditorWithExamplesAnnotationUsingClasses [
	<gtExample>
	| aPillarElement aBrTextEditor anAttributes |
	aPillarElement := self textElementWithExamplesAnnotationUsingClasses.
	aBrTextEditor := (GtDocumenterExamplesUtility editorFromTextElement: aPillarElement).
	self assert: aBrTextEditor notNil.
	anAttributes := aBrTextEditor text attributesAt: 1.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	anAttributes := aBrTextEditor text attributesAt: aBrTextEditor text size.
	self assert: anAttributes size equals: 3.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextExpandButtonAttribute.
	self assert: anAttributes third class equals: BrTextAdornmentDynamicAttribute.
	^ aBrTextEditor
]

{ #category : #'examples - methods' }
GtDocumenterExamples >> textEditorWithExamplesAnnotationUsingMethods [
	<gtExample>
	| aPillarElement aBrTextEditor anAttributes |
	aPillarElement := self textElementWithExamplesAnnotationUsingMethods.
	aBrTextEditor := (GtDocumenterExamplesUtility editorFromTextElement: aPillarElement).
	self assert: aBrTextEditor notNil.
	anAttributes := aBrTextEditor text attributesAt: 1.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	anAttributes := aBrTextEditor text attributesAt: aBrTextEditor text size.
	self assert: anAttributes size equals: 3.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextExpandButtonAttribute.
	self assert: anAttributes third class equals: BrTextAdornmentDynamicAttribute.
	^ aBrTextEditor
]

{ #category : #'examples - packages' }
GtDocumenterExamples >> textEditorWithExamplesAnnotationUsingPackages [
	<gtExample>
	| aPillarElement aBrTextEditor anAttributes |
	aPillarElement := self textElementWithExamplesAnnotationUsingPackages.
	aBrTextEditor := (GtDocumenterExamplesUtility editorFromTextElement: aPillarElement).
	self assert: aBrTextEditor notNil.
	anAttributes := aBrTextEditor text attributesAt: 1.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	anAttributes := aBrTextEditor text attributesAt: aBrTextEditor text size.
	self assert: anAttributes size equals: 3.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextExpandButtonAttribute.
	self assert: anAttributes third class equals: BrTextAdornmentDynamicAttribute.
	^ aBrTextEditor
]

{ #category : #'class - existing one' }
GtDocumenterExamples >> textEditorWithExistingClassAnnotation [
	<gtExample>
	| aPillarElement aBrTextEditor anAttributes |
	aPillarElement := self textElementWithExistingClassAnnotation.
	aBrTextEditor := (GtDocumenterExamplesUtility editorFromTextElement: aPillarElement).
	self assert: aBrTextEditor notNil.
	anAttributes := aBrTextEditor text attributesAt: 1.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	anAttributes := aBrTextEditor text attributesAt: 9.
	self assert: anAttributes size equals: 4.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextForegroundAttribute.
	self assert: anAttributes third class equals: BrTextHoverAttribute.
	self assert: anAttributes fourth class equals: BrTextClickAttribute.
	anAttributes := aBrTextEditor text attributesAt: aBrTextEditor text size.
	self assert: anAttributes size equals: 2.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextExpandButtonAttribute.
	^ aBrTextEditor
]

{ #category : #'figure - existing file' }
GtDocumenterExamples >> textEditorWithExistingFigureFile [
	<gtExample>
	| aTextElement aBrTextEditor anAttributes |
	aTextElement := self textElementWithExistingFigureFile.
	aBrTextEditor := GtDocumenterExamplesUtility editorFromTextElement: aTextElement.
	self assert: aBrTextEditor notNil.
	anAttributes := aBrTextEditor text attributesAt: 1.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	anAttributes := aBrTextEditor text attributesAt: aBrTextEditor text size.
	self assert: anAttributes size equals: 3.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextExpandButtonAttribute.
	self assert: anAttributes third class equals: GtPillarPictureAttribute.
	^ aBrTextEditor
]

{ #category : #'method - existing one' }
GtDocumenterExamples >> textEditorWithExistingMethodAnnotation [
	<gtExample>
	| aPillarElement aBrTextEditor anAttributes |
	aPillarElement := self textElementWithExistingMethodAnnotation.
	aBrTextEditor := (GtDocumenterExamplesUtility editorFromTextElement: aPillarElement).
	self assert: aBrTextEditor notNil.
	anAttributes := aBrTextEditor text attributesAt: 1.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	anAttributes := aBrTextEditor text attributesAt: 10.
	self assert: anAttributes size equals: 4.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextForegroundAttribute.
	self assert: anAttributes third class equals: BrTextHoverAttribute.
	self assert: anAttributes fourth class equals: BrTextClickAttribute.
	anAttributes := aBrTextEditor text attributesAt: aBrTextEditor text size.
	self assert: anAttributes size equals: 2.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextExpandButtonAttribute.
	^ aBrTextEditor
]

{ #category : #'class - existing expanded' }
GtDocumenterExamples >> textEditorWithExpandedClassAnnotation [
	<gtExample>
	| aTextElement aBrTextEditor anAttributes |
	aTextElement := self textElementWithExpandedClassAnnotation.
	aBrTextEditor := (GtDocumenterExamplesUtility editorFromTextElement: aTextElement).
	self assert: aBrTextEditor notNil.
	anAttributes := aBrTextEditor text attributesAt: 1.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	anAttributes := aBrTextEditor text attributesAt: 9.
	self assert: anAttributes size equals: 4.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextForegroundAttribute.
	self assert: anAttributes third class equals: BrTextHoverAttribute.
	self assert: anAttributes fourth class equals: BrTextClickAttribute.
	anAttributes := aBrTextEditor text attributesAt: aBrTextEditor text size.
	self assert: anAttributes size equals: 3.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextExpandButtonAttribute.
	self assert: anAttributes second isExpanded.
	self assert: anAttributes third class equals: GtPillarClassReferenceAttribute.
	^ aBrTextEditor
]

{ #category : #'method - existing expanded' }
GtDocumenterExamples >> textEditorWithExpandedMethodAnnotation [
	<gtExample>
	| aPillarElement aBrTextEditor anAttributes |
	aPillarElement := self textElementWithExpandedMethodAnnotation.
	aBrTextEditor := GtDocumenterExamplesUtility editorFromTextElement: aPillarElement.
	self assert: aBrTextEditor notNil.
	anAttributes := aBrTextEditor text attributesAt: 1.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	anAttributes := aBrTextEditor text attributesAt: 10.
	self assert: anAttributes size equals: 4.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextForegroundAttribute.
	self assert: anAttributes third class equals: BrTextHoverAttribute.
	self assert: anAttributes fourth class equals: BrTextClickAttribute.
	anAttributes := aBrTextEditor text attributesAt: aBrTextEditor text size.
	self assert: anAttributes size equals: 3.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextExpandButtonAttribute.
	self assert: anAttributes third class equals: GtPillarMethodReferenceAttribute.
	^ aBrTextEditor
]

{ #category : #'iceberg file' }
GtDocumenterExamples >> textEditorWithIcebergAnnotation [
	<gtExample>
	| aPillarElement aBrTextEditor anAttributes |
	aPillarElement := self textElementWithIcebergAnnotation.
	aBrTextEditor := (GtDocumenterExamplesUtility editorFromTextElement: aPillarElement).
	self assert: aBrTextEditor notNil.
	anAttributes := aBrTextEditor text attributesAt: 1.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	anAttributes := aBrTextEditor text attributesAt: aBrTextEditor text size // 2.
	self assert: anAttributes size equals: 4.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextForegroundAttribute.
	self assert: anAttributes third class equals: BrTextHoverAttribute.
	self assert: anAttributes fourth class equals: BrTextClickAttribute.
	anAttributes := aBrTextEditor text attributesAt: aBrTextEditor text size.
	self assert: anAttributes size equals: 2.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second class equals: BrTextExpandButtonAttribute.
	^ aBrTextEditor
]

{ #category : #'class - missing one' }
GtDocumenterExamples >> textEditorWithNonExistingClassAnnotation [
	<gtExample>
	| aPillarElement aBrTextEditor anAttributes |
	aPillarElement := self textElementWithNonExistingClassAnnotation.
	aBrTextEditor := (GtDocumenterExamplesUtility editorFromTextElement: aPillarElement).
	self assert: aBrTextEditor notNil.
	anAttributes := aBrTextEditor text attributesAt: 1.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	anAttributes := aBrTextEditor text attributesAt: 9.
	self assert: anAttributes size equals: 2.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second paint equals: BrGlamorousColors linkWithErrorColor.
	anAttributes := aBrTextEditor text attributesAt: aBrTextEditor text size.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	^ aBrTextEditor
]

{ #category : #'figure - not existing file' }
GtDocumenterExamples >> textEditorWithNonExistingFigureFile [
	<gtExample>
	| aPillarElement aBrTextEditor anAttributes |
	aPillarElement := self textElementWithNonExistingFigureFile.
	aBrTextEditor := (GtDocumenterExamplesUtility editorFromTextElement: aPillarElement).
	self assert: aBrTextEditor notNil.
	anAttributes := aBrTextEditor text attributesAt: 1.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: BrGlamorousColors linkWithErrorColor.
	^ aBrTextEditor
]

{ #category : #'method - missing one' }
GtDocumenterExamples >> textEditorWithNonExistingMethodAnnotation [
	<gtExample>
	| aPillarElement aBrTextEditor anAttributes |
	aPillarElement := self textElementWithNonExistingMethodAnnotation.
	aBrTextEditor := (GtDocumenterExamplesUtility editorFromTextElement: aPillarElement).
	self assert: aBrTextEditor notNil.
	anAttributes := aBrTextEditor text attributesAt: 1.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	anAttributes := aBrTextEditor text attributesAt: 10.
	self assert: anAttributes size equals: 2.
	self assert: anAttributes first paint equals: Color gray.
	self assert: anAttributes second paint equals: BrGlamorousColors linkWithErrorColor.
	anAttributes := aBrTextEditor text attributesAt: aBrTextEditor text size.
	self assert: anAttributes size equals: 1.
	self assert: anAttributes first paint equals: Color gray.
	^ aBrTextEditor
]

{ #category : #'examples - classes' }
GtDocumenterExamples >> textElementWithExamplesAnnotationUsingClasses [
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithExamplesAnnotationUsingClasses.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'examples - methods' }
GtDocumenterExamples >> textElementWithExamplesAnnotationUsingMethods [
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithExamplesAnnotationUsingMethods.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'examples - packages' }
GtDocumenterExamples >> textElementWithExamplesAnnotationUsingPackages [
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithExamplesAnnotationUsingPackages.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'class - existing one' }
GtDocumenterExamples >> textElementWithExistingClassAnnotation [
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithExistingClassAnnotation.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'figure - existing file' }
GtDocumenterExamples >> textElementWithExistingFigureFile [
	<gtExample>
	| aFileReference aTextElement aFigureFile |
	aFileReference := self documentWithFigure.
	aFigureFile := self figureFileReference.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	self assert: aFigureFile exists.
	^ aTextElement
]

{ #category : #'method - existing one' }
GtDocumenterExamples >> textElementWithExistingMethodAnnotation [
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithExistingMethodAnnotation.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'class - existing expanded' }
GtDocumenterExamples >> textElementWithExpandedClassAnnotation [
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithExpandedClassAnnotation.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'method - existing expanded' }
GtDocumenterExamples >> textElementWithExpandedMethodAnnotation [
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithExpandedMethodAnnotation.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'iceberg file' }
GtDocumenterExamples >> textElementWithIcebergAnnotation [
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithIcebergAnnotation.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'class - missing one' }
GtDocumenterExamples >> textElementWithNonExistingClassAnnotation [
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithNonExistingClassAnnotation.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'figure - not existing file' }
GtDocumenterExamples >> textElementWithNonExistingFigureFile [
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithFigure.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'method - missing one' }
GtDocumenterExamples >> textElementWithNonExistingMethodAnnotation [
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithNonExistingMethodAnnotation.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement
]
