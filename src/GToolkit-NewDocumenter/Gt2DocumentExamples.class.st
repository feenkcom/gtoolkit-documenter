"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	memorySystem:		<Object>


    Implementation Points
"
Class {
	#name : #Gt2DocumentExamples,
	#superclass : #Object,
	#traits : 'TGt2DocumentConstants + TBlDebug',
	#classTraits : 'TGt2DocumentConstants classTrait + TBlDebug classTrait',
	#instVars : [
		'memorySystem'
	],
	#category : #'GToolkit-NewDocumenter-Examples'
}

{ #category : #accessing }
Gt2DocumentExamples class >> constants [
	^ Gt2DocumentConstants
]

{ #category : #changes }
Gt2DocumentExamples >> addEpiceaEvent [
	<gtExample>
	| anEpicea anAnnouncements |
	anEpicea := self epicea.
	anAnnouncements := OrderedCollection new.
	anEpicea 
		subscribe: Gt2EpiceaUpdatedAnnouncement 
		do: [ :anAnnouncement | anAnnouncements addLast: anAnnouncement ].
	anEpicea addEvent: self ombuEntry content.
	self assert: anEpicea numberOfEvents equals: 2.
	self assert: anAnnouncements size equals: 1.
	^ anEpicea
]

{ #category : #'document updates' }
Gt2DocumentExamples >> addingAndRemovingClass [
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
Gt2DocumentExamples >> anotherFileName [
	<gtExample>
	^ 'another.pillar'
]

{ #category : #'input file' }
Gt2DocumentExamples >> anotherFileReferenceWithFigure [
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
Gt2DocumentExamples >> brokenFigureContent [
	<gtExample>
	| aByteArray |
	aByteArray := self figureContent.
	aByteArray at: 1 put: 3.
	^ aByteArray
]

{ #category : #figure }
Gt2DocumentExamples >> brokenFigureFileReference [
	<gtExample>
	^ memorySystem addFileNamed: self figureFileName  withContent: self brokenFigureContent
]

{ #category : #changes }
Gt2DocumentExamples >> changesContentWithClassDefinition [
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
Gt2DocumentExamples >> changesDirectory [
	<gtExample>
	| epiceaDir |
	epiceaDir := (memorySystem rootDirectory / self changesDirectoryName).
	epiceaDir ensureCreateDirectory.
	self assert: epiceaDir exists.
	^ epiceaDir
]

{ #category : #changes }
Gt2DocumentExamples >> changesDirectoryName [
	<gtExample>
	^ 'changes'
]

{ #category : #changes }
Gt2DocumentExamples >> changesFileNameWithClassDefinition [
	<gtExample>
	^ 'class-definition.ombu'
]

{ #category : #changes }
Gt2DocumentExamples >> changesFileReferenceWithClassDefinition [
	<gtExample>
	^ memorySystem 
			addFileNamed: self changesFileNameWithClassDefinition
			toDirectory: self changesDirectory 
			withContent: self changesContentWithClassDefinition.
]

{ #category : #'file reference document' }
Gt2DocumentExamples >> classToDocument [
	<gtExample>
	^ self class
]

{ #category : #accessing }
Gt2DocumentExamples >> constants [
	^ Gt2DocumentConstants
]

{ #category : #'non technical people' }
Gt2DocumentExamples >> contentBoldForNonTechnicalPeople [
	<gtExample>
	^ '""bold""    '
]

{ #category : #changes }
Gt2DocumentExamples >> contentWithClassDefinitionChanges [
	<gtExample>
	^ '${', self constants changesAnnotationName, ':', 
			self changesDirectoryName, '/', self changesFileNameWithClassDefinition , '}$'
]

{ #category : #codeblock }
Gt2DocumentExamples >> contentWithCodeblock [
	<gtExample>
	^ '[[[label=Evaluate
aBook := DmAbAddressBook new.
]]]'

]

{ #category : #codeblock }
Gt2DocumentExamples >> contentWithCodeblockAndEmptyLineAfter [
	<gtExample>
	^ '[[[label=Evaluate
4 factorial.
]]]
'

]

{ #category : #codeblock }
Gt2DocumentExamples >> contentWithCodeblockOnException [
	<gtExample>
	^ '[[[
1/0
]]]'

]

{ #category : #'commented line' }
Gt2DocumentExamples >> contentWithCommentedLine [
	<gtExample>
	^ '%% a commented line'
]

{ #category : #codeblock }
Gt2DocumentExamples >> contentWithEmptyCodeblock [
	<gtExample>
	^ '[[[label=Evaluate
   
]]]'

]

{ #category : #changes }
Gt2DocumentExamples >> contentWithEpiceaChanges [
	<gtExample>
	^ '${', self constants changesAnnotationName, ':', self referencesChangesFile , '}$'

]

{ #category : #'example - existing one' }
Gt2DocumentExamples >> contentWithExampleHiddenPreview [
	<gtExample>
	^ '${', self constants exampleAnnotationName, ':', 
		self referencedMethod printString,
		'|', self constants previewShowParameterName, '=', #gtBytecodeFor:, 
		'|', self constants previewExpandedParameterName, '=', false asString,
		'|', self constants previewHeightParameterName, '=', 100 asString,
		'|', self constants codeExpandedParameterName, '=', true asString, 
		'|', self constants codeHeightParameterName, '=', 50 asString, '}$'
]

{ #category : #'example - existing one' }
Gt2DocumentExamples >> contentWithExampleParameters [
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
Gt2DocumentExamples >> contentWithExamples [
	<gtExample>
	^ '${', self constants examplesAnnotationName, ':', 
		self constants classesParameterName , '=#(', 
			Gt2DocumentExamples name, ' ', BrBasicExamples name, ')',
		'|', self constants methodsParameterName , '=#(', 
			(BrExamplesShowroom>>#glamorousLargeButton) printString, ')',
		'|', self constants packagesParameterName, '=#(', 
			GtPhlowExamples package name asString, ')', '}$'

]

{ #category : #class }
Gt2DocumentExamples >> contentWithExistingClass [
	<gtExample>
	^ '${', self constants classAnnotationName, ':', self referencedClass , '}$'

]

{ #category : #'example - existing one' }
Gt2DocumentExamples >> contentWithExistingExample [
	<gtExample>
	^ '${', self constants exampleAnnotationName, ':', self referencedExampleMethod printString, '}$'

]

{ #category : #'method - existing one' }
Gt2DocumentExamples >> contentWithExistingMethod [
	<gtExample>
	^ '${', self constants methodAnnotationName, ':', self referencedMethod printString, '}$'

]

{ #category : #'external link' }
Gt2DocumentExamples >> contentWithExternalLink [
	<gtExample>
	^ '*Feenk>https://feenk.com*', String cr, '*https://feenk.com*'
]

{ #category : #figure }
Gt2DocumentExamples >> contentWithFigure [
	<gtExample>
	^ '+Figure caption>', self figureFileUri, '+'

]

{ #category : #markups }
Gt2DocumentExamples >> contentWithHeaders [
	<gtExample>
	^ '! Header One
!! Header Two
!!! Header Three
!!!! Header Four
!!!!! Header Five
!!!!!! Header Six
!!!!!!! Header Seven'
]

{ #category : #markups }
Gt2DocumentExamples >> contentWithHeadersInEditingMode [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithHeaders.
	aDocument editingMode.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithHeaders.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #markups }
Gt2DocumentExamples >> contentWithHeadersInReadingMode [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithHeaders.
	aDocument readingMode.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithHeaders.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #'iceberg file' }
Gt2DocumentExamples >> contentWithIcebergFile [
	<gtExample>
	^ '${', self constants icebergFileAnnotationName, ':', self icebergFileName, '}$'

]

{ #category : #'input file' }
Gt2DocumentExamples >> contentWithInputFileToFigure [
	<gtExample>
	^ '${', self constants inputFileAnnotationName, ':', self anotherFileName , '}$'

]

{ #category : #'example - existing one' }
Gt2DocumentExamples >> contentWithInvalidParameter [
	<gtExample>
	^ '${', self constants exampleAnnotationName, ':', 
		self referencedMethod printString,
		'|hi|', '=true', '}$'
]

{ #category : #'example - existing one' }
Gt2DocumentExamples >> contentWithInvalidParameter2 [
	<gtExample>
	^ '${', self constants exampleAnnotationName, ':', 
		self referencedMethod printString,
		'||' , '}$'
]

{ #category : #'example - existing one' }
Gt2DocumentExamples >> contentWithInvalidParameter3 [
	<gtExample>
	^ '${', self constants exampleAnnotationName, ':', '}$'
]

{ #category : #markups }
Gt2DocumentExamples >> contentWithLists [
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

{ #category : #markups }
Gt2DocumentExamples >> contentWithMarkups [
	<gtExample>
	^ '""bold"" ''''italic'''' ==monospace== --strikethrought-- @@subscript@@ ^^superscript^^ __underline__ {{{raw}}}'
]

{ #category : #'method - multiple' }
Gt2DocumentExamples >> contentWithMultipleMethods [
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
Gt2DocumentExamples >> contentWithNotExistingClass [
	<gtExample>
	^ '${', self constants classAnnotationName, ':', self referencedNotExistingClass , '}$'

]

{ #category : #examples }
Gt2DocumentExamples >> contentWithNotExistingExamples [
	<gtExample>
	^ '${', self constants examplesAnnotationName, ':', 
		self constants classesParameterName , '=#(', 
			self referencedNotExistingClass, ')' , '}$'

]

{ #category : #examples }
Gt2DocumentExamples >> contentWithNotExistingPackageExamples [
	<gtExample>
	^ '${', self constants examplesAnnotationName, ':', 
		self constants packagesParameterName , '=#(''', 
			self referencedNotExistingPackageName, ''')' , '}$'

]

{ #category : #codeblock }
Gt2DocumentExamples >> contentWithSelfCodeblock [
	<gtExample>
	^ '[[[
self
]]]'

]

{ #category : #'input file' }
Gt2DocumentExamples >> contentWithSelfReferencedInputFile [
	<gtExample>
	^ '${', self constants inputFileAnnotationName, ':', memorySystem pillarFileName, '}$'

]

{ #category : #'example - two same in one document' }
Gt2DocumentExamples >> contentWithTwoExistingExamples [
	<gtExample>
	^ self contentWithExistingExample, String cr, String cr, 
		self contentWithExistingExample, String cr, String cr
]

{ #category : #'empty document' }
Gt2DocumentExamples >> defaultDocument [
	<gtExample>
	| aDocument |
	aDocument := Gt2Document new.
	self assert: aDocument text asString equals: self emptyContent.
	self assert: aDocument isSubscribedToSystem not.
	self assert: (SystemAnnouncer uniqueInstance hasSubscriber: aDocument) not.
	^ aDocument
]

{ #category : #demo }
Gt2DocumentExamples >> demoDocument [
	<gtExample>
	^ Gt2Document new fileReference: self demoFileReference; read.
]

{ #category : #'document updates' }
Gt2DocumentExamples >> demoDocumentUpdateError [
	<gtExample>
	| aDocument |
	aDocument := Gt2Document new fileReference: self demoFileReference; read.
	2 timesRepeat: [ 
		Object subclass: #DmAbAddressFoo
			instanceVariableNames: 'city country telephone'
			classVariableNames: ''
			package: 'AddressBookFoo'.
		4 milliSeconds wait.
		self class environment removeClassNamed: #DmAbAddressFoo.
		4 milliSeconds wait.
	 ].
	^ aDocument
]

{ #category : #demo }
Gt2DocumentExamples >> demoFileReference [
	<gtExample>
	^ self constants icebergRepositoriesLocation
			/ 'feenkcom'/ 'gtoolkit-demos' 
			/ 'doc' / 'tutorial' 
			/ 'smalltalks-2018-addressbook' / 'example-driven-development.pillar' 
]

{ #category : #'method - existing one' }
Gt2DocumentExamples >> documentDeleteAll [
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
Gt2DocumentExamples >> documentDeleteMethodAnnotation [
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
Gt2DocumentExamples >> documentFromClassComment [
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
Gt2DocumentExamples >> documentFromFileReference [
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

{ #category : #markups }
Gt2DocumentExamples >> documentInEditingModeWithMarkups [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument
		editingMode;
	 	text: self contentWithMarkups.
	self assert: aDocument text asString equals: self contentWithMarkups.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #markups }
Gt2DocumentExamples >> documentInReadingModeWithMarkups [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument
		readingMode;
	 	text: self contentWithMarkups.
	self assert: aDocument text asString equals: self contentWithMarkups.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #figure }
Gt2DocumentExamples >> documentWithBrokenFigure [
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

{ #category : #changes }
Gt2DocumentExamples >> documentWithClassDefinitionChanges [
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
Gt2DocumentExamples >> documentWithCodeblock [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithCodeblock.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithCodeblock.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #codeblock }
Gt2DocumentExamples >> documentWithCodeblockAndEmptyLineAfter [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithCodeblockAndEmptyLineAfter.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithCodeblockAndEmptyLineAfter.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #codeblock }
Gt2DocumentExamples >> documentWithCodeblockOnException [
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
Gt2DocumentExamples >> documentWithCommentedLine [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithCommentedLine.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithCommentedLine.
	^ aDocument
]

{ #category : #'method - existing one' }
Gt2DocumentExamples >> documentWithEditedExistingMethodAnnotation [
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
Gt2DocumentExamples >> documentWithEmptyCodeblock [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithEmptyCodeblock.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithEmptyCodeblock.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #changes }
Gt2DocumentExamples >> documentWithEpiceaChanges [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument fileReference: self fileReference.
	aDocument text: self contentWithEpiceaChanges.
	aDocument store.
	self assert: aDocument text asString equals: self contentWithEpiceaChanges.
	^ aDocument
]

{ #category : #'example - existing one' }
Gt2DocumentExamples >> documentWithExampleHiddenPreview [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExampleHiddenPreview.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExampleHiddenPreview.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - existing one' }
Gt2DocumentExamples >> documentWithExampleParameters [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExampleParameters.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExampleParameters.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #examples }
Gt2DocumentExamples >> documentWithExamples [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExamples.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithExamples.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #class }
Gt2DocumentExamples >> documentWithExistingClass [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingClass.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingClass.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - existing one' }
Gt2DocumentExamples >> documentWithExistingExample [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingExample.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithExistingExample.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'method - existing one' }
Gt2DocumentExamples >> documentWithExistingMethod [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExistingMethod.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExistingMethod.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'external link' }
Gt2DocumentExamples >> documentWithExternalLink [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExternalLink.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithExternalLink.
	^ aDocument
]

{ #category : #'external link' }
Gt2DocumentExamples >> documentWithExternalLinkInEditingMode [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExternalLink.
	aDocument editingMode.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithExternalLink.
	^ aDocument
]

{ #category : #'external link' }
Gt2DocumentExamples >> documentWithExternalLinkInReadingMode [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithExternalLink.
	aDocument readingMode.
	aDocument privateStyleText.
	self assert: aDocument text asString equals: self contentWithExternalLink.
	^ aDocument
]

{ #category : #figure }
Gt2DocumentExamples >> documentWithFigure [
	<gtExample>
	| aDocument aFigureFile |
	aFigureFile := self figureFileReference.
	self assert: aFigureFile exists.
	aDocument := self defaultDocument fileReference: self fileReferenceWithFigure.
	aDocument read.
	self assert: aDocument text asString equals: self contentWithFigure.
	^ aDocument
]

{ #category : #'iceberg file' }
Gt2DocumentExamples >> documentWithIcebergFile [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithIcebergFile.
	self assert: aDocument text asString equals: self contentWithIcebergFile.
	^ aDocument
]

{ #category : #'input file' }
Gt2DocumentExamples >> documentWithInputFileToFigure [
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
Gt2DocumentExamples >> documentWithInvalidParameter [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithInvalidParameter.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithInvalidParameter.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - existing one' }
Gt2DocumentExamples >> documentWithInvalidParameter2 [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithInvalidParameter2.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithInvalidParameter2.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #'example - existing one' }
Gt2DocumentExamples >> documentWithInvalidParameter3 [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithInvalidParameter3.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithInvalidParameter3.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #markups }
Gt2DocumentExamples >> documentWithLists [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithLists.
	self assert: aDocument text asString equals: self contentWithLists.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #markups }
Gt2DocumentExamples >> documentWithMarkups [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithMarkups.
	self assert: aDocument text asString equals: self contentWithMarkups.
	self assert: aDocument isSubscribedToSystem not.
	^ aDocument
]

{ #category : #'method - multiple' }
Gt2DocumentExamples >> documentWithMultipleMethods [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithMultipleMethods.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithMultipleMethods.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #class }
Gt2DocumentExamples >> documentWithNotExistingClass [
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
Gt2DocumentExamples >> documentWithNotExistingExamples [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithNotExistingExamples.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithNotExistingExamples.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #figure }
Gt2DocumentExamples >> documentWithNotExistingFigure [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument fileReference: self fileReferenceWithFigure.
	aDocument read.
	self assert: aDocument text asString equals: self contentWithFigure.
	^ aDocument
]

{ #category : #examples }
Gt2DocumentExamples >> documentWithNotExistingPackageExamples [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithNotExistingPackageExamples.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithNotExistingPackageExamples.
	self assert: aDocument isSubscribedToSystem.
	^ aDocument
]

{ #category : #codeblock }
Gt2DocumentExamples >> documentWithSelfCodeblock [
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
Gt2DocumentExamples >> documentWithSelfCodeblockOnClass [
	<gtExample>
	| aDocument |
	aDocument := self documentWithSelfCodeblock.
	aDocument classComment: self class.  
	aDocument privateStyleText.
	self assert: aDocument evaluationReceiver equals: self class.
	^ aDocument
]

{ #category : #codeblock }
Gt2DocumentExamples >> documentWithSelfCodeblockOnFileReference [
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
Gt2DocumentExamples >> documentWithSelfReferencedInputFile [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument fileReference: self fileReferenceWithSelfReferencedInputFile.
	aDocument read.
	self assert: aDocument text asString equals: self contentWithSelfReferencedInputFile.
	^ aDocument
]

{ #category : #'example - two same in one document' }
Gt2DocumentExamples >> documentWithTwoExistingExamples [
	<gtExample>
	| aDocument aCache |
	aDocument := self defaultDocument.
	aDocument editingMode; text: self contentWithTwoExistingExamples.
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
Gt2DocumentExamples >> emptyContent [
	<gtExample>
	^ ''

]

{ #category : #'empty document' }
Gt2DocumentExamples >> emptyDocument [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self emptyContent.
	self assert: aDocument text asString equals: self emptyContent.
	self assert: aDocument isSubscribedToSystem not.
	self assert: (SystemAnnouncer uniqueInstance hasSubscriber: aDocument) not.
	^ aDocument
]

{ #category : #changes }
Gt2DocumentExamples >> epicea [
	<gtExample>
	| aChangesFile anEpicea anAnnouncements |
	aChangesFile := self changesFileReferenceWithClassDefinition.
	anAnnouncements := OrderedCollection new.
	anEpicea := Gt2Epicea new.
	anEpicea 
		subscribe: Gt2EpiceaUpdatedAnnouncement 
		do: [ :anAnnouncement | anAnnouncements addLast: anAnnouncement ].
	anEpicea ombuFile: aChangesFile.
	self assert: anEpicea ombuFile equals: aChangesFile.
	self assert: anEpicea log notNil.
	self assert: anEpicea numberOfEvents equals: 1.
	self assert: anAnnouncements size equals: 1.
	^ anEpicea
]

{ #category : #accessing }
Gt2DocumentExamples >> examplesUtility [
	^ Gt2DocumentExamplesUtility
]

{ #category : #figure }
Gt2DocumentExamples >> figureContent [
	<gtExample>
	^ PolymorphSystemSettings pharoLogoContents base64Decoded asByteArray
]

{ #category : #figure }
Gt2DocumentExamples >> figureFileName [
	<gtExample>
	^ 'figure.png'

]

{ #category : #figure }
Gt2DocumentExamples >> figureFileReference [
	<gtExample>
	^ memorySystem addFileNamed: self figureFileName  withContent: self figureContent
]

{ #category : #figure }
Gt2DocumentExamples >> figureFileUri [
	<gtExample>
	^ 'file://', self figureFileName
]

{ #category : #'file reference document' }
Gt2DocumentExamples >> fileReference [
	<gtExample>
	^ memorySystem addPillarFileWithContent: self contentWithMultipleMethods
]

{ #category : #figure }
Gt2DocumentExamples >> fileReferenceWithFigure [
	<gtExample>
	^ memorySystem addPillarFileWithContent: self contentWithFigure
]

{ #category : #'input file' }
Gt2DocumentExamples >> fileReferenceWithInputFileToFigure [
	<gtExample>
	^ memorySystem addPillarFileWithContent: self contentWithInputFileToFigure
]

{ #category : #'input file' }
Gt2DocumentExamples >> fileReferenceWithSelfReferencedInputFile [
	<gtExample>
	^ memorySystem addPillarFileWithContent: self contentWithSelfReferencedInputFile
]

{ #category : #basic }
Gt2DocumentExamples >> fooString [
	<gtExample>
	^ 'Exemplifing'
]

{ #category : #basic }
Gt2DocumentExamples >> fooText [
	<gtExample>
	^ self fooString asRopedText
]

{ #category : #'iceberg file' }
Gt2DocumentExamples >> icebergFileName [
	<gtExample>
	^ 'feenkcom/gtoolkit-documenter/doc/index.pillar'
]

{ #category : #initialization }
Gt2DocumentExamples >> initialize [
	"We do define a globaly unique repository name because 
	${class:OmStoreFactory} uses full file name as an unique key."
	super initialize.
	memorySystem := GtFileSystemExamples new 
		rootDirectoryName: UUID new asString.
]

{ #category : #'file reference document' }
Gt2DocumentExamples >> modifyAndStoreToClassComment [
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
Gt2DocumentExamples >> modifyAndStoreToFileReference [
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
Gt2DocumentExamples >> ombuEntry [
	<gtExample>
	| anEpLog |
	anEpLog := EpLog fromFile: self changesFileReferenceWithClassDefinition.
	self assert: anEpLog entriesCount equals: 1.
	^ anEpLog entries first
]

{ #category : #'pillar parser' }
Gt2DocumentExamples >> parseRopedTextContent [
	<gtExample>
	"This one does not work yet. We need to improve Petit Parser to delegate string comparision."
	| aPRDocument |
	aPRDocument := self pillarParser parse: self contentWithExistingMethod asRopedText.
	self assert: aPRDocument notNil.
	self assert: aPRDocument isPetit2Failure not.
	^ aPRDocument
]

{ #category : #'pillar parser' }
Gt2DocumentExamples >> parseStringContent [
	<gtExample>
	| aPRDocument |
	aPRDocument := self pillarParser parse: self contentWithExistingMethod.
	self assert: aPRDocument notNil.
	self assert: aPRDocument isPetit2Failure not.
	^ aPRDocument
]

{ #category : #'pillar parser' }
Gt2DocumentExamples >> pillarParser [
	<gtExample>
	^ PRPillarParser new optimize.
	
]

{ #category : #accessing }
Gt2DocumentExamples >> reader [
	<gtExample>
	^ XdReaderWriterExamples new reader
]

{ #category : #class }
Gt2DocumentExamples >> referencedClass [
	<gtExample>
	^ self className
]

{ #category : #'example - existing one' }
Gt2DocumentExamples >> referencedExampleMethod [
	<gtExample>
	^ self class >> #documentWithMultipleMethods
]

{ #category : #'method - existing one' }
Gt2DocumentExamples >> referencedMethod [
	<gtExample>
	^ self class >> #referencedMethod
]

{ #category : #class }
Gt2DocumentExamples >> referencedNotExistingClass [
	<gtExample>
	^ self className, self fooString
]

{ #category : #examples }
Gt2DocumentExamples >> referencedNotExistingPackageName [
	<gtExample>
	^ self fooString, self class package name
]

{ #category : #changes }
Gt2DocumentExamples >> referencesChangesFile [
	<gtExample>
	^ '01-changes.ombu'
]

{ #category : #'empty document' }
Gt2DocumentExamples >> registeredDocument [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument.
	aDocument subscribe: SystemAnnouncement do: [ :anAnnouncement | "ignore" ] for: self.
	self assert: aDocument text asString equals: self emptyContent.
	self assert: aDocument isSubscribedToSystem.
	self assert: (SystemAnnouncer uniqueInstance hasSubscriber: aDocument).
	aDocument unsubscribe: self.
	self assert: aDocument isSubscribedToSystem not.
	self assert: (SystemAnnouncer uniqueInstance hasSubscriber: aDocument) not.
	^ aDocument
]

{ #category : #changes }
Gt2DocumentExamples >> removeEpiceaEvent [
	<gtExample>
	| anEpicea anAnnouncements |
	anEpicea := self epicea.
	anAnnouncements := OrderedCollection new.
	anEpicea 
		subscribe: Gt2EpiceaUpdatedAnnouncement 
		do: [ :anAnnouncement | anAnnouncements addLast: anAnnouncement ].
	anEpicea removeEvent: anEpicea events first.
	self assert: anEpicea numberOfEvents equals: 0.
	self assert: anAnnouncements size equals: 1.
	^ anEpicea
]

{ #category : #resourcer }
Gt2DocumentExamples >> resourcerWithAllDepthInfiniteRecursion [
	<gtExample>
	<noTest>
	| aDocument aCollectionOfFigures anInputFile |
	aDocument := self documentWithSelfReferencedInputFile.
	aCollectionOfFigures := aDocument resourcer includeAll; allDepth; compute.
	self assert: aCollectionOfFigures isCollection.
	self assert: aCollectionOfFigures size equals: 1.
	anInputFile := aCollectionOfFigures first.
	self assert: anInputFile name equals: memorySystem pillarFileName.
	self assert: anInputFile document equals: aDocument.
	self assert: anInputFile resource notNil.
	self assert: anInputFile resource exists.
	^ anInputFile
]

{ #category : #resourcer }
Gt2DocumentExamples >> resourcerWithFigure [
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
Gt2DocumentExamples >> resourcerWithIcebergFile [
	<gtExample>
	| aDocument aCollectionOfIcebergFiles anIcebergFile |
	aDocument := self documentWithIcebergFile.
	aCollectionOfIcebergFiles := aDocument resourcer includeIcebergFiles; compute.
	self assert: aCollectionOfIcebergFiles isCollection.
	self assert: aCollectionOfIcebergFiles size equals: 1.
	anIcebergFile := aCollectionOfIcebergFiles first.
	self assert: anIcebergFile name equals: self icebergFileName.
	self assert: anIcebergFile source equals: aDocument.
	self assert: anIcebergFile document notNil.
	self assert: anIcebergFile document exists.
	^ anIcebergFile
]

{ #category : #resourcer }
Gt2DocumentExamples >> resourcerWithInputFile [
	<gtExample>
	| aDocument aCollectionOfInputFiles anInputFile |
	aDocument := self documentWithSelfReferencedInputFile.
	aCollectionOfInputFiles := aDocument resourcer includeInputFiles; compute.
	self assert: aCollectionOfInputFiles isCollection.
	self assert: aCollectionOfInputFiles size equals: 1.
	anInputFile := aCollectionOfInputFiles first.
	self assert: anInputFile name equals: memorySystem pillarFileName.
	self assert: anInputFile source equals: aDocument.
	self assert: anInputFile document notNil.
	self assert: anInputFile document exists.
	^ anInputFile
]

{ #category : #resourcer }
Gt2DocumentExamples >> resourcerWithInputFileToFigure [
	<gtExample>
	| aDocument aCollectionOfResources anInputFile |
	aDocument := self documentWithInputFileToFigure.
	aCollectionOfResources := aDocument resourcer includeAll; allDepth; compute.
	self assert: aCollectionOfResources isCollection.
	self assert: aCollectionOfResources size equals: 2.
	anInputFile := aCollectionOfResources first.
	self assert: anInputFile name equals: self anotherFileName.
	self assert: anInputFile source equals: aDocument.
	self assert: anInputFile document notNil.
	self assert: anInputFile document exists.
	^ anInputFile
]

{ #category : #'non technical people' }
Gt2DocumentExamples >> ropeHiddenBoldMarkupForNonTechnicalPeople [
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
	(aRope from: 1 to: 2) attribute: Gt2HideAttribute uniqueInstance.
	(aRope from: 7 to: 8) attribute: Gt2HideAttribute uniqueInstance.
	(aRope from: 3 to: 6) attribute: aSwitchAttribute.
	^ aRope
]

{ #category : #writing }
Gt2DocumentExamples >> writeDocumentWithImages [
	<gtExample>
	
	| aWriter aXdFile |
	aWriter := self writer.
	aXdFile := aWriter
		streamingStrategy: XdStreamingStrategy bytes;
		pillar: self documentWithFigure;
		write.
	self assert: aXdFile notNil.
	self assert: aXdFile manifest notNil.
	self assert: aXdFile manifest documents size equals: 1.
	self
		assert: aXdFile manifest documents first type
		equals: XdPillarType.
	self
		assert: aXdFile manifest documents first components size
		equals: 1.
	self
		assert: aXdFile manifest documents first components first link
		equals: '1'.
	self assert: aXdFile manifest attachments size equals: 1.
	self assert: aXdFile manifest attachments first id equals: '1'.
	self
		assert: aXdFile manifest attachments first fileName
		equals: self demoFileReference entry name.
	self
		assert: aXdFile manifest attachments first fileSize
		equals: self demoFileReference size.
	self assert: aXdFile streamingStrategy notNil.
	self assert: aXdFile exists.
	self assert: aXdFile streamingStrategy zip members size equals: 2.
	^ aXdFile
]

{ #category : #writing }
Gt2DocumentExamples >> writePlainDocument [
	<gtExample>
	
	| aWriter aXdFile |
	aWriter := self writer.
	aXdFile := aWriter
		streamingStrategy: XdStreamingStrategy bytes;
		pillar: self demoDocument;
		write.
	self assert: aXdFile notNil.
	self assert: aXdFile manifest notNil.
	self assert: aXdFile manifest documents size equals: 1.
	self
		assert: aXdFile manifest documents first type
		equals: XdPillarType.
	self
		assert: aXdFile manifest documents first components size
		equals: 1.
	self
		assert: aXdFile manifest documents first components first link
		equals: '1'.
	self assert: aXdFile manifest attachments size equals: 1.
	self assert: aXdFile manifest attachments first id equals: '1'.
	self
		assert: aXdFile manifest attachments first fileName
		equals: self demoFileReference entry name.
	self
		assert: aXdFile manifest attachments first fileSize
		equals: self demoFileReference size.
	self assert: aXdFile streamingStrategy notNil.
	self assert: aXdFile exists.
	self assert: aXdFile streamingStrategy zip members size equals: 2.
	^ aXdFile
]

{ #category : #accessing }
Gt2DocumentExamples >> writer [
	<gtExample>
	^ XdReaderWriterExamples new writer
]
