"
I exemplify Documenter project. The main class is ${class:GtDocumenter}$.

I use ${class:GtDocumenterExamplesUtility}$ to simplify examples.
"
Class {
	#name : #GtDocumenterExamples,
	#superclass : #Object,
	#traits : 'TGtDocumentConstants + TGtExampleAssertable',
	#classTraits : 'TGtDocumentConstants classTrait + TGtExampleAssertable classTrait',
	#instVars : [
		'memorySystem',
		'tempDirectory',
		'documents'
	],
	#category : 'GToolkit-Documenter-Examples'
}

{ #category : #accessing }
GtDocumenterExamples class >> constants [
	^ GtDocumentConstants
]

{ #category : #'examples - supporting methods' }
GtDocumenterExamples class >> differentLabel [
	^ 'document example class'
]

{ #category : #changes }
GtDocumenterExamples >> addEpiceaEvent [
	<gtExample>
	| anEpicea anAnnouncements |
	anEpicea := self epicea.
	anAnnouncements := OrderedCollection new.
	anEpicea
		when: GtEpiceaUpdatedAnnouncement
		do: [ :anAnnouncement | anAnnouncements addLast: anAnnouncement ].
	anEpicea addEvent: self ombuEntry content.
	self assert: anEpicea numberOfEvents equals: 2.
	self assert: anAnnouncements size equals: 1.
	^ anEpicea
]

{ #category : #'document updates' }
GtDocumenterExamples >> addingAndRemovingClass [
	<gtExample>
	| aDocument aClassName anElement |
	aDocument := self documentWithNotExistingClass.
	aClassName := self referencedNotExistingClass asSymbol.
	anElement := aDocument asElement.
	self assert: anElement notNil.
	aDocument editor styleText.
	self class environment at: aClassName ifAbsent: [ 
		GtPharoCodeModifier
			createSubclassOf: Object
			named: aClassName
			package: 'GToolkitDocumenterDummyPackage' ].
	
	GtPharoCodeModifier removeBehaviorNamed: aClassName.
	^ aDocument
]

{ #category : #'input file' }
GtDocumenterExamples >> anotherFileName [
	^ 'another.pillar'
]

{ #category : #'input file' }
GtDocumenterExamples >> anotherFileReferenceWithFigure [
	<gtExample>
	| aFigure |
	aFigure := self figureFileReference.
	self assert: aFigure exists.
	^ memorySystem 
		addFileNamed: self anotherFileName 
		toDirectory: memorySystem rootDirectory 
		withContent: self contentWithFigure
]

{ #category : #stencils }
GtDocumenterExamples >> basicResizablePreviewStencil [
	<gtExample>
	| aStencil |
	aStencil := GtResizablePreviewStencil new.
	self assert: aStencil result isNotNil.
	self assert: aStencil showSelector isSymbol.
	^ aStencil
]

{ #category : #figure }
GtDocumenterExamples >> brokenFigureContent [
	| aByteArray |
	aByteArray := self figureContent.
	aByteArray at: 1 put: 3.
	^ aByteArray
]

{ #category : #figure }
GtDocumenterExamples >> brokenFigureFileReference [
	<gtExample>
	^ memorySystem addFileNamed: self figureFileName  withContent: self brokenFigureContent
]

{ #category : #changes }
GtDocumenterExamples >> changesContentWithClassDefinition [
	<gtExample>
	^ 'OmEntry {
	#tags : {
		#prior : OmNullReference [  ],
		#self : OmReference [ ''1'' ]
	},
	#content : EpClassModification {
		#oldClass : RGClassDefinition {
			#annotations : IdentityDictionary {
				#superclassName : ''Object'',
				#traitCompositionSource : ''{}'',
				#definitionSource : ''Object subclass: #MyClassOne\r\tinstanceVariableNames: \''\''\r\tclassVariableNames: \''\''\r\tpoolDictionaries: \''\''\r\tcategory: \''MyTestingPackage\''''
			},
			#name : #MyClassOne,
			#methods : IdentityDictionary { },
			#protocols : Set [ ],
			#instanceVariables : OrderedCollection [ ],
			#metaClass : RGMetaclassDefinition {
				#annotations : IdentityDictionary {
					#traitCompositionSource : ''{}'',
					#definitionSource : ''MyClassOne class\r\tinstanceVariableNames: \''\''''
				},
				#name : #''MyClassOne class'',
				#methods : IdentityDictionary { },
				#protocols : Set [ ],
				#instanceVariables : OrderedCollection [ ],
				#baseClass : @6
			},
			#comment : RGCommentDefinition {
				#annotations : IdentityDictionary {
					#className : #MyClassOne,
					#isMetaSide : false
				},
				#parent : @6,
				#content : ''''
			},
			#classVariables : OrderedCollection [ ],
			#category : #MyTestingPackage,
			#package : #MyTestingPackage,
			#sharedPools : OrderedCollection [ ]
		},
		#newClass : RGClassDefinition {
			#annotations : IdentityDictionary {
				#superclassName : ''Object'',
				#traitCompositionSource : ''{}'',
				#definitionSource : ''Object subclass: #MyClassOne\r\tinstanceVariableNames: \''varOne\''\r\tclassVariableNames: \''\''\r\tpoolDictionaries: \''\''\r\tcategory: \''MyTestingPackage\''''
			},
			#name : #MyClassOne,
			#methods : IdentityDictionary { },
			#protocols : Set [ ],
			#instanceVariables : OrderedCollection [
				RGInstanceVariableDefinition {
					#annotations : IdentityDictionary {
						#className : #MyClassOne,
						#isMetaSide : false
					},
					#name : #varOne,
					#parent : @20
				}
			],
			#metaClass : RGMetaclassDefinition {
				#annotations : IdentityDictionary {
					#traitCompositionSource : ''{}'',
					#definitionSource : ''MyClassOne class\r\tinstanceVariableNames: \''\''''
				},
				#name : #''MyClassOne class'',
				#methods : IdentityDictionary { },
				#protocols : Set [ ],
				#instanceVariables : OrderedCollection [ ],
				#baseClass : @20
			},
			#comment : RGCommentDefinition {
				#annotations : IdentityDictionary {
					#className : #MyClassOne,
					#isMetaSide : false
				},
				#parent : @20,
				#content : ''''
			},
			#classVariables : OrderedCollection [ ],
			#category : #MyTestingPackage,
			#package : #MyTestingPackage,
			#sharedPools : OrderedCollection [ ]
		}
	}
}

'
]

{ #category : #changes }
GtDocumenterExamples >> changesDirectory [
	<gtExample>
	| epiceaDir |
	epiceaDir := (memorySystem rootDirectory / self changesDirectoryName).
	epiceaDir ensureCreateDirectory.
	self assert: epiceaDir exists.
	^ epiceaDir
]

{ #category : #changes }
GtDocumenterExamples >> changesDirectoryName [
	^ 'changes'
]

{ #category : #changes }
GtDocumenterExamples >> changesFileNameWithClassDefinition [
	^ 'class-definition.ombu'
]

{ #category : #changes }
GtDocumenterExamples >> changesFileReferenceWithClassDefinition [
	<gtExample>
	^ memorySystem 
			addFileNamed: self changesFileNameWithClassDefinition
			toDirectory: self changesDirectory 
			withContent: self changesContentWithClassDefinition.
]

{ #category : #'file reference document' }
GtDocumenterExamples >> classToDocument [
	<gtExample>
	^ self class
]

{ #category : #slides }
GtDocumenterExamples >> connectorSlideClass [
	<gtExample>
	^ GtConnectorForExampleLiveSlide
]

{ #category : #accessing }
GtDocumenterExamples >> constants [
	^ GtDocumentConstants
]

{ #category : #'non technical people' }
GtDocumenterExamples >> contentBoldForNonTechnicalPeople [
	^ '""bold""    '
]

{ #category : #changes }
GtDocumenterExamples >> contentWithClassDefinitionChanges [
	^ '${', self constants changesAnnotationName, ':', 
			self changesDirectoryName, '/', self changesFileNameWithClassDefinition , '}$'
]

{ #category : #codeblock }
GtDocumenterExamples >> contentWithCodeblock [
	^ '[[[label=Evaluate
aBook := GtDocument new.
]]]'

]

{ #category : #codeblock }
GtDocumenterExamples >> contentWithCodeblockAndEmptyLineAfter [
	^ '[[[label=Evaluate
4 factorial.
]]]
'

]

{ #category : #codeblock }
GtDocumenterExamples >> contentWithCodeblockOnException [
	^ '[[[
1/0
]]]'

]

{ #category : #'commented line' }
GtDocumenterExamples >> contentWithCommentedLine [
	^ '%% a commented line'
]

{ #category : #codeblock }
GtDocumenterExamples >> contentWithEmptyCodeblock [
	^ '[[[label=Evaluate
   
]]]'

]

{ #category : #'formats, header, and lists' }
GtDocumenterExamples >> contentWithEmptyHeader [
	^ '!'
]

{ #category : #changes }
GtDocumenterExamples >> contentWithEpiceaChanges [
	^ '${', self constants changesAnnotationName, ':', self referencesChangesFile , '}$'

]

{ #category : #'example - existing one' }
GtDocumenterExamples >> contentWithExampleHiddenPreview [
	^ '${', self constants exampleAnnotationName, ':', 
		self referencedMethod printString,
		'|', self constants previewShowParameterName, '=', #gtBytecodeFor:, 
		'|', self constants previewExpandedParameterName, '=', false asString,
		'|', self constants previewHeightParameterName, '=', self previewHeightHudredValue asString,
		'|', self constants codeExpandedParameterName, '=', true asString, '}$'
]

{ #category : #'example - existing one' }
GtDocumenterExamples >> contentWithExampleParameters [
	^ '${', self constants exampleAnnotationName, ':', 
		self referencedMethod printString,
		'|', 'incorrectOne=true',
		'|', self constants previewShowParameterName, '=', #gtBytecodeFor:, 
		'|', self constants previewExpandedParameterName, '=', true asString,
		'|', self constants previewHeightParameterName, '=', 100 asString,
		'|', self constants codeExpandedParameterName, '=', false asString, 
		'|', self constants alignmentParameterName , '=', FullWidthAlignmentStrategy strategyName, '}$'
]

{ #category : #examples }
GtDocumenterExamples >> contentWithExamples [
	^ '${', self constants examplesAnnotationName, ':', 
		self constants classesParameterName , '=#(', 
			GtDocumenterExamples name, ' ', BrBasicExamples name, ')',
		'|', self constants methodsParameterName , '=#(', 
			(BrExamplesShowroom>>#glamorousLargeButton) printString, ')',
		'|', self constants packagesParameterName, '=#(', 
			GtPhlowExamples package name asString, ')', '}$'

]

{ #category : #class }
GtDocumenterExamples >> contentWithExistingClass [
	^ '${', self constants classAnnotationName, ':', self referencedClass , '}$'

]

{ #category : #class }
GtDocumenterExamples >> contentWithExistingClassAndCustomizedNameUsingString [
	^ 'This is a ${', self constants classAnnotationName, ':', self referencedClass , 
		'|', self constants labelParameterName, '=class',
	'}$ with customized name'
]

{ #category : #class }
GtDocumenterExamples >> contentWithExistingClassAndCustomizedNameUsingSymbol [
	^ 'This is a ${', self constants classAnnotationName, ':', self referencedClass , 
		'|', self constants labelParameterName, '=#differentLabel',
	'}$ with customized name'
]

{ #category : #'example - existing one' }
GtDocumenterExamples >> contentWithExistingExample [
	^ '${', self constants exampleAnnotationName, ':', self referencedExampleMethod printString, '}$'

]

{ #category : #'example - with return variable name' }
GtDocumenterExamples >> contentWithExistingExampleAndReturnVariableName [
	^ '${', self constants exampleAnnotationName, ':', 
		self referencedExampleMethod printString, '|',
		self constants returnVariableParameterName, '=', self returnVariableName asString, '}$', 
		String crlf, String crlf, 
		'[[[', String crlf, String crlf, self returnVariableName asString, String crlf, ']]]', String crlf
]

{ #category : #'method - existing one' }
GtDocumenterExamples >> contentWithExistingMethod [
	^ 'This is the ${', self constants methodAnnotationName, ':', self referencedMethod printString, '}$ method.'

]

{ #category : #'method - different name' }
GtDocumenterExamples >> contentWithExistingMethodAndChangedLabelUsingString [
	^ 'This is the ${', self constants methodAnnotationName, ':', self referencedMethod printString, 
	'|', self constants labelParameterName, '=example',
	'}$ method with a customized name.'

]

{ #category : #'method - different name' }
GtDocumenterExamples >> contentWithExistingMethodAndChangedLabelUsingSymbol [
	^ 'This is the ${', self constants methodAnnotationName, ':', self referencedMethod printString, 
	'|', self constants labelParameterName, '=#selector',
	'}$ method with a short name (exluding class name).'

]

{ #category : #'example - parametrized one' }
GtDocumenterExamples >> contentWithExistingParametrizedExampleSumNumber [
"GtDummyExamplesWithParametrizedExampleA>>#parametrizedExample:withTwoArguments:|variables=#(aVariableOne aVariableTwo)|result=aResult}$"
	^ '[[[', String crlf, String crlf, 
			self firstInputVariableName asString, ' := ', self firstInputVariableValue asString, '.', String crlf,
			self secondInputVariableName asString, ' := ', self secondInputVariableValue asString, '.', String crlf,
			']]]', String crlf, String crlf,
		'${', self constants parametrizedExampleAnnotationName, ':', 
		self referencedMethodOfParametrizedExampleSumNumber printString, '|',
		self constants inputVariablesParameterName, '=', self firstInputVariableName asString, 
			' ', self secondInputVariableName asString, '|',
		self constants returnVariableParameterName, '=', self returnVariableName asString, '}$', 
		String crlf, String crlf, 
		'[[[', String crlf, String crlf, self returnVariableName asString, String crlf, ']]]', String crlf
]

{ #category : #slides }
GtDocumenterExamples >> contentWithExistingSlides [
	^ '${', self constants slidesAnnotationName, ':', 
		self constants slidesParameterName , '=#(',
			self emptyDocumentSlideClass name, ' ',
			self connectorSlideClass name, ' ', ')}$'

]

{ #category : #'example - parametrized one' }
GtDocumenterExamples >> contentWithExistingTwoParametrizedExamples [
	^	self contentWithExistingParametrizedExampleSumNumber, String crlf, String crlf, 
		'${', self constants parametrizedExampleAnnotationName, ':', 
		self referencedMethodOfParametrizedExampleSumNumber printString, '|',
		self constants inputVariablesParameterName, '=', self firstInputVariableName asString, 
			' ', self returnVariableName asString, '|',
		self constants returnVariableParameterName, '=', self secondReturnVariableName asString, '}$', 
		String crlf, String crlf, 
		'[[[', String crlf, String crlf, self secondReturnVariableName asString, String crlf, ']]]', String crlf
]

{ #category : #'external link' }
GtDocumenterExamples >> contentWithExternalLink [
	^ '*Feenk>https://feenk.com*', String cr, 
		'*https://feenk.com*', String cr,
		'Here you can see a link that can be split into two lines *https://www.google.com/search?q=how+do+you+feenk+today%3F&oq=how+do+you+feenk+today%3F*.'
]

{ #category : #figure }
GtDocumenterExamples >> contentWithFigure [
	"^ '! Glamorous Toolkit
	The Glamorous Toolkit (GT) is the moldable integrated development environment.
	+Glamorous Toolkit>
	', self figureFileUri, '+'"
    ^ '! Glamorous Toolkit
The Glamorous Toolkit (GT) is the moldable integrated development environment.

+Glamorous Toolkit>', self figureFileUri, '+'

]

{ #category : #'formats, header, and lists' }
GtDocumenterExamples >> contentWithHeaders [
	^ '! Header One
!! Header Two
!!! Header Three
!!!! Header Four
!!!!! Header Five
!!!!!! Header Six
!!!!!!! Header Seven'
]

{ #category : #'iceberg file' }
GtDocumenterExamples >> contentWithIcebergFile [
	^ '${', self constants icebergFileAnnotationName, ':', 
			self constants pathParameterName, '=', self icebergFileName, '}$'

]

{ #category : #'example - inlined in text' }
GtDocumenterExamples >> contentWithInlinedExample [
	"The www.example.com website is accessed 60 times every hour by 3 unique users."
	^ 'The ',
	'${', self constants exampleAnnotationName, ':', self referencedExampleComUrlMethod printString, 
		'|', self constants labelParameterName, '=#host',
		'|', self constants expandedParameterName , '=false', 
	'}$ website is accessed ${', self constants exampleAnnotationName, ':', self referencedExampleComAccessPerHourMethod printString, 
		'|', self constants labelParameterName, '=#size',
		'|', self constants expandedParameterName , '=false', 
	'}$ times every hour by ${', self constants exampleAnnotationName, ':', self referencedExampleComUniqueAccessPerHour printString, 
		'|', self constants labelParameterName, '=#size',
		'|', self constants expandedParameterName , '=false', 
	'}$ unique users.'
]

{ #category : #'example - inlined in text' }
GtDocumenterExamples >> contentWithInlinedLoremIpsum300 [
	^ 'I include a very long text: ',
	'${', self constants exampleAnnotationName, ':', self referencedExampleLoremIpsum300Method printString, 
		'|', self constants labelParameterName, '',
		'|', self constants expandedParameterName , '=false', 
	'}$ that should be split spread over couple of lines.'
]

{ #category : #'input file' }
GtDocumenterExamples >> contentWithInputFileToFigure [
	^ '${', self constants inputFileAnnotationName, ':', self anotherFileName , '}$'

]

{ #category : #'example - existing one' }
GtDocumenterExamples >> contentWithInvalidParameter [
	^ '${', self constants exampleAnnotationName, ':', 
		self referencedMethod printString,
		'|hi|', '=true', '}$'
]

{ #category : #'example - existing one' }
GtDocumenterExamples >> contentWithInvalidParameter2 [
	^ '${', self constants exampleAnnotationName, ':', 
		self referencedMethod printString,
		'||' , '}$'
]

{ #category : #'example - existing one' }
GtDocumenterExamples >> contentWithInvalidParameter3 [
	^ '${', self constants exampleAnnotationName, ':', '}$'
]

{ #category : #'formats, header, and lists' }
GtDocumenterExamples >> contentWithLists [
	^ '
Ordered list:
# one
# two
# three

Another ordered list:
# one
# two
# three

Unordered list:
- one
- two
- three

Another unordered list:
- one
- two 
- three

Definition list:
;Foo
:Bar
;Key
:Value

Another definition list:
;Foo
:Bar
;Key
:Value
'
]

{ #category : #'formats, header, and lists' }
GtDocumenterExamples >> contentWithMarkups [
	^ '""bold"" ''''italic'''' ==monospace== --strikethrought-- @@subscript@@ ^^superscript^^ __underline__ {{{raw}}}'
]

{ #category : #'method - multiple' }
GtDocumenterExamples >> contentWithMultipleMethods [
	^ '${', self constants methodAnnotationName, 
			':', self referencedMethod printString,
			'|', self constants expandedParameterName, '}$', String cr, String cr,
	
		'${', self constants methodAnnotationName, 
			':', self referencedMethod printString,
			'|', self constants expandedParameterName,
			'|', self constants showParameterName, '=gtSourceFor:', '}$', String cr, String cr
]

{ #category : #class }
GtDocumenterExamples >> contentWithNotExistingClass [
	^ '${', self constants classAnnotationName, ':', self referencedNotExistingClass , '}$'

]

{ #category : #examples }
GtDocumenterExamples >> contentWithNotExistingExamples [
	^ '${', self constants examplesAnnotationName, ':', 
		self constants classesParameterName , '=#(', 
			self referencedNotExistingClass, ')' , '}$'

]

{ #category : #examples }
GtDocumenterExamples >> contentWithNotExistingPackageExamples [
	^ '${', self constants examplesAnnotationName, ':', 
		self constants packagesParameterName , '=#(''', 
			self referencedNotExistingPackageName, ''')' , '}$'

]

{ #category : #codeblock }
GtDocumenterExamples >> contentWithSelfCodeblock [
	^ '[[[
self
]]]'

]

{ #category : #'input file' }
GtDocumenterExamples >> contentWithSelfReferencedInputFile [
	^ '${', self constants inputFileAnnotationName, ':', memorySystem pillarFileName, '}$'

]

{ #category : #'pillar parser' }
GtDocumenterExamples >> contentWithTextSpaceClassAnnotationSpaceText [
	^ 'hello  ${', self constants classAnnotationName, ':', Object name asString, '}$ or hi'
]

{ #category : #'example - two same in one document' }
GtDocumenterExamples >> contentWithTwoExistingExamples [
	^ self contentWithExistingExample, String cr, String cr, 
		self contentWithExistingExample, String cr, String cr
]

{ #category : #variable }
GtDocumenterExamples >> contentWithVariable [
	^ '${variable:name=aVariableOne|value=43|previewShow=}$

${variable:name=aVariableOne|expression=Smalltalk os|previewShow=}$
	
[[[refresh=always
	aVariableOne
	
	aView := Mondrian new.
]]]
'
]

{ #category : #'empty document' }
GtDocumenterExamples >> defaultDocument [
	<gtExample>
	<after: #useDefaultStylerStrategy>
	| aDocument |
	aDocument := GtDocumenter new.
	aDocument editor useSyncStylerStrategy.	
	documents add: aDocument.
	self assert: aDocument text asString equals: self emptyContent.
	self assert: aDocument isSubscribedToSystem not.
	self assert: (SystemAnnouncer uniqueInstance hasSubscriber: aDocument systemSubscriber) not.
	self assert: aDocument padding equals: (BlInsets all: 5).
	
	^ aDocument
]

{ #category : #'method - existing one' }
GtDocumenterExamples >> documentDeleteAll [
	<gtExample>
	| aDocument |
	aDocument := self documentWithExistingMethod.
	self examplesUtility 
		deleteText: aDocument text 
		from: 1
		to: self contentWithExistingMethod size.
	aDocument editor styleText.
	self 
		assert: aDocument text asString 
		equals: self emptyContent.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #'method - existing one' }
GtDocumenterExamples >> documentDeleteMethodAnnotation [
	<gtExample>
	| aDocument |
	aDocument := self documentWithExistingMethod.
	self examplesUtility 
		deleteText: aDocument text 
		from: 1
		to: self contentWithExistingMethod size - 1.
	aDocument editor styleText.
	self 
		assert: aDocument text asString 
		equals: self contentWithExistingMethod last asString.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #'file reference document' }
GtDocumenterExamples >> documentFromClassComment [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument classComment: self classToDocument.
	self assert: aDocument storage notNil.
	self assert: aDocument storage comment notNil.
	self assert: aDocument storage comment equals: self classToDocument comment.
	self assert: aDocument text isEmpty.
	aDocument read.
	self assert: aDocument text asString equals: self classToDocument comment.
	^ aDocument
]

{ #category : #'file reference document' }
GtDocumenterExamples >> documentFromFileReference [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument fileReference: self fileReference.
	self assert: aDocument storage notNil.
	self assert: aDocument storage file notNil.
	self assert: aDocument storage file exists.
	self assert: aDocument storage file contents equals: self contentWithMultipleMethods.
	self assert: aDocument text isEmpty.
	aDocument read.
	self assert: aDocument text asString equals: self contentWithMultipleMethods.
	^ aDocument
]

{ #category : #'formats, header, and lists' }
GtDocumenterExamples >> documentInEditingModeWithMarkups [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument
		showMarkup;
		text: self contentWithMarkups.
	self assert: aDocument text asString equals: self contentWithMarkups.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #'formats, header, and lists' }
GtDocumenterExamples >> documentInReadingModeWithMarkups [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument
		hideMarkup;
	 	text: self contentWithMarkups.
	self assert: aDocument text asString equals: self contentWithMarkups.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #figure }
GtDocumenterExamples >> documentWithBrokenFigure [
	<gtExample>
	| aDocument aFigureFile |
	aFigureFile := self brokenFigureFileReference.
	self assert: aFigureFile exists.
	aDocument := self defaultDocument fileReference: self fileReferenceWithFigure.
	aDocument read.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithFigure.
	^ aDocument
]

{ #category : #resourcer }
GtDocumenterExamples >> documentWithClassComment [
	<gtExample>
	^ GtDocumenter forClass: self class
]

{ #category : #changes }
GtDocumenterExamples >> documentWithClassDefinitionChanges [
	<gtExample>
	| aDocument aChangesFile |
	aChangesFile := self changesFileReferenceWithClassDefinition.
	aDocument := self defaultDocument fileReference: self fileReference.
	aDocument text: self contentWithClassDefinitionChanges.
	aDocument save.
	self
		assert: aDocument text asString
		equals: self contentWithClassDefinitionChanges.
	self assert: aChangesFile exists.
	^ aDocument
]

{ #category : #codeblock }
GtDocumenterExamples >> documentWithCodeblock [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithCodeblock.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithCodeblock.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #codeblock }
GtDocumenterExamples >> documentWithCodeblockAndEmptyLineAfter [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithCodeblockAndEmptyLineAfter.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithCodeblockAndEmptyLineAfter.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #codeblock }
GtDocumenterExamples >> documentWithCodeblockOnException [
	<gtExample>
	<noText>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithCodeblockOnException.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithCodeblockOnException.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'commented line' }
GtDocumenterExamples >> documentWithCommentedLine [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithCommentedLine.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithCommentedLine.
	^ aDocument
]

{ #category : #'method - existing one' }
GtDocumenterExamples >> documentWithEditedExistingMethodAnnotation [
	<gtExample>
	| aDocument |
	aDocument := self documentWithExistingMethod.
	self examplesUtility 
		insertText: self fooText
		at: (self contentWithExistingMethod size - 2)
		in: aDocument text.
	self assert: (aDocument text asString = self contentWithExistingMethod) not.
	self 
		assert: (aDocument text asString allButLast: (2 + self fooText size)) 
		equals: (self contentWithExistingMethod allButLast: 2).
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #codeblock }
GtDocumenterExamples >> documentWithEmptyCodeblock [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithEmptyCodeblock.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithEmptyCodeblock.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #'formats, header, and lists' }
GtDocumenterExamples >> documentWithEmptyHeader [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithEmptyHeader.
	self shouldnt: [ aDocument privateStyleText ] raise: SubscriptOutOfBounds.
	^ aDocument
]

{ #category : #changes }
GtDocumenterExamples >> documentWithEpiceaChanges [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument fileReference: self fileReference.
	aDocument text: self contentWithEpiceaChanges.
	aDocument save.
	self
		assert: aDocument text asString
		equals: self contentWithEpiceaChanges.
	^ aDocument
]

{ #category : #'example - existing one' }
GtDocumenterExamples >> documentWithExampleHiddenPreview [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExampleHiddenPreview.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExampleHiddenPreview.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - existing one' }
GtDocumenterExamples >> documentWithExampleParameters [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExampleParameters.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExampleParameters.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #examples }
GtDocumenterExamples >> documentWithExamples [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExamples.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithExamples.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #class }
GtDocumenterExamples >> documentWithExistingClass [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingClass.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingClass.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #class }
GtDocumenterExamples >> documentWithExistingClassAndCustomizedNameUsingString [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingClassAndCustomizedNameUsingString.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingClassAndCustomizedNameUsingString.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #class }
GtDocumenterExamples >> documentWithExistingClassAndCustomizedNameUsingSymbol [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingClassAndCustomizedNameUsingSymbol.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingClassAndCustomizedNameUsingSymbol.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - existing one' }
GtDocumenterExamples >> documentWithExistingExample [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingExample.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithExistingExample.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - with return variable name' }
GtDocumenterExamples >> documentWithExistingExampleAndReturnVariableName [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingExampleAndReturnVariableName.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithExistingExampleAndReturnVariableName.
	self assert: aDocument isSubscribedToSystem.
	self assert: (aDocument variableBindings hasBindingOf: self returnVariableName) not.
	^ aDocument
]

{ #category : #'method - existing one' }
GtDocumenterExamples >> documentWithExistingMethod [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingMethod.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingMethod.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'method - different name' }
GtDocumenterExamples >> documentWithExistingMethodAndChangedLabelUsingString [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingMethodAndChangedLabelUsingString.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingMethodAndChangedLabelUsingString.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'method - different name' }
GtDocumenterExamples >> documentWithExistingMethodAndChangedLabelUsingSymbol [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingMethodAndChangedLabelUsingSymbol.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingMethodAndChangedLabelUsingSymbol.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - parametrized one' }
GtDocumenterExamples >> documentWithExistingParametrizedExampleSumNumber [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingParametrizedExampleSumNumber.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithExistingParametrizedExampleSumNumber.
	"self assert: aDocument isSubscribedToSystem."
	self assert: (aDocument variableBindings hasBindingOf: self returnVariableName) not.
	^ aDocument
]

{ #category : #slides }
GtDocumenterExamples >> documentWithExistingSlides [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingSlides.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingSlides.
	"self assert: aDocument isSubscribedToSystem."
	^ aDocument
]

{ #category : #'example - parametrized one' }
GtDocumenterExamples >> documentWithExistingTwoParametrizedExamples [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingTwoParametrizedExamples.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithExistingTwoParametrizedExamples.
	"self assert: aDocument isSubscribedToSystem."
	self assert: (aDocument variableBindings hasBindingOf: self returnVariableName) not.
	^ aDocument
]

{ #category : #'external link' }
GtDocumenterExamples >> documentWithExternalLink [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExternalLink.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExternalLink.
	^ aDocument
]

{ #category : #'external link' }
GtDocumenterExamples >> documentWithExternalLinkInEditingMode [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExternalLink.
	aDocument showMarkup.
	aDocument privateStyleText.
	self
		assert: aDocument text asString
		equals: self contentWithExternalLink.
	^ aDocument
]

{ #category : #'external link' }
GtDocumenterExamples >> documentWithExternalLinkInReadingMode [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExternalLink.
	aDocument hideMarkup.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithExternalLink.
	^ aDocument
]

{ #category : #figure }
GtDocumenterExamples >> documentWithFigure [
	<gtExample>
	| aDocument aFigureFile |
	aFigureFile := self figureFileReference.
	self assert: aFigureFile exists.
	aDocument := self defaultDocument fileReference: self fileReferenceWithFigure.
	aDocument read.
	self assert: aDocument text asString equals: self contentWithFigure.
	^ aDocument
]

{ #category : #figure }
GtDocumenterExamples >> documentWithFigureCache [
	<gtExample>
	<noTest>
	| aDocument anElement aSpace anElement2 aSpace2 |
	aDocument := self documentWithFigure.
	self assert: aDocument cache size equals: 0.
	BlUseAsyncFeatures disableDuring: [ 
		anElement := aDocument asElement.
		aSpace := self putInSpace: anElement.
		aSpace pulse ].
	self assert: aDocument cache size equals: 1.
	BlUseAsyncFeatures disableDuring: [ 
		anElement2 := aDocument asElement.
		aSpace2 := self putInSpace: anElement2.
		aSpace2 pulse ].
	self assert: aDocument cache size equals: 1.
	aSpace close.
	aSpace2 close.
	^ aDocument
]

{ #category : #'formats, header, and lists' }
GtDocumenterExamples >> documentWithHeadersInEditingMode [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithHeaders.
	aDocument showMarkup.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithHeaders.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #'formats, header, and lists' }
GtDocumenterExamples >> documentWithHeadersInReadingMode [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithHeaders.
	aDocument hideMarkup.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithHeaders.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #'iceberg file' }
GtDocumenterExamples >> documentWithIcebergFile [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithIcebergFile.
	self assert: aDocument text asString equals: self contentWithIcebergFile.
	^ aDocument
]

{ #category : #'example - inlined in text' }
GtDocumenterExamples >> documentWithInlinedExample [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithInlinedExample.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithInlinedExample.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - inlined in text' }
GtDocumenterExamples >> documentWithInlinedLoremIpsum300 [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithInlinedLoremIpsum300.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithInlinedLoremIpsum300.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'input file' }
GtDocumenterExamples >> documentWithInputFileToFigure [
	<gtExample>
	| anAnotherFileReference aDocument |
	anAnotherFileReference := self anotherFileReferenceWithFigure.
	self assert: anAnotherFileReference exists.
	aDocument := self defaultDocument fileReference: self fileReferenceWithInputFileToFigure.
	aDocument read.
	self assert: aDocument text asString equals: self contentWithInputFileToFigure.
	^ aDocument
]

{ #category : #'example - existing one' }
GtDocumenterExamples >> documentWithInvalidParameter [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithInvalidParameter.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithInvalidParameter.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - existing one' }
GtDocumenterExamples >> documentWithInvalidParameter2 [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithInvalidParameter2.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithInvalidParameter2.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - existing one' }
GtDocumenterExamples >> documentWithInvalidParameter3 [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithInvalidParameter3.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithInvalidParameter3.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'formats, header, and lists' }
GtDocumenterExamples >> documentWithLists [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithLists.
	self assert: aDocument text asString equals: self contentWithLists.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #'formats, header, and lists' }
GtDocumenterExamples >> documentWithMarkups [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithMarkups.
	self assert: aDocument text asString equals: self contentWithMarkups.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #'method - multiple' }
GtDocumenterExamples >> documentWithMultipleMethods [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithMultipleMethods.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithMultipleMethods.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #class }
GtDocumenterExamples >> documentWithNotExistingClass [
	<gtExample>
	| aClassName aDocument aClass |
	aClassName := self referencedNotExistingClass.
	aClass := self class environment at: aClassName ifAbsent: [ nil ].
	self assert: aClass isNil.
	aDocument := self defaultDocument text: self contentWithNotExistingClass.
	aDocument editor styleText.
	self
		assert: aDocument text asString
		equals: self contentWithNotExistingClass.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #examples }
GtDocumenterExamples >> documentWithNotExistingExamples [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithNotExistingExamples.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithNotExistingExamples.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #figure }
GtDocumenterExamples >> documentWithNotExistingFigure [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument fileReference: self fileReferenceWithFigure.
	aDocument read.
	self assert: aDocument text asString equals: self contentWithFigure.
	^ aDocument
]

{ #category : #examples }
GtDocumenterExamples >> documentWithNotExistingPackageExamples [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithNotExistingPackageExamples.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithNotExistingPackageExamples.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #codeblock }
GtDocumenterExamples >> documentWithSelfCodeblock [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithSelfCodeblock.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithSelfCodeblock.
	self assert: aDocument isSubscribedToSystem.
	self assert: aDocument evaluationReceiver isNil.
	^ aDocument
]

{ #category : #codeblock }
GtDocumenterExamples >> documentWithSelfCodeblockOnClass [
	<gtExample>
	| aDocument |
	aDocument := self documentWithSelfCodeblock.
	aDocument classComment: self class.  
	aDocument privateStyleText.
	self assert: aDocument evaluationReceiver equals: self class.
	^ aDocument
]

{ #category : #codeblock }
GtDocumenterExamples >> documentWithSelfCodeblockOnFileReference [
	<gtExample>
	| aDocument aFileReference |
	aFileReference := self fileReferenceWithSelfReferencedInputFile.
	aDocument := self documentWithSelfCodeblock.
	aDocument fileReference: aFileReference.  
	aDocument privateStyleText.
	self assert: aDocument evaluationReceiver equals: aFileReference.
	^ aDocument
]

{ #category : #'input file' }
GtDocumenterExamples >> documentWithSelfReferencedInputFile [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument fileReference: self fileReferenceWithSelfReferencedInputFile.
	aDocument read.
	self assert: aDocument text asString equals: self contentWithSelfReferencedInputFile.
	^ aDocument
]

{ #category : #'example - two same in one document' }
GtDocumenterExamples >> documentWithTwoExistingExamples [
	<gtExample>
	| aDocument aCache |
	aDocument := self defaultDocument.
	aDocument
		showMarkup;
		text: self contentWithTwoExistingExamples.
	aDocument privateStyleText.
	self
		assert: aDocument text asString
		equals: self contentWithTwoExistingExamples.
	self assert: aDocument isSubscribedToSystem.
	aCache := aDocument cache keys asOrderedCollection.
	self assert: aCache size equals: 2.
	self assert: aCache first counter > 0.
	self assert: aCache second counter > 0.
	self assert: aCache first counter ~= aCache second counter.
	^ aDocument
]

{ #category : #'empty document' }
GtDocumenterExamples >> emptyContent [
	^ ''

]

{ #category : #'empty document' }
GtDocumenterExamples >> emptyDocument [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self emptyContent.
	self assert: aDocument text asString equals: self emptyContent.
	self assert: aDocument isSubscribedToSystem not.
	self assert: (SystemAnnouncer uniqueInstance hasSubscriber: aDocument) not.
	^ aDocument
]

{ #category : #slides }
GtDocumenterExamples >> emptyDocumentSlideClass [
	<gtExample>
	^ GtDocumenterLiveSlide new
		document: GtDocumenter new.
]

{ #category : #changes }
GtDocumenterExamples >> epicea [
	<gtExample>
	| aChangesFile anEpicea anAnnouncements |
	aChangesFile := self changesFileReferenceWithClassDefinition.
	anAnnouncements := OrderedCollection new.
	anEpicea := GtEpicea new.
	anEpicea
		when: GtEpiceaUpdatedAnnouncement
		do: [ :anAnnouncement | anAnnouncements addLast: anAnnouncement ].
	anEpicea ombuFile: aChangesFile.
	self assert: anEpicea ombuFile equals: aChangesFile.
	self assert: anEpicea log notNil.
	self assert: anEpicea numberOfEvents equals: 1.
	self assert: anAnnouncements size equals: 1.
	^ anEpicea
]

{ #category : #'example - inlined in text' }
GtDocumenterExamples >> exampleComAccessPerHour [
	<gtExample>
	^ (1 to: 60) collect: [ :eachNumber | 'Access No. ', eachNumber asString ]
]

{ #category : #'example - inlined in text' }
GtDocumenterExamples >> exampleComUniqueAccessPerHour [
	<gtExample>
	^ (1 to: 3) collect: [ :eachNumber | 'Unique Access No. ', eachNumber asString, ' at ', self exampleComUrl asString ]
]

{ #category : #'example - inlined in text' }
GtDocumenterExamples >> exampleComUrl [
	"I return a URL instance"
	<gtExample>
	^ 'https://example.com/index.html' asZnUrl
]

{ #category : #'example - inlined in text' }
GtDocumenterExamples >> exampleLoremIpsum300 [
	<gtExample>
	^ String loremIpsum: 300
]

{ #category : #accessing }
GtDocumenterExamples >> examplesUtility [
	^ GtDocumenterExamplesUtility
]

{ #category : #figure }
GtDocumenterExamples >> figureContent [
	<gtExample>
	(GtResourcesUtility resourceAtPath: Path * 'feenkcom' / 'gtoolkit-inspector' / 'doc' / 'gt.png') 
		binaryReadStreamDo: [ :stream | ^ stream contents ].
]

{ #category : #figure }
GtDocumenterExamples >> figureFileName [
	<gtExample>
	^ 'gt-logo.png'

]

{ #category : #figure }
GtDocumenterExamples >> figureFileReference [
	<gtExample>
	^ memorySystem addFileNamed: self figureFileName withContent: self figureContent
]

{ #category : #figure }
GtDocumenterExamples >> figureFileUri [
	<gtExample>
	^ 'file://', self figureFileName
]

{ #category : #'file reference document' }
GtDocumenterExamples >> fileReference [
	<gtExample>
	^ memorySystem addPillarFileWithContent: self contentWithMultipleMethods
]

{ #category : #figure }
GtDocumenterExamples >> fileReferenceWithFigure [
	<gtExample>
	^ memorySystem addPillarFileWithContent: self contentWithFigure
]

{ #category : #'input file' }
GtDocumenterExamples >> fileReferenceWithInputFileToFigure [
	<gtExample>
	^ memorySystem addPillarFileWithContent: self contentWithInputFileToFigure
]

{ #category : #'input file' }
GtDocumenterExamples >> fileReferenceWithSelfReferencedInputFile [
	<gtExample>
	^ memorySystem addPillarFileWithContent: self contentWithSelfReferencedInputFile
]

{ #category : #'example - parametrized one' }
GtDocumenterExamples >> firstInputVariableName [
	^ #aVariableOne
]

{ #category : #'example - parametrized one' }
GtDocumenterExamples >> firstInputVariableValue [
	^ 11
]

{ #category : #basic }
GtDocumenterExamples >> fooString [
	<gtExample>
	^ 'Exemplifing'
]

{ #category : #basic }
GtDocumenterExamples >> fooText [
	<gtExample>
	^ self fooString asRopedText
]

{ #category : #'iceberg file' }
GtDocumenterExamples >> icebergFileName [
	^ 'feenkcom/gtoolkit-documenter/doc/index.pillar'
]

{ #category : #initialization }
GtDocumenterExamples >> initialize [
	"We do define a globaly unique repository name because 
	${class:OmStoreFactory} uses full file name as an unique key."
	super initialize.
	memorySystem := GtFileSystemExamples new 
		rootDirectoryName: UUID new asString.
	documents := OrderedCollection new.
]

{ #category : #initialization }
GtDocumenterExamples >> initializeUsingPhysicalDisk [
	memorySystem initializeUsingPhysicalDisk
]

{ #category : #'file reference document' }
GtDocumenterExamples >> modifyAndStoreToClassComment [
	<gtExample>
	| aDocument aPreviousComment |
	aPreviousComment := self classToDocument comment.
	aDocument := self documentFromClassComment.
	aDocument editor inserter
		at: 0;
		string: '! Inserted Header' , String cr , String cr;
		insert.
	aDocument save.
	self
		assert: aDocument text asString
		equals: self classToDocument comment.
	self assert: (aDocument text asString = aPreviousComment) not.
	aDocument
		text: aPreviousComment;
		save.
	self assert: aDocument text asString equals: aPreviousComment.
	self assert: self classToDocument comment equals: aPreviousComment.
	^ aDocument
]

{ #category : #'file reference document' }
GtDocumenterExamples >> modifyAndStoreToFileReference [
	<gtExample>
	| aDocument |
	aDocument := self documentFromFileReference.
	aDocument editor inserter
		at: 0;
		string: '! Inserted Header' , String cr , String cr;
		insert.
	aDocument save.
	self
		assert: (aDocument text asString endsWith: self contentWithMultipleMethods).
	self
		assert: (aDocument text asString = self contentWithMultipleMethods) not.
	self
		assert: aDocument storage file contents
		equals: aDocument text asString.
	^ aDocument
]

{ #category : #space }
GtDocumenterExamples >> newSpace [
	<gtExample>
	| aSpace |
	aSpace := BlSpace new.
	aSpace host: BlHeadlessHost new.
	aSpace title: 'Documenter Examples'.
	aSpace extent: 600@400.
	aSpace withHalos.
	^ aSpace
]

{ #category : #changes }
GtDocumenterExamples >> ombuEntry [
	<gtExample>
	| anEpLog |
	anEpLog := EpLog fromFile: self changesFileReferenceWithClassDefinition.
	self assert: anEpLog entriesCount equals: 1.
	^ anEpLog entries first
]

{ #category : #'example - parametrized one' }
GtDocumenterExamples >> parametrizedExampleSumNumber: aNumber with: anotherNumber [
	<gtExample>
	| aResult |
	aResult := aNumber + anotherNumber.
	self assert: aResult isNotNil.
	^ aResult
]

{ #category : #'pillar parser' }
GtDocumenterExamples >> parseContentWithTextSpaceClassAnnotationSpaceText [ 
	<gtExample>
	| aPillarDocument aText |
	aPillarDocument := self pillarParser parse: self contentWithTextSpaceClassAnnotationSpaceText.
	aText := aPillarDocument children first children third.
	self assert: aText class equals: PRText.
	self assert: aText text equals: ' or hi'.
	^ aPillarDocument
]

{ #category : #'pillar parser' }
GtDocumenterExamples >> parseRopedTextContent [
	<gtExample>
	"This one does not work yet. We need to improve Petit Parser to delegate string comparision."
	| aPRDocument |
	aPRDocument := self pillarParser parse: self contentWithExistingMethod asRopedText characters.
	self assert: aPRDocument notNil.
	self assert: aPRDocument isPetit2Failure not.
	^ aPRDocument
]

{ #category : #'pillar parser' }
GtDocumenterExamples >> parseStringContent [
	<gtExample>
	| aPRDocument |
	aPRDocument := self pillarParser parse: self contentWithExistingMethod.
	self assert: aPRDocument notNil.
	self assert: aPRDocument isPetit2Failure not.
	^ aPRDocument
]

{ #category : #'pillar parser' }
GtDocumenterExamples >> pillarParser [
	<gtExample>
	^ PRPillarParser new optimize.
	
]

{ #category : #basic }
GtDocumenterExamples >> previewHeightHudredValue [
	^ 100
]

{ #category : #space }
GtDocumenterExamples >> putInSpace: aBlElement [
	<gtExample>
	| aSpace |
	self 
		assert: [ aBlElement isNotNil ]
		description: [ 'Element must be non-nil' ].
	aSpace := self newSpace.
	aSpace root addChild: aBlElement.
	^ aSpace
]

{ #category : #class }
GtDocumenterExamples >> referencedClass [
	<gtExample>
	^ self className
]

{ #category : #'example - inlined in text' }
GtDocumenterExamples >> referencedExampleComAccessPerHourMethod [
	<gtExample>
	^ self class >> #exampleComAccessPerHour
]

{ #category : #'example - inlined in text' }
GtDocumenterExamples >> referencedExampleComUniqueAccessPerHour [
	<gtExample>
	^ self class >> #exampleComUniqueAccessPerHour
]

{ #category : #'example - inlined in text' }
GtDocumenterExamples >> referencedExampleComUrlMethod [
	"I return a compiled method that reference to an example"
	<gtExample>
	^ self class >> #exampleComUrl
]

{ #category : #'example - inlined in text' }
GtDocumenterExamples >> referencedExampleLoremIpsum300Method [
	<gtExample>
	^ self class >> #exampleLoremIpsum300
]

{ #category : #'example - existing one' }
GtDocumenterExamples >> referencedExampleMethod [
	^ self class >> #documentWithMultipleMethods
]

{ #category : #'method - existing one' }
GtDocumenterExamples >> referencedMethod [
	<gtExample>
	^ self class >> #referencedMethod
]

{ #category : #'example - parametrized one' }
GtDocumenterExamples >> referencedMethodOfParametrizedExampleSumNumber [
	^ self class >> #parametrizedExampleSumNumber:with:
]

{ #category : #class }
GtDocumenterExamples >> referencedNotExistingClass [
	<gtExample>
	^ self className, self fooString
]

{ #category : #examples }
GtDocumenterExamples >> referencedNotExistingPackageName [
	<gtExample>
	^ self fooString, self class package name
]

{ #category : #changes }
GtDocumenterExamples >> referencesChangesFile [
	<gtExample>
	^ '01-changes.ombu'
]

{ #category : #'empty document' }
GtDocumenterExamples >> registeredDocument [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument.
	aDocument systemAnnouncer
		when: SystemAnnouncement
		do: [ :anAnnouncement | "ignore" ]
		for: self.
	self assert: aDocument text asString equals: self emptyContent.
	self assert: aDocument isSubscribedToSystem.
	self assert:
		(SystemAnnouncer uniqueInstance hasSubscriber: aDocument systemSubscriber).
	aDocument unsubscribe: self.
	self assert: aDocument isSubscribedToSystem not.
	self assert:
		(SystemAnnouncer uniqueInstance hasSubscriber: aDocument) not.
	^ aDocument
]

{ #category : #changes }
GtDocumenterExamples >> removeEpiceaEvent [
	<gtExample>
	| anEpicea anAnnouncements |
	anEpicea := self epicea.
	anAnnouncements := OrderedCollection new.
	anEpicea
		when: GtEpiceaUpdatedAnnouncement
		do: [ :anAnnouncement | anAnnouncements addLast: anAnnouncement ].
	anEpicea removeEvent: anEpicea events first.
	self assert: anEpicea numberOfEvents equals: 0.
	self assert: anAnnouncements size equals: 1.
	^ anEpicea
]

{ #category : #stencils }
GtDocumenterExamples >> resizablePreviewStencilOnClass [
	<gtExample>
	| aStencil aClass |
	aStencil := self basicResizablePreviewStencil.
	aClass := Object.
	aStencil
		result: aClass;
		showSelector: self constants defaultClassShowSelector.
	self assert: aStencil result equals: aClass.
	self assert: aStencil showSelector equals: self constants defaultClassShowSelector.
	^ aStencil
]

{ #category : #stencils }
GtDocumenterExamples >> resizablePreviewStencilOnMethod [
	<gtExample>
	| aStencil aMethod |
	aStencil := self basicResizablePreviewStencil.
	aMethod := (Object>>#size) asRingDefinition.
	aStencil
		result: aMethod;
		showSelector: self constants defaultMethodShowSelector.
	self assert: aStencil result equals: aMethod.
	self assert: aStencil showSelector equals: self constants defaultMethodShowSelector.
	^ aStencil
]

{ #category : #stencils }
GtDocumenterExamples >> resizablePreviewStencilOnMethodAsElement [
	<gtExample>
	| aStencil anElement |
	aStencil := self resizablePreviewStencilOnMethod.
	anElement := aStencil asElement.
	self assert: anElement class equals: GtExpandableMethodCoderElement.
	^ anElement
]

{ #category : #resourcer }
GtDocumenterExamples >> resourcerWithAllDepthInfiniteRecursion [
	<gtExample>
	| aDocument aCollectionOfFigures anInputFile |
	aDocument := self documentWithSelfReferencedInputFile.
	aCollectionOfFigures := aDocument resourcer includeAll; allDepth; compute.
	self assert: aCollectionOfFigures isCollection.
	self assert: aCollectionOfFigures size equals: 0.
	^ aDocument
]

{ #category : #resourcer }
GtDocumenterExamples >> resourcerWithClasses [
	<gtExample>
	| aDocumenter aClassResource aClass |
	aDocumenter := self documentWithClassComment.
	aClassResource := aDocumenter resourcer includeClasses; get.
	self assert: aClassResource notNil.
	self assert: aClassResource resources size equals: 2.
	aClass := aClassResource resources first.
	self assert: aClass name equals: GtDocumenter name.
	self assert: aClass source equals: aDocumenter.
	self assert: aClass resources notNil.
	self assert: aClass resources isEmpty.
	aClass := aClassResource resources second.
	self assert: aClass name equals: GtDocumenterExamplesUtility name.
	self assert: aClass source equals: aDocumenter.
	self assert: aClass resources notNil.
	self assert: aClass resources isEmpty.
	^ aClassResource
]

{ #category : #resourcer }
GtDocumenterExamples >> resourcerWithClassesMaxDepth [
	<gtExample>
	| aDocument aClassResource aClass |
	aDocument := self documentWithClassComment.
	aClassResource := aDocument resourcer includeClasses; allDepth; get.
	self assert: aClassResource notNil.
	self assert: aClassResource resources size equals: 2.
	aClass := aClassResource resources first.
	self assert: aClass name equals: GtDocumenter name.
	self assert: aClass source equals: aDocument.
	self assert: aClass resources notNil.
	self assert: aClass resources isEmpty.
	aClass := aClassResource resources second.
	self assert: aClass name equals: GtDocumenterExamplesUtility name.
	self assert: aClass source equals: aDocument.
	self assert: aClass resources notNil.
	self assert: aClass resources isEmpty.
	^ aClassResource
]

{ #category : #resourcer }
GtDocumenterExamples >> resourcerWithFigure [
	<gtExample>
	| aDocument aCollectionOfFigures aFigure |
	aDocument := self documentWithFigure.
	aCollectionOfFigures := aDocument resourcer includeFigures; compute.
	self assert: aCollectionOfFigures isCollection.
	self assert: aCollectionOfFigures size equals: 1.
	aFigure := aCollectionOfFigures first.
	self assert: aFigure name equals: self figureFileName.
	self assert: aFigure source equals: aDocument.
	self assert: aFigure resource notNil.
	self assert: aFigure resource exists.
	^ aFigure
]

{ #category : #resourcer }
GtDocumenterExamples >> resourcerWithIcebergFile [
	<gtExample>
	| aDocument aCollectionOfIcebergFiles anIcebergFile |
	aDocument := self documentWithIcebergFile.
	aCollectionOfIcebergFiles := aDocument resourcer includeIcebergFiles; compute.
	self assert: aCollectionOfIcebergFiles isCollection.
	self assert: aCollectionOfIcebergFiles size equals: 1.
	anIcebergFile := aCollectionOfIcebergFiles first.
	self assert: anIcebergFile name equals: self icebergFileName.
	self assert: anIcebergFile source equals: aDocument.
	self assert: anIcebergFile document notNil description: 'Iceberg document should be non-nil'.
	self assert: anIcebergFile document exists description: 'Iceberg document should exist'.
	^ anIcebergFile
]

{ #category : #resourcer }
GtDocumenterExamples >> resourcerWithInputFile [
	<gtExample>
	| aDocument aCollectionOfInputFiles |
	aDocument := self documentWithSelfReferencedInputFile.
	aCollectionOfInputFiles := aDocument resourcer includeInputFiles; compute.
	self assert: aCollectionOfInputFiles isCollection.
	self assert: aCollectionOfInputFiles size equals: 0.
	^ aDocument
]

{ #category : #resourcer }
GtDocumenterExamples >> resourcerWithInputFileToFigure [
	<gtExample>
	| aDocument aCollectionOfResources anInputFile anFigureFile |
	aDocument := self documentWithInputFileToFigure.
	aCollectionOfResources := aDocument resourcer includeAll; allDepth; compute.
	self assert: aCollectionOfResources isCollection.
	self assert: aCollectionOfResources size equals: 2.
	anInputFile := aCollectionOfResources first.
	self assert: anInputFile name equals: self anotherFileName.
	self assert: anInputFile source equals: aDocument.
	self assert: anInputFile document notNil.
	self assert: anInputFile document exists.
	anFigureFile := aCollectionOfResources second.
	self assert: anFigureFile name equals: self figureFileName.
	self assert: anFigureFile source equals: anInputFile document.
	self assert: anFigureFile resource notNil.
	self assert: anFigureFile resource exists.
	^ aCollectionOfResources
]

{ #category : #'example - with return variable name' }
GtDocumenterExamples >> returnVariableName [
	^ #aResult
]

{ #category : #'non technical people' }
GtDocumenterExamples >> ropeHiddenBoldMarkupForNonTechnicalPeople [
	<gtExample>
	| aRope anElement aSwitchAttribute |
	anElement := BrButton new 
				aptitude: BrGlamorousButtonWithLabelAptitude;
				beSmallSize;
				label: 'Display Markups'.
	aSwitchAttribute := BrTextHoverAttribute new
		enterAction: [ :aText :aTextElement :anEditorElement :anEvent |
			anElement 
				removeFromParent;
				relocate: aTextElement position + (aTextElement width @ aTextElement height).
			anEditorElement addChild: anElement ];
		leaveAction: [ :aText :aTextElement :anEditorElement :anEvent |
			anElement removeFromParent ].
	aRope := self contentBoldForNonTechnicalPeople asRopedText bold.
	(aRope from: 1 to: 2) attribute: GtHideAttribute uniqueInstance.
	(aRope from: 7 to: 8) attribute: GtHideAttribute uniqueInstance.
	(aRope from: 3 to: 6) attribute: aSwitchAttribute.
	^ aRope
]

{ #category : #'example - parametrized one' }
GtDocumenterExamples >> secondInputVariableName [
	^ #aVariableTwo
]

{ #category : #'example - parametrized one' }
GtDocumenterExamples >> secondInputVariableValue [
	^ 10
]

{ #category : #'example - with return variable name' }
GtDocumenterExamples >> secondReturnVariableName [
	<gtExample>
	^ #aResultTwo
]

{ #category : #'empty document' }
GtDocumenterExamples >> useDefaultStylerStrategy [
	documents do: [ :eachDocument | eachDocument editor useDefaultStylerStrategy ]
]
