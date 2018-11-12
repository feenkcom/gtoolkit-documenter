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

{ #category : #'epicea support' }
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

{ #category : #'changes - existing file' }
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

{ #category : #'changes - existing file' }
Gt2DocumentExamples >> changesDirectory [
	<gtExample>
	| epiceaDir |
	epiceaDir := (memorySystem rootDirectory / self changesDirectoryName).
	epiceaDir ensureCreateDirectory.
	self assert: epiceaDir exists.
	^ epiceaDir
]

{ #category : #'changes - existing file' }
Gt2DocumentExamples >> changesDirectoryName [
	<gtExample>
	^ 'changes'
]

{ #category : #'changes - existing file' }
Gt2DocumentExamples >> changesFileNameWithClassDefinition [
	<gtExample>
	^ 'class-definition.ombu'
]

{ #category : #'changes - existing file' }
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

{ #category : #'changes - existing file' }
Gt2DocumentExamples >> contentWithClassDefinitionChanges [
	<gtExample>
	^ '${', self constants changesAnnotationName, ':', 
			self changesDirectoryName, '/', self changesFileNameWithClassDefinition , '}$'
]

{ #category : #codeblock }
Gt2DocumentExamples >> contentWithCodeblock [
	<gtExample>
	^ '[[[label=Evaluate
4 factorial.
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

{ #category : #'commented line' }
Gt2DocumentExamples >> contentWithCommentedLine [
	<gtExample>
	^ '%% a commented line'
]

{ #category : #'changes - not existing file' }
Gt2DocumentExamples >> contentWithEpiceaChanges [
	<gtExample>
	^ '${', self constants changesAnnotationName, ':', self referencesChangesFile , '}$'

]

{ #category : #'class - existing one' }
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
	^ '*Feenk>https://feenk.com*'
]

{ #category : #'iceberg file' }
Gt2DocumentExamples >> contentWithIcebergFile [
	<gtExample>
	^ '${', self constants icebergFileAnnotationName, ':', self icebergFileName, '}$'

]

{ #category : #'input file' }
Gt2DocumentExamples >> contentWithInputFile [
	<gtExample>
	^ '${', self constants inputFileAnnotationName, ':', memorySystem pillarFileName, '}$'

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

{ #category : #demo }
Gt2DocumentExamples >> demoDocument2 [
	<gtExample>
	^ Gt2Document new fileReference: self demoFileReference2; read.
]

{ #category : #demo }
Gt2DocumentExamples >> demoFileReference [
	<gtExample>
	^ GtIcebergUtility repositoriesLocation 
			/ 'feenkcom'/ 'gtoolkit-demos' 
			/ 'doc' / 'tutorial' 
			/ 'smalltalks-2018-addressbook' / 'example-driven-development.pillar' 
]

{ #category : #demo }
Gt2DocumentExamples >> demoFileReference2 [
	<gtExample>
	^ GtIcebergUtility repositoriesLocation 
			/ 'feenkcom'/ 'gtoolkit-demos' 
			/ 'doc' / 'tutorial' 
			/ 'smalltalks-2018-addressbook' / 'example-driven-development-2.pillar' 
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

{ #category : #'changes - existing file' }
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
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithCodeblock.
	"self assert: aDocument isSubscribedToSystem."
	^ aDocument
]

{ #category : #codeblock }
Gt2DocumentExamples >> documentWithCodeblockAndEmptyLineAfter [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithCodeblockAndEmptyLineAfter.
	aDocument editor styleText.
	self assert: aDocument text asString equals: self contentWithCodeblockAndEmptyLineAfter.
	"self assert: aDocument isSubscribedToSystem."
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

{ #category : #'changes - not existing file' }
Gt2DocumentExamples >> documentWithEpiceaChanges [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument fileReference: self fileReference.
	aDocument text: self contentWithEpiceaChanges.
	aDocument store.
	self assert: aDocument text asString equals: self contentWithEpiceaChanges.
	^ aDocument
]

{ #category : #'class - existing one' }
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
	aDocument editor styleText.
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

{ #category : #'iceberg file' }
Gt2DocumentExamples >> documentWithIcebergFile [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument text: self contentWithIcebergFile.
	self assert: aDocument text asString equals: self contentWithIcebergFile.
	^ aDocument
]

{ #category : #'input file' }
Gt2DocumentExamples >> documentWithInputFile [
	<gtExample>
	| aDocument |
	aDocument := self defaultDocument fileReference: self fileReferenceWithInputFile.
	aDocument read.
	self assert: aDocument text asString equals: self contentWithInputFile.
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

{ #category : #'example - two same in one document' }
Gt2DocumentExamples >> documentWithTwoExistingExamples [
	<gtExample>
	| aDocument aCache |
	aDocument := self defaultDocument text: self contentWithTwoExistingExamples.
	aDocument editor styleText.
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

{ #category : #'epicea support' }
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

{ #category : #'file reference document' }
Gt2DocumentExamples >> fileReference [
	<gtExample>
	^ memorySystem addPillarFileWithContent: self contentWithMultipleMethods
]

{ #category : #'input file' }
Gt2DocumentExamples >> fileReferenceWithInputFile [
	<gtExample>
	^ memorySystem addPillarFileWithContent: self contentWithInputFile
]

{ #category : #basic }
Gt2DocumentExamples >> fooText [
	<gtExample>
	^ 'Foo' asRopedText
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

{ #category : #'epicea support' }
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

{ #category : #'class - existing one' }
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

{ #category : #'changes - not existing file' }
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

{ #category : #'epicea support' }
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
