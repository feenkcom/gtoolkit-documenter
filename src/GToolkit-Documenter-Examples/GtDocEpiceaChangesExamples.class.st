Class {
	#name : #GtDocEpiceaChangesExamples,
	#superclass : #GtDocAbstractExamples,
	#category : 'GToolkit-Documenter-Examples'
}

{ #category : #'class definition' }
GtDocEpiceaChangesExamples >> documentPartWithClassDefinition [
	<gtExample>
	<label: 'Document part with Epicea changes with class definition'>
	| aDocument |
	aDocument := self documentWithClassDefinition.
	self flag: 'We should likely remember Epicea document parts'.
	^ aDocument
"	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet epiceaLog notNil.
	self assert: aCodeSnippet epiceaLog ombuFile exists.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet"
]

{ #category : #'empty definition' }
GtDocEpiceaChangesExamples >> documentPartWithEmptyDefinition [
	<gtExample>
	<label: 'Code snippet of a document with an Epicea code changes with empty definition'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithEmptyDefinition.
	self flag: 'Should Epicea be stored in the document?'.
	"aCodeSnippet := aDocument documentParts codeSnippetAt: 1.
	self assert: aCodeSnippet epiceaLog notNil.
	self assert: aCodeSnippet epiceaLog ombuFile exists not.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet"
	^ aDocument
]

{ #category : #'add event to non-existent ombu file' }
GtDocEpiceaChangesExamples >> documentPartWithRecentlyAddedDefinition [
	<gtExample>
	<label: 'Document with an example code snippet with recently added definition'>
	self flag: 'How can we test it without having a reference to a Epicea document part?'.
	"| aCodeSnippet anEpEvent anEpLog anAnnouncements |
	aCodeSnippet := self codeSnippetOfDocumentWithEmptyDefinition.
	anEpLog := EpLog fromFile: self ombuFileReferenceWithClassDefinition.
	self assert: anEpLog entries size equals: 1.
	anEpEvent := anEpLog entries first.
	self assert: aCodeSnippet epiceaLog ombuFile exists not.
	anAnnouncements := OrderedCollection new.
	aCodeSnippet 
		subscribe: GtEpiceaImpactChangedAnnouncement 
		do: [ :anAnnouncement | anAnnouncements add: anAnnouncement ].
	aCodeSnippet epiceaLog addEntryWith: anEpEvent content tags: [ :tags |  ].
	aCodeSnippet epiceaLog flush.
	self assert: aCodeSnippet epiceaLog ombuFile exists.
	self assert: anAnnouncements size equals: 1.
	self assert: anAnnouncements first class equals: GtEpiceaImpactChangedAnnouncement.
	self assert: anAnnouncements first hasImpact.
	^ aCodeSnippet"
]

{ #category : #'class definition' }
GtDocEpiceaChangesExamples >> documentWithClassDefinition [
	<gtExample>
	<label: 'Document with Epicea changes with class definition'>
	| aTextElement aDocument |
	aTextElement := self textElementWithClassDefinition.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	self flag: 'We should likely remember Epicea document parts'.
	"documentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: documentPart class 
		equals: aClass.
	self assert: documentPart result isNil."
	^ aDocument
]

{ #category : #'empty definition' }
GtDocEpiceaChangesExamples >> documentWithEmptyDefinition [
	<gtExample>
	<label: 'Document with an Epicea code changes with empty definition'>
	| aTextElement aDocument codeSnippet |
	aTextElement := self textElementWithEmptyDefinition.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	"codeSnippet := aDocument documentParts codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtEpiceaChanges.
	self assert: codeSnippet result isNil."
	^ aDocument
]

{ #category : #'change files' }
GtDocEpiceaChangesExamples >> epiceaChangeDirectory [
	<gtExample>
	<label: 'Directory with Epicea changes'>
	| epiceaDir |
	epiceaDir := (fileSystemExamples rootDirectory / self epiceaChangeDirectoryName).
	epiceaDir ensureCreateDirectory.
	self assert: epiceaDir exists.
	^ epiceaDir
]

{ #category : #'change files' }
GtDocEpiceaChangesExamples >> epiceaChangeDirectoryName [
	<gtExample>
	<label: 'Directory with Epicea changes'>
	^ 'changes'
]

{ #category : #'class definition' }
GtDocEpiceaChangesExamples >> epiceaContentWithClassDefinition [
	<gtExample>
	<label: 'Epicea changes with a class definition'>
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

{ #category : #'class definition' }
GtDocEpiceaChangesExamples >> epiceaFileNameWithClassDefinition [
	<gtExample>
	<label: 'Epicea change filename with class definition'>
	^ 'class-definition.ombu'
]

{ #category : #'class definition' }
GtDocEpiceaChangesExamples >> fileReferenceWithClassDefinition [
	<gtExample>
	<label: 'Pillar file reference with Epicea changes with class definition'>
	| fileReference |
	self ombuFileReferenceWithClassDefinition.
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithClassDefinition.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'empty definition' }
GtDocEpiceaChangesExamples >> fileReferenceWithEmptyDefinition [
	<gtExample>
	<label: 'Pillar file reference with an example code snippet with empty definition'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithEmptyDefinition.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #initialization }
GtDocEpiceaChangesExamples >> initialize [
	"We do define a globaly unique repository name because 
	${class:OmStoreFactory} uses full file name as an unique key."
	super initialize.
	fileSystemExamples rootDirectoryName: UUID new asString.
]

{ #category : #'class definition' }
GtDocEpiceaChangesExamples >> ombuFileReferenceWithClassDefinition [
	<gtExample>
	<label: 'File reference of epicea changes with a class definition'>
	^ fileSystemExamples 
			addFileNamed: self epiceaFileNameWithClassDefinition
			toDirectory: self epiceaChangeDirectory 
			withContent: self epiceaContentWithClassDefinition.
]

{ #category : #'class definition' }
GtDocEpiceaChangesExamples >> pillarContentWithClassDefinition [
	<gtExample>
	<label: 'Pillar content with an Epicea changes with class definition'>
	^ '${changes:ombu/class-definition.ombu}$'
]

{ #category : #'empty definition' }
GtDocEpiceaChangesExamples >> pillarContentWithEmptyDefinition [
	<gtExample>
	<label: 'Pillar content with an Epicea code changes with empty definition'>
	^ '${changes:ombu/non-existent-file.ombu}$'
]

{ #category : #'class definition' }
GtDocEpiceaChangesExamples >> textElementWithClassDefinition [
	<gtExample>
	<label: 'Pillar element with Epicea changes with class definition'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithClassDefinition.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement
]

{ #category : #'empty definition' }
GtDocEpiceaChangesExamples >> textElementWithEmptyDefinition [
	<gtExample>
	<label: 'Pillar element with an Epicea code changes with empty definition'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithEmptyDefinition.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement
]
