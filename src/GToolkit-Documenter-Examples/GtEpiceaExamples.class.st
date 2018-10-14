Class {
	#name : #GtEpiceaExamples,
	#superclass : #Object,
	#instVars : [
		'fileSystemExamples'
	],
	#category : #'GToolkit-Documenter-Examples'
}

{ #category : #'file system' }
GtEpiceaExamples >> directoryWithPillarAndEpiceaFiles [
	<gtExample>
	<label: 'Directory with Pillar and Epicea files'>
	| rootDocument epiceaDir stepOne stepTwo |
	rootDocument := fileSystemExamples addPillarFileWithContent: self pillarContent.
	epiceaDir := (fileSystemExamples rootDirectory / self epiceaDirectoryFileName).
	epiceaDir ensureCreateDirectory.
	stepOne := fileSystemExamples 
		addFileNamed: self epiceaStepOneFileName 
		toDirectory: epiceaDir 
		withContent: self epiceaStepOneContent.
	stepTwo := fileSystemExamples 
		addFileNamed: self epiceaStepTwoFileName 
		toDirectory: epiceaDir 
		withContent: self epiceaStepTwoContent.
	self assert: rootDocument exists.
	self assert: epiceaDir exists.
	self assert: stepOne exists.
	self assert: stepTwo exists.
	^ fileSystemExamples rootDirectory
]

{ #category : #'source files' }
GtEpiceaExamples >> epiceaDirectoryFileName [
	<gtExample>
	<label: 'Epicea directory name'>
	^ 'ombu'
]

{ #category : #'source files' }
GtEpiceaExamples >> epiceaStepOneContent [
	<gtExample>
	<label: 'Epicea changes for the step one'>
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

{ #category : #'source files' }
GtEpiceaExamples >> epiceaStepOneFileName [
	<gtExample>
	<label: 'Epicea change filename for step one'>
	^ 'step-one.ombu'
]

{ #category : #'source files' }
GtEpiceaExamples >> epiceaStepTwoContent [
	<gtExample>
	<label: 'Epicea changes for the step two'>
	^ 'OmEntry {
	#tags : {
		#prior : OmNullReference [  ],
		#self : OmReference [ ''1'' ]
	},
	#content : EpMethodAddition {
		#method : RGMethodDefinition {
			#annotations : IdentityDictionary {
				#className : #MyClassOne,
				#isMetaSide : false
			},
			#name : #varOne,
			#protocol : #accessing,
			#sourceCode : ''varOne\r\t^ varOne'',
			#stamp : ''JurajKubelka 4/8/2018 12:02'',
			#package : #MyTestingPackage
		}
	}
}

OmEntry {
	#tags : {
		#prior : OmReference [ ''1'' ],
		#self : OmReference [ ''2'' ]
	},
	#content : EpMethodAddition {
		#method : RGMethodDefinition {
			#annotations : IdentityDictionary {
				#className : #MyClassOne,
				#isMetaSide : false
			},
			#name : #''varOne:'',
			#protocol : #accessing,
			#sourceCode : ''varOne: anObject\r\tvarOne := anObject'',
			#stamp : ''JurajKubelka 4/8/2018 12:02'',
			#package : #MyTestingPackage
		}
	}
}'
]

{ #category : #'source files' }
GtEpiceaExamples >> epiceaStepTwoFileName [
	<gtExample>
	<label: 'Epicea change filename for step two'>
	^ 'step-two.ombu'
]

{ #category : #initialization }
GtEpiceaExamples >> initialize [
	super initialize.
	fileSystemExamples := GtFileSystemExamples new 
]

{ #category : #'source files' }
GtEpiceaExamples >> pillarContent [
	<gtExample>
	<label: 'Pillar content with Epicea link'>
	^ '! This is an example of build-in Epicea change

First, define a class with one instance variable:

[[[epicea=ombu/step-one.ombu]]]

Second, define accessors to the instance variable:

[[[epicea=ombu/step-two.ombu]]]

Third, you can create a new change file by writting its definition and pressing the create button:

[[[epicea=ombu/step-three.ombu]]]
'

]

{ #category : #'file system' }
GtEpiceaExamples >> pillarDocumentWithEpiceaChanges [
	<gtExample>
	<label: 'Pillar document with Epicea changes'>
	| fileReference |
	self directoryWithPillarAndEpiceaFiles.
	fileReference := fileSystemExamples pillarFileReference.
	self assert: fileReference exists.
	^ fileReference
]

{ #category : #diff }
GtEpiceaExamples >> ropeDiff [
	<gtExample>
	<label: 'A way to do BrRope diff'>
	| text |
	text := '' asRopedText.
	(PrettyTextDiffBuilder 
		from: (True >> #and:) sourceCode 
		to: (True >> #or:) sourceCode)
		patchSequenceDoIfMatch: [ :string | | initialPosition |
			initialPosition := text size max: 1.
			text insertString: '  ' at: text size.
			text insertString: string at: text size.
			(text from: initialPosition to: text size)
				foreground: Color black.
			text insertString: String cr at: text size. ]
		ifInsert: [ :string | | initialPosition |
			initialPosition := text size max: 1.
			text insertString: '+ ' at: text size.
			text insertString: string at: text size.
			(text from: initialPosition to: text size)
				foreground: Color green muchDarker.
			text insertString: String cr at: text size. ]
		ifRemove: [ :string | | initialPosition |
			initialPosition := text size max: 1.
			text insertString: '- ' at: text size.
			text insertString: string at: text size.
			(text from: initialPosition to: text size)
				foreground: Color red muchDarker.
			text insertString: String cr at: text size. ].
	text attributes: { BlFontGenericFamilyAttribute monospace }.
	^ text
]

{ #category : #diff }
GtEpiceaExamples >> stringDiff [
	<gtExample>
	<label: 'A way to do string diff'>
	^ String streamContents: [ :aStream |
			(PrettyTextDiffBuilder 
				from: (True >> #and:) sourceCode 
				to: (True >> #or:) sourceCode)
				patchSequenceDoIfMatch: [ :string | aStream space; space; nextPutAll: string; cr ]
				ifInsert: [ :string | aStream nextPutAll: '+ '; nextPutAll: string; cr ]
				ifRemove: [ :string | aStream nextPutAll: '- '; nextPutAll: string; cr ] ].
]
