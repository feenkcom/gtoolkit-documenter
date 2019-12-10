"
I exemplify Documenter project. The main class is ${class:GtDocument}$.

I use ${class:GtDocumentExamplesUtility}$ to simplify examples.
"
Class {
	#name : #GtDocumentExamples,
	#superclass : #Object,
	#traits : 'TGtDocumentConstants + TGtExampleAssertable',
	#classTraits : 'TGtDocumentConstants classTrait + TGtExampleAssertable classTrait',
	#instVars : [
		'memorySystem',
		'tempDirectory',
		'documents'
	],
	#category : #'GToolkit-Documenter-Examples'
}

{ #category : #accessing }
GtDocumentExamples class >> constants [
	^ GtDocumentConstants
]

{ #category : #'examples - supporting methods' }
GtDocumentExamples class >> differentLabel [
	^ 'document example class'
]

{ #category : #changes }
GtDocumentExamples >> addEpiceaEvent [
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
GtDocumentExamples >> addingAndRemovingClass [
	<gtExample>
	| aDocument aClassName anElement |
	aDocument := self documentWithNotExistingClass.
	aClassName := self referencedNotExistingClass asSymbol.
	anElement := aDocument asElement.
	self assert: anElement notNil.
	aDocument editor styleText.
	self class environment at: aClassName ifAbsent: [ 
		Object subclass: aClassName
			instanceVariableNames: ''
			classVariableNames: ''
			package: 'GToolkitDocumenterDummyPackage'. ].
	self class environment removeClassNamed: aClassName.
	^ aDocument
]

{ #category : #'input file' }
GtDocumentExamples >> anotherFileName [
	<gtExample>
	^ 'another.pillar'
]

{ #category : #'input file' }
GtDocumentExamples >> anotherFileReferenceWithFigure [
	<gtExample>
	| aFigure |
	aFigure := self figureFileReference.
	self assert: aFigure exists.
	^ memorySystem 
		addFileNamed: self anotherFileName 
		toDirectory: memorySystem rootDirectory 
		withContent: self contentWithFigure
]

{ #category : #figure }
GtDocumentExamples >> brokenFigureContent [
	<gtExample>
	| aByteArray |
	aByteArray := self figureContent.
	aByteArray at: 1 put: 3.
	^ aByteArray
]

{ #category : #figure }
GtDocumentExamples >> brokenFigureFileReference [
	<gtExample>
	^ memorySystem addFileNamed: self figureFileName  withContent: self brokenFigureContent
]

{ #category : #changes }
GtDocumentExamples >> changesContentWithClassDefinition [
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
GtDocumentExamples >> changesDirectory [
	<gtExample>
	| epiceaDir |
	epiceaDir := (memorySystem rootDirectory / self changesDirectoryName).
	epiceaDir ensureCreateDirectory.
	self assert: epiceaDir exists.
	^ epiceaDir
]

{ #category : #changes }
GtDocumentExamples >> changesDirectoryName [
	<gtExample>
	^ 'changes'
]

{ #category : #changes }
GtDocumentExamples >> changesFileNameWithClassDefinition [
	<gtExample>
	^ 'class-definition.ombu'
]

{ #category : #changes }
GtDocumentExamples >> changesFileReferenceWithClassDefinition [
	<gtExample>
	^ memorySystem 
			addFileNamed: self changesFileNameWithClassDefinition
			toDirectory: self changesDirectory 
			withContent: self changesContentWithClassDefinition.
]

{ #category : #'file reference document' }
GtDocumentExamples >> classToDocument [
	<gtExample>
	^ self class
]

{ #category : #slides }
GtDocumentExamples >> connectorSlideClass [
	<gtExample>
	^ GtConnectorForExampleSlide
]

{ #category : #accessing }
GtDocumentExamples >> constants [
	^ GtDocumentConstants
]

{ #category : #'non technical people' }
GtDocumentExamples >> contentBoldForNonTechnicalPeople [
	<gtExample>
	^ '""bold""    '
]

{ #category : #changes }
GtDocumentExamples >> contentWithClassDefinitionChanges [
	<gtExample>
	^ '${', self constants changesAnnotationName, ':', 
			self changesDirectoryName, '/', self changesFileNameWithClassDefinition , '}$'
]

{ #category : #codeblock }
GtDocumentExamples >> contentWithCodeblock [
	<gtExample>
	^ '[[[label=Evaluate
aBook := GtDocument new.
]]]'

]

{ #category : #codeblock }
GtDocumentExamples >> contentWithCodeblockAndEmptyLineAfter [
	<gtExample>
	^ '[[[label=Evaluate
4 factorial.
]]]
'

]

{ #category : #codeblock }
GtDocumentExamples >> contentWithCodeblockOnException [
	<gtExample>
	^ '[[[
1/0
]]]'

]

{ #category : #'commented line' }
GtDocumentExamples >> contentWithCommentedLine [
	<gtExample>
	^ '%% a commented line'
]

{ #category : #codeblock }
GtDocumentExamples >> contentWithEmptyCodeblock [
	<gtExample>
	^ '[[[label=Evaluate
   
]]]'

]

{ #category : #'formats, header, and lists' }
GtDocumentExamples >> contentWithEmptyHeader [
	<gtExample>
	^ '!'
]

{ #category : #changes }
GtDocumentExamples >> contentWithEpiceaChanges [
	<gtExample>
	^ '${', self constants changesAnnotationName, ':', self referencesChangesFile , '}$'

]

{ #category : #'example - existing one' }
GtDocumentExamples >> contentWithExampleHiddenPreview [
	<gtExample>
	^ '${', self constants exampleAnnotationName, ':', 
		self referencedMethod printString,
		'|', self constants previewShowParameterName, '=', #gtBytecodeFor:, 
		'|', self constants previewExpandedParameterName, '=', false asString,
		'|', self constants previewHeightParameterName, '=', self previewHeightHudredValue asString,
		'|', self constants codeExpandedParameterName, '=', true asString, 
		'|', self constants codeHeightParameterName, '=', 50 asString, '}$'
]

{ #category : #'example - existing one' }
GtDocumentExamples >> contentWithExampleParameters [
	<gtExample>
	^ '${', self constants exampleAnnotationName, ':', 
		self referencedMethod printString,
		'|', 'incorrectOne=true',
		'|', self constants previewShowParameterName, '=', #gtBytecodeFor:, 
		'|', self constants previewExpandedParameterName, '=', true asString,
		'|', self constants previewHeightParameterName, '=', 100 asString,
		'|', self constants codeExpandedParameterName, '=', false asString, 
		'|', self constants codeHeightParameterName, '=', 50 asString, '}$'
]

{ #category : #examples }
GtDocumentExamples >> contentWithExamples [
	<gtExample>
	^ '${', self constants examplesAnnotationName, ':', 
		self constants classesParameterName , '=#(', 
			GtDocumentExamples name, ' ', BrBasicExamples name, ')',
		'|', self constants methodsParameterName , '=#(', 
			(BrExamplesShowroom>>#glamorousLargeButton) printString, ')',
		'|', self constants packagesParameterName, '=#(', 
			GtPhlowExamples package name asString, ')', '}$'

]

{ #category : #class }
GtDocumentExamples >> contentWithExistingClass [
	<gtExample>
	^ '${', self constants classAnnotationName, ':', self referencedClass , '}$'

]

{ #category : #class }
GtDocumentExamples >> contentWithExistingClassAndCustomizedNameUsingString [
	<gtExample>
	^ 'This is a ${', self constants classAnnotationName, ':', self referencedClass , 
		'|', self constants labelParameterName, '=class',
	'}$ with customized name'
]

{ #category : #class }
GtDocumentExamples >> contentWithExistingClassAndCustomizedNameUsingSymbol [
	<gtExample>
	^ 'This is a ${', self constants classAnnotationName, ':', self referencedClass , 
		'|', self constants labelParameterName, '=#differentLabel',
	'}$ with customized name'
]

{ #category : #'example - existing one' }
GtDocumentExamples >> contentWithExistingExample [
	<gtExample>
	^ '${', self constants exampleAnnotationName, ':', self referencedExampleMethod printString, '}$'

]

{ #category : #'example - with return variable name' }
GtDocumentExamples >> contentWithExistingExampleAndReturnVariableName [
	<gtExample>
	^ '${', self constants exampleAnnotationName, ':', 
		self referencedExampleMethod printString, '|',
		self constants returnVariableParameterName, '=', self returnVariableName asString, '}$', 
		String crlf, String crlf, 
		'[[[', String crlf, String crlf, self returnVariableName asString, String crlf, ']]]', String crlf
]

{ #category : #'method - existing one' }
GtDocumentExamples >> contentWithExistingMethod [
	<gtExample>
	^ 'This is the ${', self constants methodAnnotationName, ':', self referencedMethod printString, '}$ method.'

]

{ #category : #'method - different name' }
GtDocumentExamples >> contentWithExistingMethodAndChangedLabelUsingString [
	<gtExample>
	^ 'This is the ${', self constants methodAnnotationName, ':', self referencedMethod printString, 
	'|', self constants labelParameterName, '=example',
	'}$ method with a customized name.'

]

{ #category : #'method - different name' }
GtDocumentExamples >> contentWithExistingMethodAndChangedLabelUsingSymbol [
	<gtExample>
	^ 'This is the ${', self constants methodAnnotationName, ':', self referencedMethod printString, 
	'|', self constants labelParameterName, '=#selector',
	'}$ method with a short name (exluding class name).'

]

{ #category : #'example - parametrized one' }
GtDocumentExamples >> contentWithExistingParametrizedExampleSumNumber [
"GtDummyExamplesWithParametrizedExampleA>>#parametrizedExample:withTwoArguments:|variables=#(aVariableOne aVariableTwo)|result=aResult}$"
	<gtExample>
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
GtDocumentExamples >> contentWithExistingSlides [
	<gtExample>
	^ '${', self constants slidesAnnotationName, ':', 
		self constants slidesParameterName , '=#(',
			self emptyDocumentSlideClass name, ' ',
			self connectorSlideClass name, ' ', ')}$'

]

{ #category : #'example - parametrized one' }
GtDocumentExamples >> contentWithExistingTwoParametrizedExamples [
	<gtExample>
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
GtDocumentExamples >> contentWithExternalLink [
	<gtExample>
	^ '*Feenk>https://feenk.com*', String cr, 
		'*https://feenk.com*', String cr,
		'Here you can see a link that can be split into two lines *https://www.google.com/search?q=how+do+you+feenk+today%3F&oq=how+do+you+feenk+today%3F*.'
]

{ #category : #figure }
GtDocumentExamples >> contentWithFigure [
	<gtExample>
	"^ '! Glamorous Toolkit
	The Glamorous Toolkit (GT) is the moldable integrated development environment.
	+Glamorous Toolkit>
	', self figureFileUri, '+'"
    ^ '! Glamorous Toolkit
    The Glamorous Toolkit (GT) is the moldable integrated development environment.

    +Glamorous Toolkit>', self figureFileUri, '+'

]

{ #category : #'formats, header, and lists' }
GtDocumentExamples >> contentWithHeaders [
	<gtExample>
	^ '! Header One
!! Header Two
!!! Header Three
!!!! Header Four
!!!!! Header Five
!!!!!! Header Six
!!!!!!! Header Seven'
]

{ #category : #'iceberg file' }
GtDocumentExamples >> contentWithIcebergFile [
	<gtExample>
	^ '${', self constants icebergFileAnnotationName, ':', 
			self constants pathParameterName, '=', self icebergFileName, '}$'

]

{ #category : #'example - inlined in text' }
GtDocumentExamples >> contentWithInlinedExample [
	"The www.example.com website is accessed 60 times every hour by 3 unique users."
	<gtExample>
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
GtDocumentExamples >> contentWithInlinedLoremIpsum300 [
	<gtExample>
	^ 'I include a very long text: ',
	'${', self constants exampleAnnotationName, ':', self referencedExampleLoremIpsum300Method printString, 
		'|', self constants labelParameterName, '',
		'|', self constants expandedParameterName , '=false', 
	'}$ that should be split spread over couple of lines.'
]

{ #category : #'input file' }
GtDocumentExamples >> contentWithInputFileToFigure [
	<gtExample>
	^ '${', self constants inputFileAnnotationName, ':', self anotherFileName , '}$'

]

{ #category : #'example - existing one' }
GtDocumentExamples >> contentWithInvalidParameter [
	<gtExample>
	^ '${', self constants exampleAnnotationName, ':', 
		self referencedMethod printString,
		'|hi|', '=true', '}$'
]

{ #category : #'example - existing one' }
GtDocumentExamples >> contentWithInvalidParameter2 [
	<gtExample>
	^ '${', self constants exampleAnnotationName, ':', 
		self referencedMethod printString,
		'||' , '}$'
]

{ #category : #'example - existing one' }
GtDocumentExamples >> contentWithInvalidParameter3 [
	<gtExample>
	^ '${', self constants exampleAnnotationName, ':', '}$'
]

{ #category : #'formats, header, and lists' }
GtDocumentExamples >> contentWithLists [
	<gtExample>
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
GtDocumentExamples >> contentWithMarkups [
	<gtExample>
	^ '""bold"" ''''italic'''' ==monospace== --strikethrought-- @@subscript@@ ^^superscript^^ __underline__ {{{raw}}}'
]

{ #category : #'method - multiple' }
GtDocumentExamples >> contentWithMultipleMethods [
	<gtExample>
	^ '${', self constants methodAnnotationName, 
			':', self referencedMethod printString,
			'|', self constants expandedParameterName, '}$', String cr, String cr,
	
		'${', self constants methodAnnotationName, 
			':', self referencedMethod printString,
			'|', self constants expandedParameterName,
			'|', self constants showParameterName, '=gtSourceFor:', '}$', String cr, String cr
]

{ #category : #class }
GtDocumentExamples >> contentWithNotExistingClass [
	<gtExample>
	^ '${', self constants classAnnotationName, ':', self referencedNotExistingClass , '}$'

]

{ #category : #examples }
GtDocumentExamples >> contentWithNotExistingExamples [
	<gtExample>
	^ '${', self constants examplesAnnotationName, ':', 
		self constants classesParameterName , '=#(', 
			self referencedNotExistingClass, ')' , '}$'

]

{ #category : #examples }
GtDocumentExamples >> contentWithNotExistingPackageExamples [
	<gtExample>
	^ '${', self constants examplesAnnotationName, ':', 
		self constants packagesParameterName , '=#(''', 
			self referencedNotExistingPackageName, ''')' , '}$'

]

{ #category : #codeblock }
GtDocumentExamples >> contentWithSelfCodeblock [
	<gtExample>
	^ '[[[
self
]]]'

]

{ #category : #'input file' }
GtDocumentExamples >> contentWithSelfReferencedInputFile [
	<gtExample>
	^ '${', self constants inputFileAnnotationName, ':', memorySystem pillarFileName, '}$'

]

{ #category : #'pillar parser' }
GtDocumentExamples >> contentWithTextSpaceClassAnnotationSpaceText [
	<gtExample>
	^ 'hello  ${', self constants classAnnotationName, ':', Object name asString, '}$ or hi'
]

{ #category : #'example - two same in one document' }
GtDocumentExamples >> contentWithTwoExistingExamples [
	<gtExample>
	^ self contentWithExistingExample, String cr, String cr, 
		self contentWithExistingExample, String cr, String cr
]

{ #category : #variable }
GtDocumentExamples >> contentWithVariable [
	<gtExample>
	^ '${variable:name=aVariableOne|value=43|previewShow=}$

${variable:name=aVariableOne|expression=Smalltalk os|previewShow=}$
	
[[[refresh=always
	aVariableOne
	
	aView := Mondrian new.
]]]
'
]

{ #category : #'empty document' }
GtDocumentExamples >> defaultDocument [
	<gtExample>
	<after: #useDefaultStylerStrategy>
	| aDocument |
	aDocument := GtDocument new.
	aDocument editor useSyncStylerStrategy.
	documents add: aDocument.
	self assert: aDocument text asString equals: self emptyContent.
	self assert: aDocument isSubscribedToSystem not.
	self assert: (SystemAnnouncer uniqueInstance hasSubscriber: aDocument) not.
	^ aDocument
]

{ #category : #'method - existing one' }
GtDocumentExamples >> documentDeleteAll [
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
GtDocumentExamples >> documentDeleteMethodAnnotation [
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
		equals: ( self contentWithExistingMethod last asString).
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #'file reference document' }
GtDocumentExamples >> documentFromClassComment [
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
GtDocumentExamples >> documentFromFileReference [
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
GtDocumentExamples >> documentInEditingModeWithMarkups [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument
		displayMarkup;
	 	text: self contentWithMarkups.
	self assert: aDocument text asString equals: self contentWithMarkups.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #'formats, header, and lists' }
GtDocumentExamples >> documentInReadingModeWithMarkups [
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
GtDocumentExamples >> documentWithBrokenFigure [
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
GtDocumentExamples >> documentWithClassComment [
	<gtExample>
	^ GtDocument forClass: self class
]

{ #category : #changes }
GtDocumentExamples >> documentWithClassDefinitionChanges [
	<gtExample>
	| aDocument aChangesFile |
	aChangesFile := self changesFileReferenceWithClassDefinition.
	aDocument := self defaultDocument fileReference: self fileReference.
	aDocument text: self contentWithClassDefinitionChanges.
	aDocument store.
	self assert: aDocument text asString equals: self contentWithClassDefinitionChanges.
	self assert: aChangesFile exists.
	^ aDocument
]

{ #category : #codeblock }
GtDocumentExamples >> documentWithCodeblock [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithCodeblock.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithCodeblock.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #codeblock }
GtDocumentExamples >> documentWithCodeblockAndEmptyLineAfter [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithCodeblockAndEmptyLineAfter.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithCodeblockAndEmptyLineAfter.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #codeblock }
GtDocumentExamples >> documentWithCodeblockOnException [
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
GtDocumentExamples >> documentWithCommentedLine [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithCommentedLine.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithCommentedLine.
	^ aDocument
]

{ #category : #'method - existing one' }
GtDocumentExamples >> documentWithEditedExistingMethodAnnotation [
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
GtDocumentExamples >> documentWithEmptyCodeblock [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithEmptyCodeblock.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithEmptyCodeblock.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #'formats, header, and lists' }
GtDocumentExamples >> documentWithEmptyHeader [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithEmptyHeader.
	self shouldnt: [ aDocument privateStyleText ] raise: SubscriptOutOfBounds.
	^ aDocument
]

{ #category : #changes }
GtDocumentExamples >> documentWithEpiceaChanges [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument fileReference: self fileReference.
	aDocument text: self contentWithEpiceaChanges.
	aDocument store.
	self assert: aDocument text asString equals: self contentWithEpiceaChanges.
	^ aDocument
]

{ #category : #'example - existing one' }
GtDocumentExamples >> documentWithExampleHiddenPreview [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExampleHiddenPreview.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExampleHiddenPreview.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - existing one' }
GtDocumentExamples >> documentWithExampleParameters [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExampleParameters.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExampleParameters.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #examples }
GtDocumentExamples >> documentWithExamples [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExamples.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithExamples.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #class }
GtDocumentExamples >> documentWithExistingClass [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingClass.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingClass.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #class }
GtDocumentExamples >> documentWithExistingClassAndCustomizedNameUsingString [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingClassAndCustomizedNameUsingString.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingClassAndCustomizedNameUsingString.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #class }
GtDocumentExamples >> documentWithExistingClassAndCustomizedNameUsingSymbol [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingClassAndCustomizedNameUsingSymbol.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingClassAndCustomizedNameUsingSymbol.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - existing one' }
GtDocumentExamples >> documentWithExistingExample [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingExample.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithExistingExample.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - with return variable name' }
GtDocumentExamples >> documentWithExistingExampleAndReturnVariableName [
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
GtDocumentExamples >> documentWithExistingMethod [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingMethod.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingMethod.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'method - different name' }
GtDocumentExamples >> documentWithExistingMethodAndChangedLabelUsingString [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingMethodAndChangedLabelUsingString.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingMethodAndChangedLabelUsingString.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'method - different name' }
GtDocumentExamples >> documentWithExistingMethodAndChangedLabelUsingSymbol [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingMethodAndChangedLabelUsingSymbol.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingMethodAndChangedLabelUsingSymbol.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - parametrized one' }
GtDocumentExamples >> documentWithExistingParametrizedExampleSumNumber [
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
GtDocumentExamples >> documentWithExistingSlides [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingSlides.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingSlides.
	"self assert: aDocument isSubscribedToSystem."
	^ aDocument
]

{ #category : #'example - parametrized one' }
GtDocumentExamples >> documentWithExistingTwoParametrizedExamples [
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
GtDocumentExamples >> documentWithExternalLink [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExternalLink.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExternalLink.
	^ aDocument
]

{ #category : #'external link' }
GtDocumentExamples >> documentWithExternalLinkInEditingMode [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExternalLink.
	aDocument displayMarkup.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithExternalLink.
	^ aDocument
]

{ #category : #'external link' }
GtDocumentExamples >> documentWithExternalLinkInReadingMode [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExternalLink.
	aDocument hideMarkup.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithExternalLink.
	^ aDocument
]

{ #category : #figure }
GtDocumentExamples >> documentWithFigure [
	<gtExample>
	| aDocument aFigureFile |
	aFigureFile := self figureFileReference.
	self assert: aFigureFile exists.
	aDocument := self defaultDocument fileReference: self fileReferenceWithFigure.
	aDocument read.
	self assert: aDocument text asString equals: self contentWithFigure.
	^ aDocument
]

{ #category : #'formats, header, and lists' }
GtDocumentExamples >> documentWithHeadersInEditingMode [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithHeaders.
	aDocument displayMarkup.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithHeaders.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #'formats, header, and lists' }
GtDocumentExamples >> documentWithHeadersInReadingMode [
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
GtDocumentExamples >> documentWithIcebergFile [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithIcebergFile.
	self assert: aDocument text asString equals: self contentWithIcebergFile.
	^ aDocument
]

{ #category : #'example - inlined in text' }
GtDocumentExamples >> documentWithInlinedExample [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithInlinedExample.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithInlinedExample.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - inlined in text' }
GtDocumentExamples >> documentWithInlinedLoremIpsum300 [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithInlinedLoremIpsum300.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithInlinedLoremIpsum300.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'input file' }
GtDocumentExamples >> documentWithInputFileToFigure [
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
GtDocumentExamples >> documentWithInvalidParameter [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithInvalidParameter.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithInvalidParameter.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - existing one' }
GtDocumentExamples >> documentWithInvalidParameter2 [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithInvalidParameter2.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithInvalidParameter2.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - existing one' }
GtDocumentExamples >> documentWithInvalidParameter3 [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithInvalidParameter3.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithInvalidParameter3.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'formats, header, and lists' }
GtDocumentExamples >> documentWithLists [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithLists.
	self assert: aDocument text asString equals: self contentWithLists.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #'formats, header, and lists' }
GtDocumentExamples >> documentWithMarkups [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithMarkups.
	self assert: aDocument text asString equals: self contentWithMarkups.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #'method - multiple' }
GtDocumentExamples >> documentWithMultipleMethods [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithMultipleMethods.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithMultipleMethods.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #class }
GtDocumentExamples >> documentWithNotExistingClass [
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
GtDocumentExamples >> documentWithNotExistingExamples [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithNotExistingExamples.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithNotExistingExamples.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #figure }
GtDocumentExamples >> documentWithNotExistingFigure [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument fileReference: self fileReferenceWithFigure.
	aDocument read.
	self assert: aDocument text asString equals: self contentWithFigure.
	^ aDocument
]

{ #category : #examples }
GtDocumentExamples >> documentWithNotExistingPackageExamples [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithNotExistingPackageExamples.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithNotExistingPackageExamples.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #codeblock }
GtDocumentExamples >> documentWithSelfCodeblock [
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
GtDocumentExamples >> documentWithSelfCodeblockOnClass [
	<gtExample>
	| aDocument |
	aDocument := self documentWithSelfCodeblock.
	aDocument classComment: self class.  
	aDocument privateStyleText.
	self assert: aDocument evaluationReceiver equals: self class.
	^ aDocument
]

{ #category : #codeblock }
GtDocumentExamples >> documentWithSelfCodeblockOnFileReference [
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
GtDocumentExamples >> documentWithSelfReferencedInputFile [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument fileReference: self fileReferenceWithSelfReferencedInputFile.
	aDocument read.
	self assert: aDocument text asString equals: self contentWithSelfReferencedInputFile.
	^ aDocument
]

{ #category : #'example - two same in one document' }
GtDocumentExamples >> documentWithTwoExistingExamples [
	<gtExample>
	| aDocument aCache |
	aDocument := self defaultDocument.
	aDocument displayMarkup; text: self contentWithTwoExistingExamples.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithTwoExistingExamples.
	self assert: aDocument isSubscribedToSystem.
	aCache := aDocument cache keys asOrderedCollection.
	self assert: aCache size equals: 2.
	self assert: aCache first counter > 0.
	self assert: aCache second counter > 0.
	self assert: aCache first counter ~= aCache second counter.
	^ aDocument
]

{ #category : #'empty document' }
GtDocumentExamples >> emptyContent [
	<gtExample>
	^ ''

]

{ #category : #'empty document' }
GtDocumentExamples >> emptyDocument [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self emptyContent.
	self assert: aDocument text asString equals: self emptyContent.
	self assert: aDocument isSubscribedToSystem not.
	self assert: (SystemAnnouncer uniqueInstance hasSubscriber: aDocument) not.
	^ aDocument
]

{ #category : #slides }
GtDocumentExamples >> emptyDocumentSlideClass [
	<gtExample>
	^ GtEmptyDocumenterSlide
]

{ #category : #changes }
GtDocumentExamples >> epicea [
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
GtDocumentExamples >> exampleComAccessPerHour [
	<gtExample>
	^ (1 to: 60) collect: [ :eachNumber | 'Access No. ', eachNumber asString ]
]

{ #category : #'example - inlined in text' }
GtDocumentExamples >> exampleComUniqueAccessPerHour [
	<gtExample>
	^ (1 to: 3) collect: [ :eachNumber | 'Unique Access No. ', eachNumber asString, ' at ', self exampleComUrl asString ]
]

{ #category : #'example - inlined in text' }
GtDocumentExamples >> exampleComUrl [
	"I return a URL instance"
	<gtExample>
	^ 'https://example.com/index.html' asZnUrl
]

{ #category : #'example - inlined in text' }
GtDocumentExamples >> exampleLoremIpsum300 [
	<gtExample>
	^ String loremIpsum: 300
]

{ #category : #accessing }
GtDocumentExamples >> examplesUtility [
	^ GtDocumentExamplesUtility
]

{ #category : #figure }
GtDocumentExamples >> figureContent [
	<gtExample>
	(GtIcebergUtility repositoriesLocation / 'feenkcom' / 'gtoolkit-inspector' / 'doc' / 'gt.png') binaryReadStreamDo: [ :stream | ^ stream contents ].
]

{ #category : #figure }
GtDocumentExamples >> figureFileName [
	<gtExample>
	^ 'gt-logo.png'

]

{ #category : #figure }
GtDocumentExamples >> figureFileReference [
	<gtExample>
	^ memorySystem addFileNamed: self figureFileName withContent: self figureContent
]

{ #category : #figure }
GtDocumentExamples >> figureFileUri [
	<gtExample>
	^ 'file://', self figureFileName
]

{ #category : #'file reference document' }
GtDocumentExamples >> fileReference [
	<gtExample>
	^ memorySystem addPillarFileWithContent: self contentWithMultipleMethods
]

{ #category : #figure }
GtDocumentExamples >> fileReferenceWithFigure [
	<gtExample>
	^ memorySystem addPillarFileWithContent: self contentWithFigure
]

{ #category : #'input file' }
GtDocumentExamples >> fileReferenceWithInputFileToFigure [
	<gtExample>
	^ memorySystem addPillarFileWithContent: self contentWithInputFileToFigure
]

{ #category : #'input file' }
GtDocumentExamples >> fileReferenceWithSelfReferencedInputFile [
	<gtExample>
	^ memorySystem addPillarFileWithContent: self contentWithSelfReferencedInputFile
]

{ #category : #'example - parametrized one' }
GtDocumentExamples >> firstInputVariableName [
	<gtExample>
	^ #aVariableOne
]

{ #category : #'example - parametrized one' }
GtDocumentExamples >> firstInputVariableValue [
	<gtExample>
	^ 11
]

{ #category : #basic }
GtDocumentExamples >> fooString [
	<gtExample>
	^ 'Exemplifing'
]

{ #category : #basic }
GtDocumentExamples >> fooText [
	<gtExample>
	^ self fooString asRopedText
]

{ #category : #'iceberg file' }
GtDocumentExamples >> icebergFileName [
	<gtExample>
	^ 'feenkcom/gtoolkit-documenter/doc/index.pillar'
]

{ #category : #initialization }
GtDocumentExamples >> initialize [
	"We do define a globaly unique repository name because 
	${class:OmStoreFactory} uses full file name as an unique key."
	super initialize.
	memorySystem := GtFileSystemExamples new 
		rootDirectoryName: UUID new asString.
	documents := OrderedCollection new.
]

{ #category : #initialization }
GtDocumentExamples >> initializeUsingPhysicalDisk [
	memorySystem initializeUsingPhysicalDisk
]

{ #category : #'file reference document' }
GtDocumentExamples >> modifyAndStoreToClassComment [
	<gtExample>
	| aDocument aPreviousComment |
	aPreviousComment := self classToDocument comment.
	aDocument := self documentFromClassComment.
	aDocument editor inserter 
		at: 0; string: '! Inserted Header', String cr, String cr; insert.
	aDocument store.
	self assert: aDocument text asString equals: self classToDocument comment.
	self assert: (aDocument text asString = aPreviousComment) not.
	aDocument text: aPreviousComment; store.
	self assert: aDocument text asString equals: aPreviousComment.
	self assert: self classToDocument comment equals: aPreviousComment.
	^ aDocument 
]

{ #category : #'file reference document' }
GtDocumentExamples >> modifyAndStoreToFileReference [
	<gtExample>
	| aDocument |
	aDocument := self documentFromFileReference.
	aDocument editor inserter 
		at: 0; string: '! Inserted Header', String cr, String cr; insert.
	aDocument store.
	self assert: (aDocument text asString endsWith: self contentWithMultipleMethods).
	self assert: (aDocument text asString = self contentWithMultipleMethods) not.
	self assert: aDocument storage file contents equals: aDocument text asString.
	^ aDocument 
]

{ #category : #changes }
GtDocumentExamples >> ombuEntry [
	<gtExample>
	| anEpLog |
	anEpLog := EpLog fromFile: self changesFileReferenceWithClassDefinition.
	self assert: anEpLog entriesCount equals: 1.
	^ anEpLog entries first
]

{ #category : #'example - parametrized one' }
GtDocumentExamples >> parametrizedExampleSumNumber: aNumber with: anotherNumber [
	<gtExample>
	| aResult |
	aResult := aNumber + anotherNumber.
	self assert: aResult isNotNil.
	^ aResult
]

{ #category : #'pillar parser' }
GtDocumentExamples >> parseContentWithTextSpaceClassAnnotationSpaceText [ 
	<gtExample>
	| aPillarDocument aText |
	aPillarDocument := self pillarParser parse: self contentWithTextSpaceClassAnnotationSpaceText.
	aText := aPillarDocument children first children third.
	self assert: aText class equals: PRText.
	self assert: aText text equals: ' or hi'.
	^ aPillarDocument
]

{ #category : #'pillar parser' }
GtDocumentExamples >> parseRopedTextContent [
	<gtExample>
	"This one does not work yet. We need to improve Petit Parser to delegate string comparision."
	| aPRDocument |
	aPRDocument := self pillarParser parse: self contentWithExistingMethod asRopedText characters.
	self assert: aPRDocument notNil.
	self assert: aPRDocument isPetit2Failure not.
	^ aPRDocument
]

{ #category : #'pillar parser' }
GtDocumentExamples >> parseStringContent [
	<gtExample>
	| aPRDocument |
	aPRDocument := self pillarParser parse: self contentWithExistingMethod.
	self assert: aPRDocument notNil.
	self assert: aPRDocument isPetit2Failure not.
	^ aPRDocument
]

{ #category : #'pillar parser' }
GtDocumentExamples >> pillarParser [
	<gtExample>
	^ PRPillarParser new optimize.
	
]

{ #category : #basic }
GtDocumentExamples >> previewHeightHudredValue [
	^ 100
]

{ #category : #class }
GtDocumentExamples >> referencedClass [
	<gtExample>
	^ self className
]

{ #category : #'example - inlined in text' }
GtDocumentExamples >> referencedExampleComAccessPerHourMethod [
	<gtExample>
	^ self class >> #exampleComAccessPerHour
]

{ #category : #'example - inlined in text' }
GtDocumentExamples >> referencedExampleComUniqueAccessPerHour [
	<gtExample>
	^ self class >> #exampleComUniqueAccessPerHour
]

{ #category : #'example - inlined in text' }
GtDocumentExamples >> referencedExampleComUrlMethod [
	"I return a compiled method that reference to an example"
	<gtExample>
	^ self class >> #exampleComUrl
]

{ #category : #'example - inlined in text' }
GtDocumentExamples >> referencedExampleLoremIpsum300Method [
	<gtExample>
	^ self class >> #exampleLoremIpsum300
]

{ #category : #'example - existing one' }
GtDocumentExamples >> referencedExampleMethod [
	<gtExample>
	^ self class >> #documentWithMultipleMethods
]

{ #category : #'method - existing one' }
GtDocumentExamples >> referencedMethod [
	<gtExample>
	^ self class >> #referencedMethod
]

{ #category : #'example - parametrized one' }
GtDocumentExamples >> referencedMethodOfParametrizedExampleSumNumber [
	<gtExample>
	^ self class >> #parametrizedExampleSumNumber:with:
]

{ #category : #class }
GtDocumentExamples >> referencedNotExistingClass [
	<gtExample>
	^ self className, self fooString
]

{ #category : #examples }
GtDocumentExamples >> referencedNotExistingPackageName [
	<gtExample>
	^ self fooString, self class package name
]

{ #category : #changes }
GtDocumentExamples >> referencesChangesFile [
	<gtExample>
	^ '01-changes.ombu'
]

{ #category : #'empty document' }
GtDocumentExamples >> registeredDocument [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument.
	aDocument
		when: SystemAnnouncement
		do: [ :anAnnouncement | "ignore" ]
		for: self.
	self assert: aDocument text asString equals: self emptyContent.
	self assert: aDocument isSubscribedToSystem.
	self assert:
		(SystemAnnouncer uniqueInstance hasSubscriber: aDocument).
	aDocument unsubscribe: self.
	self assert: aDocument isSubscribedToSystem not.
	self assert:
		(SystemAnnouncer uniqueInstance hasSubscriber: aDocument) not.
	^ aDocument
]

{ #category : #changes }
GtDocumentExamples >> removeEpiceaEvent [
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

{ #category : #resourcer }
GtDocumentExamples >> resourcerWithAllDepthInfiniteRecursion [
	<gtExample>
	| aDocument aCollectionOfFigures anInputFile |
	aDocument := self documentWithSelfReferencedInputFile.
	aCollectionOfFigures := aDocument resourcer includeAll; allDepth; compute.
	self assert: aCollectionOfFigures isCollection.
	self assert: aCollectionOfFigures size equals: 0.
	^ aDocument
]

{ #category : #resourcer }
GtDocumentExamples >> resourcerWithClasses [
	<gtExample>
	| aDocument aClassResource aClass |
	aDocument := self documentWithClassComment.
	aClassResource := aDocument resourcer includeClasses; get.
	self assert: aClassResource notNil.
	self assert: aClassResource resources size equals: 2.
	aClass := aClassResource resources first.
	self assert: aClass name equals: GtDocument name.
	self assert: aClass source equals: aDocument.
	self assert: aClass resources notNil.
	self assert: aClass resources isEmpty.
	aClass := aClassResource resources second.
	self assert: aClass name equals: GtDocumentExamplesUtility name.
	self assert: aClass source equals: aDocument.
	self assert: aClass resources notNil.
	self assert: aClass resources isEmpty.
	^ aClassResource
]

{ #category : #resourcer }
GtDocumentExamples >> resourcerWithClassesMaxDepth [
	<gtExample>
	| aDocument aClassResource aClass |
	aDocument := self documentWithClassComment.
	aClassResource := aDocument resourcer includeClasses; allDepth; get.
	self assert: aClassResource notNil.
	self assert: aClassResource resources size equals: 2.
	aClass := aClassResource resources first.
	self assert: aClass name equals: GtDocument name.
	self assert: aClass source equals: aDocument.
	self assert: aClass resources notNil.
	self assert: aClass resources isEmpty.
	aClass := aClassResource resources second.
	self assert: aClass name equals: GtDocumentExamplesUtility name.
	self assert: aClass source equals: aDocument.
	self assert: aClass resources notNil.
	self assert: aClass resources isEmpty.
	^ aClassResource
]

{ #category : #resourcer }
GtDocumentExamples >> resourcerWithFigure [
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
GtDocumentExamples >> resourcerWithIcebergFile [
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
GtDocumentExamples >> resourcerWithInputFile [
	<gtExample>
	| aDocument aCollectionOfInputFiles |
	aDocument := self documentWithSelfReferencedInputFile.
	aCollectionOfInputFiles := aDocument resourcer includeInputFiles; compute.
	self assert: aCollectionOfInputFiles isCollection.
	self assert: aCollectionOfInputFiles size equals: 0.
	^ aDocument
]

{ #category : #resourcer }
GtDocumentExamples >> resourcerWithInputFileToFigure [
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
GtDocumentExamples >> returnVariableName [
	<gtExample>
	^ #aResult
]

{ #category : #'non technical people' }
GtDocumentExamples >> ropeHiddenBoldMarkupForNonTechnicalPeople [
	<gtExample>
	| aRope anElement aSwitchAttribute |
	anElement := BrButton new 
				look: BrGlamorousButtonWithLabelLook;
				beSmall;
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
GtDocumentExamples >> secondInputVariableName [
	<gtExample>
	^ #aVariableTwo
]

{ #category : #'example - parametrized one' }
GtDocumentExamples >> secondInputVariableValue [
	<gtExample>
	^ 10
]

{ #category : #'example - with return variable name' }
GtDocumentExamples >> secondReturnVariableName [
	<gtExample>
	^ #aResultTwo
]

{ #category : #'empty document' }
GtDocumentExamples >> useDefaultStylerStrategy [
	documents do: [ :eachDocument | eachDocument editor useDefaultStylerStrategy ]
]
