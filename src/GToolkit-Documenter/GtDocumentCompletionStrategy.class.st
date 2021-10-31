Class {
	#name : #GtDocumentCompletionStrategy,
	#superclass : #GtCompletionStrategy,
	#traits : 'TGtDocumentConstants',
	#classTraits : 'TGtDocumentConstants classTrait',
	#instVars : [
		'directory',
		'annotationTags',
		'max',
		'position',
		'tagName',
		'exampleClasses',
		'allClasses',
		'gtViewSelectors',
		'allAlignments',
		'text'
	],
	#classVars : [
		'ParameterValueCompletionSelectors'
	],
	#category : 'GToolkit-Documenter-Completer'
}

{ #category : #accessing }
GtDocumentCompletionStrategy class >> constants [
	^ GtDocumentConstants
]

{ #category : #'class initialization' }
GtDocumentCompletionStrategy class >> initialize [
	ParameterValueCompletionSelectors := Dictionary new.
	ParameterValueCompletionSelectors
		at: GtChangesAnnotation
			put:
			(Dictionary new
				at: self constants pathParameterName put: #filenamesStartingWith:;
				yourself);
		at: GtClassAnnotation
			put:
			(Dictionary new
				at: self constants nameParameterName put: #classesStartingWith:;
				at: self constants showParameterName put: #examplePreviewShowMethodsStartingWith:;
				yourself);
		at: GtExampleAnnotation
			put:
			(Dictionary new
				at: self constants nameParameterName put: #exampleMethodsStartingWith:;
				at: self constants previewShowParameterName put: #examplePreviewShowMethodsStartingWith:;
				at: self constants alignmentParameterName put: #alignmentValueStartingWith:;
				yourself);
		at: GtMethodAnnotation
			put:
			(Dictionary new
				at: self constants nameParameterName put: #methodsStartingWith:;
				at: self constants showParameterName put: #examplePreviewShowMethodsStartingWith:;
				yourself);
		at: GtIcebergFileAnnotation
			put:
			(Dictionary new
				at: self constants pathParameterName put: #icebergFilenamesStartingWith:;
				at: self constants showParameterName put: #examplePreviewShowMethodsStartingWith:;
				yourself);
		at: PRInputFileAnnotation
			put:
			(Dictionary new
				at: self constants pathParameterName put: #filenamesStartingWith:;
				at: self constants showParameterName put: #examplePreviewShowMethodsStartingWith:;
				yourself)
		
]

{ #category : #private }
GtDocumentCompletionStrategy >> alignmentValueStartingWith: aString [
	| aName |
	aName := aString asString.
	^ (self allAlignmentValues first: max startingWith: aName)
		collect: [ :each | 
			self
				complete: each
				with: (each allButFirst: aName size)
				deleting: 0
				at: position
				prefixSize: aName size ]
]

{ #category : #accessing }
GtDocumentCompletionStrategy >> allAlignmentValues [
	^ allAlignments ifNil: [ allAlignments := GtPrefixTree withAll: (AlignmentStrategy allSubclasses collect: [ :each | each strategyName ]) ]
]

{ #category : #private }
GtDocumentCompletionStrategy >> allAnnotationActions [
	^ (annotationTags first: max startingWith: '$')
		collect: [ :each | 
			self
				complete: each
				with: each allButFirst
				deleting: 0
				at: position
				prefixSize: 1 ]
]

{ #category : #accessing }
GtDocumentCompletionStrategy >> allClasses [
	^ allClasses ifNil: [ allClasses := GtPrefixTree withAll: (ProtoObject withAllSubclasses collect: [ :each | each name ]) ]
]

{ #category : #'private-annotations' }
GtDocumentCompletionStrategy >> annotationActionsIn: aString startAt: annotationStart [
	self annotationRegex
		matchesIn: aString
		subexpressionsDo: [ :str :parts | 
			| tag |
			tag := parts first.
			(position between: annotationStart and: annotationStart + tag size - 1)
				ifTrue: [ ^ self annotationTagActionsFor: tag startAt: annotationStart ].
			(parts at: 3)
				ifNotNil: [ :params | 
					tagName := parts at: 2.
					^ self annotationParametersActionsFor: params startAt: annotationStart + tag size - 1 ] ].
	^ #()
]

{ #category : #'private-annotations' }
GtDocumentCompletionStrategy >> annotationClass [
	^ PRAbstractAnnotation withAllSubclasses
		detect: [ :each | each tag = tagName ]
		ifNone: [ nil ]
]

{ #category : #'private-annotations' }
GtDocumentCompletionStrategy >> annotationParameterActionsFor: parameterString startAt: parameterStart [
	self parameterRegex
		matchesIn: parameterString
		subexpressionsDo: [ :str :parts | 
			| name value nameWithoutEquals hasEquals |
			name := parts first.
			value := parts last.
			name ifNil: [ 
				name := value.
				value := '' ].
			nameWithoutEquals := name copyWithout: $=.
			hasEquals := name ~= nameWithoutEquals.
			^ (position between: parameterStart and: parameterStart + nameWithoutEquals size - 1)
				ifTrue: [ self
						parametersStartingWith: (name first: position - parameterStart + 1)
						delete:
							(hasEquals
								ifTrue: [ parameterStart + nameWithoutEquals size - position ]
								ifFalse: [ 0 ])
						includeDefaultValues: hasEquals not ]
				ifFalse: [ self
						parameterValueActionsForClass: self annotationClass
						name: nameWithoutEquals
						startingWith: (value first: position - (parameterStart + name size - 1)) ] ].
	^ #()
]

{ #category : #'private-annotations' }
GtDocumentCompletionStrategy >> annotationParametersActionsFor: parametersString startAt: parametersStart [
	| char |
	(self parameterRegex matchingRangesIn: parametersString)
		do: [ :each | 
			(position between: each first + parametersStart and: each last + parametersStart)
				ifTrue: [ ^ self annotationParameterActionsFor: (parametersString copyFrom: each first to: each last) startAt: parametersStart + each first ] ].
	char := text at: position.
	(':|' includes: char)
		ifTrue: [ ^ self parametersStartingWith: '' delete: 0 includeDefaultValues: true ].
	^ #()
]

{ #category : #private }
GtDocumentCompletionStrategy >> annotationRegex [
	^ '(\$\{([^$:| \s}]*))(([:|](([-a-zA-Z0-9]+=)?[^|}[:cntrl:]]+)*)*)(}?\$?)' asRegex
]

{ #category : #'private-annotations' }
GtDocumentCompletionStrategy >> annotationTagActionsFor: tagString startAt: annotationStart [
	| prefix |
	prefix := tagString first: position - annotationStart + 1.
	^ (annotationTags first: max startingWith: prefix)
		collect: [ :each | 
			self
				complete: each
				with: (each allButFirst: prefix size)
				deleting: tagString size - prefix size
				at: position
				prefixSize: prefix size ]
]

{ #category : #private }
GtDocumentCompletionStrategy >> classesStartingWith: aString [
	^ (self allClasses first: max startingWith: aString)
		collect: [ :each | 
			self
				complete: each
				with: (each allButFirst: aString size)
				deleting: 0
				at: position
				prefixSize: aString size ]
]

{ #category : #private }
GtDocumentCompletionStrategy >> complete: label with: insertedText deleting: deleteSize at: positionInteger prefixSize: prefixSize [
	| insertionAction deleteAction |
	insertionAction := GtInsertTextCompletionAction
		labeled: label
		completion: insertedText
		position: positionInteger
		from: positionInteger - prefixSize + 1.
	deleteSize = 0
		ifTrue: [ ^ insertionAction ].
	deleteAction := GtDeleteTextCompletionAction labeled: label from: positionInteger + 1 to: positionInteger + deleteSize.
	^ (GtCompositeCompletionAction labeled: label)
		addAction: deleteAction;
		addAction: insertionAction;
		yourself
]

{ #category : #accessing }
GtDocumentCompletionStrategy >> completionActionsFor: aText at: positionInteger max: maxSize [
	(positionInteger < 1 or: [ positionInteger > aText size ])
		ifTrue: [ ^ #() ].
	position := positionInteger.
	max := maxSize.
	text := aText characters.
	(self annotationRegex matchingRangesIn: text)
		do: [ :each | 
			(positionInteger between: each first and: each last)
				ifTrue: [ ^ self annotationActionsIn: (text copyFrom: each first to: each last) asString startAt: each first ] ].
	(self fileRegex matchingRangesIn: text)
		do: [ :each | 
			(positionInteger between: each first and: each last)
				ifTrue: [ ^ self fileReferenceActionsIn: (text copyFrom: each first to: each last) asString ] ].
	(self scriptCompletionsFor: text at: positionInteger) ifNotNil: [ :completions | ^ completions ].
	((text at: positionInteger) = $$ and: [ positionInteger = 1 or: [ (text at: positionInteger - 1) ~= $} ] ])
		ifTrue: [ ^ self allAnnotationActions ].
	^ #()
]

{ #category : #accessing }
GtDocumentCompletionStrategy >> constants [
	^ GtDocumentConstants
]

{ #category : #'private-annotations' }
GtDocumentCompletionStrategy >> defaultParameterValueActionsFor: class startingWith: aString [
	^ self parameterValueActionsForClass: class name: class defaultParameterName startingWith: aString
]

{ #category : #accessing }
GtDocumentCompletionStrategy >> directoryReference [
	^ directory ifNil: [ FileLocator imageDirectory asFileReference ]
]

{ #category : #private }
GtDocumentCompletionStrategy >> exampleClasses [
	^ exampleClasses
		ifNil: [ exampleClasses := GtPrefixTree
				withAll:
					((ProtoObject withAllSubclasses select: [ :each | each selectors anySatisfy: [ :sel | each >> sel hasPragmaNamed: #gtExample ] ])
						collect: [ :each | each name ]) ]
]

{ #category : #private }
GtDocumentCompletionStrategy >> exampleClassesStartingWith: aString [
	^ (self exampleClasses first: max startingWith: aString)
		collect: [ :each | 
			self
				complete: each
				with: (each allButFirst: aString size)
				deleting: 0
				at: position
				prefixSize: aString size ]
]

{ #category : #private }
GtDocumentCompletionStrategy >> exampleMethodsIn: aClass [
	^ GtPrefixTree withAll: ((aClass selectors select: [ :each | aClass >> each hasPragmaNamed: #gtExample ]) collect: [ :each | each ])
]

{ #category : #private }
GtDocumentCompletionStrategy >> exampleMethodsStartingWith: aString [
	^ self methodsStartingWith: aString classes: self exampleClasses methods: [ :class | self exampleMethodsIn: class ]
]

{ #category : #private }
GtDocumentCompletionStrategy >> examplePreviewShowMethodsStartingWith: aString [
	| name |
	name := (aString notEmpty and: [ aString first = $# ])
		ifTrue: [ aString allButFirst ]
		ifFalse: [ aString ].
	^ (self gtViewSelectors first: max startingWith: name)
		collect: [ :each | 
			self
				complete: each
				with: (each allButFirst: name size)
				deleting: 0
				at: position
				prefixSize: name size ]
]

{ #category : #initialization }
GtDocumentCompletionStrategy >> fileReference: aFileReference [
	directory := (aFileReference exists and: [ aFileReference isDirectory ])
		ifTrue: [ aFileReference ]
		ifFalse: [ aFileReference parent ]
]

{ #category : #'private-annotations' }
GtDocumentCompletionStrategy >> fileReferenceActionsIn: aString [
	^ self filenamesStartingWith: (aString allButFirst: 8)
]

{ #category : #private }
GtDocumentCompletionStrategy >> fileRegex [
	^ '\+file\://[^[:cntrl:]+]*\+?' asRegex
]

{ #category : #private }
GtDocumentCompletionStrategy >> filenamesStartingWith: aString [
	^ self filenamesStartingWith: aString in: self directoryReference
]

{ #category : #private }
GtDocumentCompletionStrategy >> filenamesStartingWith: aString in: aFileReference [ 
	| fileReference segments currentDirectory filenamePart names |
	currentDirectory := aFileReference.
	fileReference := aString asFileReference.
	segments := fileReference pathSegments.
	1 to: segments size - 1 do: [ :i | currentDirectory := currentDirectory / (segments at: i) ].
	(segments notEmpty and: [ aString last = FileSystem disk delimiter ])
		ifTrue: [ currentDirectory := currentDirectory / segments last.
			filenamePart := '' ]
		ifFalse: [ filenamePart := segments isEmpty
				ifTrue: [ '' ]
				ifFalse: [ segments last ] ].
	(currentDirectory exists and: [ currentDirectory isDirectory ])
		ifFalse: [ ^ #() ].
	names := GtPrefixTree
		withAll:
			(currentDirectory children
				collect: [ :each | 
					each basename
						,
							(each isDirectory
								ifTrue: [ '/' ]
								ifFalse: [ '' ]) ]).
	^ (names first: max startingWith: filenamePart)
		collect: [ :each | 
			| action |
			action := self
				complete: each
				with: (each allButFirst: filenamePart size)
				deleting: 0
				at: position
				prefixSize: filenamePart size.
			action partial: each last = $/.
			action ]
]

{ #category : #private }
GtDocumentCompletionStrategy >> gtViewSelectors [
	^ gtViewSelectors
		ifNil: [ gtViewSelectors := GtPrefixTree new.
			ProtoObject withAllSubclasses
				do: [ :each | 
					each selectors
						do: [ :sel | 
							(each >> sel hasPragmaNamed: #gtView)
								ifTrue: [ gtViewSelectors add: sel ] ] ].
			gtViewSelectors ]
]

{ #category : #testing }
GtDocumentCompletionStrategy >> hasCompletionEntryFor: aString [
	^ true
]

{ #category : #testing }
GtDocumentCompletionStrategy >> hasCompletionsAt: anInteger in: aText [
	^ true
]

{ #category : #private }
GtDocumentCompletionStrategy >> icebergFilenamesStartingWith: aString [
	| inIcebergRepositories inLocalGtDirectory anExtraCompletionActions |
	inIcebergRepositories := self filenamesStartingWith: aString in: self constants icebergRepositoriesLocation.
	inLocalGtDirectory := self filenamesStartingWith: aString in: self constants localGtDirectory.
	anExtraCompletionActions := inLocalGtDirectory select: [ :eachCompletionAction | 
		(inIcebergRepositories includes: eachCompletionAction) not ].
	inIcebergRepositories addAll: anExtraCompletionActions.
	^ inIcebergRepositories
]

{ #category : #initialization }
GtDocumentCompletionStrategy >> initialize [
	super initialize.
	annotationTags := GtPrefixTree new.
	PRAbstractAnnotation
		allSubclassesDo: [ :class | 
			class isAbstract
				ifFalse: [ annotationTags add: '${' , class tag ] ]
]

{ #category : #private }
GtDocumentCompletionStrategy >> methodsIn: aClass [
	^ GtPrefixTree withAll: aClass selectors
]

{ #category : #private }
GtDocumentCompletionStrategy >> methodsStartingWith: aString [
	^ self methodsStartingWith: aString classes: self allClasses methods: [ :class | self methodsIn: class ]
]

{ #category : #private }
GtDocumentCompletionStrategy >> methodsStartingWith: aString classes: classesTree methods: methodBlock [
	| index spaceIndex class name prefix |
	index := aString indexOfSubCollection: '>>#'.
	index > 0
		ifTrue: [ name := aString copyFrom: 1 to: index - 1.
			spaceIndex := name indexOf: $  ifAbsent: [ name size + 1 ].
			class := Smalltalk at: (name copyFrom: 1 to: spaceIndex - 1) asSymbol ifAbsent: [ ^ #() ].
			(name includes: $ )
				ifTrue: [ class := class class ].
			prefix := aString allButFirst: index + 2.
			^ ((methodBlock value: class) first: max startingWith: prefix)
				collect: [ :each | 
					self
						complete: each
						with: (each allButFirst: prefix size)
						deleting: 0
						at: position
						prefixSize: prefix size ] ].
	^ (classesTree first: max startingWith: aString)
		collect: [ :each | 
			| action |
			action := self
				complete: each
				with: (each allButFirst: aString size) , '>>#'
				deleting: 0
				at: position
				prefixSize: aString size.
			action partial: true.
			action ]
]

{ #category : #private }
GtDocumentCompletionStrategy >> parameterRegex [
	^ '([-a-zA-Z0-9]+=)?([^:|}[:cntrl:]]+)' asRegex
]

{ #category : #'private-annotations' }
GtDocumentCompletionStrategy >> parameterValueActionsForClass: class name: parameterName startingWith: aString [
	| selector |
	selector := (ParameterValueCompletionSelectors at: class ifAbsent: [ Dictionary new ]) at: parameterName asSymbol ifAbsent: [ nil ].
	selector notNil
		ifTrue: [ ^ self perform: selector with: aString ].
	^ #()
]

{ #category : #'private-annotations' }
GtDocumentCompletionStrategy >> parametersStartingWith: aString delete: anInteger includeDefaultValues: aBoolean [
	self annotationClass
		ifNotNil: [ :class | 
			^ ((class gtDocumenterParameters select: [ :each | aString isEmpty or: [ each beginsWith: aString ] ])
				collect: [ :each | 
					self
						complete: each , '='
						with: (each allButFirst: aString size) , '='
						deleting: anInteger
						at: position
						prefixSize: aString size ])
				,
					(aBoolean
						ifTrue: [ self defaultParameterValueActionsFor: class startingWith: aString ]
						ifFalse: [ #() ]) ].
	^ #()
]

{ #category : #private }
GtDocumentCompletionStrategy >> scriptCompletionsFor: source at: anIndex [
	| startIndex endIndex actions |
	(self scriptStartRegex matchingRangesIn: source)
		do: [ :each | 
			each last < anIndex
				ifTrue: [ startIndex := each last + 1 ] ].
	startIndex ifNil: [ ^ nil ].
	(self scriptEndRegex matchingRangesIn: source)
		reverseDo: [ :each | 
			each first > anIndex
				ifTrue: [ endIndex := each first - 1 ] ].
	endIndex ifNil: [ ^ nil ].
	actions := GtPharoCompletionStrategy newForSnippet
		completionActionsFor: (source copyFrom: startIndex to: endIndex) asRopedText
		at: anIndex - startIndex + 1
		max: max.
	actions do: [ :each | each translateBy: startIndex - 1].
	^ actions
]

{ #category : #private }
GtDocumentCompletionStrategy >> scriptEndRegex [
	^ '(|r|\n)\]\]\] *(\r|\n)?' asRegex
]

{ #category : #private }
GtDocumentCompletionStrategy >> scriptStartRegex [
	^ '\[\[\[(([^[:space:]]+[ 	]*)*[ 	]*(\r\n?|\n))' asRegex
]
