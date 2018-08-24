Class {
	#name : #GtOldEpiceaCodeSnippetExamples,
	#superclass : #GtOldDebuggableCodeSnippetExamples,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #'class definition' }
GtOldEpiceaCodeSnippetExamples >> codeSnippetOfDocumentWithClassDefinition [
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with class definition'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithClassDefinition.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet epiceaLog notNil.
	self assert: aCodeSnippet epiceaLog ombuFile exists.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet
]

{ #category : #'empty definition' }
GtOldEpiceaCodeSnippetExamples >> codeSnippetOfDocumentWithEmptyDefinition [
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with empty definition'>
	| aDocument aCodeSnippet |
	aDocument := self documentWithEmptyDefinition.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet epiceaLog notNil.
	self assert: aCodeSnippet epiceaLog ombuFile exists not.
	self assert: aCodeSnippet hasResult not.
	^ aCodeSnippet
]

{ #category : #'add event to non-existent ombu file' }
GtOldEpiceaCodeSnippetExamples >> codeSnippetOfDocumentWithRecentlyAddedDefinition [
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with recently added definition'>
	| aCodeSnippet anEpEvent anEpLog anAnnouncements |
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
	^ aCodeSnippet
]

{ #category : #'class definition' }
GtOldEpiceaCodeSnippetExamples >> documentWithClassDefinition [
	<gtExample>
	<label: 'Document with an example code snippet with class definition'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithClassDefinition.
	aDocument := GtOldDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtOldEpiceaCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument
]

{ #category : #'empty definition' }
GtOldEpiceaCodeSnippetExamples >> documentWithEmptyDefinition [
	<gtExample>
	<label: 'Document with an example code snippet with empty definition'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithEmptyDefinition.
	aDocument := GtOldDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtOldEpiceaCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument
]

{ #category : #'ombu files' }
GtOldEpiceaCodeSnippetExamples >> epiceaChangeDirectory [
	<gtExample>
	<label: 'Directory with Epicea changes'>
	| epiceaDir |
	epiceaDir := (fileSystemExamples rootDirectory / self epiceaChangeDirectoryName).
	epiceaDir ensureCreateDirectory.
	self assert: epiceaDir exists.
	^ epiceaDir
]

{ #category : #'ombu files' }
GtOldEpiceaCodeSnippetExamples >> epiceaChangeDirectoryName [
	<gtExample>
	<label: 'Directory with Epicea changes'>
	^ 'ombu'
]

{ #category : #'class definition' }
GtOldEpiceaCodeSnippetExamples >> epiceaContentWithClassDefinition [
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
GtOldEpiceaCodeSnippetExamples >> epiceaFileNameWithClassDefinition [
	<gtExample>
	<label: 'Epicea change filename with class definition'>
	^ 'class-definition.ombu'
]

{ #category : #'class definition' }
GtOldEpiceaCodeSnippetExamples >> fileReferenceWithClassDefinition [
	<gtExample>
	<label: 'Pillar file reference with an example code snippet with class definition'>
	| fileReference |
	self ombuFileReferenceWithClassDefinition.
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithClassDefinition.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference
]

{ #category : #'empty definition' }
GtOldEpiceaCodeSnippetExamples >> fileReferenceWithEmptyDefinition [
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
GtOldEpiceaCodeSnippetExamples >> initialize [
	super initialize.
	fileSystemExamples rootDirectoryName: UUID new asString
]

{ #category : #'class definition' }
GtOldEpiceaCodeSnippetExamples >> ombuFileReferenceWithClassDefinition [
	<gtExample>
	<label: 'File reference of epicea changes with a class definition'>
	^ fileSystemExamples 
			addFileNamed: self epiceaFileNameWithClassDefinition
			toDirectory: self epiceaChangeDirectory 
			withContent: self epiceaContentWithClassDefinition.
]

{ #category : #'class definition' }
GtOldEpiceaCodeSnippetExamples >> pillarContentWithClassDefinition [
	<gtExample>
	<label: 'Pillar content with an Epicea code snippet with class definition'>
	^ '
[[[epicea=ombu/class-definition.ombu]]]
'

]

{ #category : #'empty definition' }
GtOldEpiceaCodeSnippetExamples >> pillarContentWithEmptyDefinition [
	<gtExample>
	<label: 'Pillar content with an Epicea code snippet with empty definition'>
	^ '
[[[epicea=ombu/non-existent-file.ombu]]]
'

]

{ #category : #'class definition' }
GtOldEpiceaCodeSnippetExamples >> pillarElementWithClassDefinition [
	<gtExample>
	<label: 'Pillar element with an example code snippet with class definition'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithClassDefinition.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtOldDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement
]

{ #category : #'empty definition' }
GtOldEpiceaCodeSnippetExamples >> pillarElementWithEmptyDefinition [
	<gtExample>
	<label: 'Pillar element with an example code snippet with empty definition'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithEmptyDefinition.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtOldDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement
]
