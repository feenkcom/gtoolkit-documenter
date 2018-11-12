Class {
	#name : #Gt2DocumentCompletionStrategy,
	#superclass : #GtCompletionStrategy,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#instVars : [
		'directory',
		'annotationTags',
		'max',
		'position',
		'string',
		'tagName',
		'exampleClasses',
		'allClasses'
	],
	#classVars : [
		'ParameterValueCompletionSelectors'
	],
	#category : #'GToolkit-NewDocumenter-Completer'
}

{ #category : #'class initialization' }
Gt2DocumentCompletionStrategy class >> initialize [
	ParameterValueCompletionSelectors := Dictionary new.
	ParameterValueCompletionSelectors
		at: Gt2ChangesAnnotation
			put:
			(Dictionary new
				at: self constants pathParameterName put: #filenamesStartingWith:;
				yourself);
		at: Gt2ClassAnnotation
			put:
			(Dictionary new
				at: self constants nameParameterName put: #classesStartingWith:;
				yourself);
		at: Gt2ExampleAnnotation
			put:
			(Dictionary new
				at: self constants nameParameterName put: #exampleMethodsStartingWith:;
				yourself);
		at: Gt2MethodAnnotation
			put:
			(Dictionary new
				at: self constants nameParameterName put: #methodsStartingWith:;
				yourself);
		at: Gt2IcebergFileAnnotation
			put:
			(Dictionary new
				at: self constants pathParameterName put: #filenamesStartingWith:;
				yourself);
		at: PRInputFileAnnotation
			put:
			(Dictionary new
				at: self constants pathParameterName put: #filenamesStartingWith:;
				yourself)
		
]

{ #category : #private }
Gt2DocumentCompletionStrategy >> allAnnotationActions [
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
Gt2DocumentCompletionStrategy >> allClasses [
	^ allClasses ifNil: [ allClasses := GtPrefixTree withAll: (ProtoObject withAllSubclasses collect: [ :each | each name ]) ]
]

{ #category : #'private-annotations' }
Gt2DocumentCompletionStrategy >> annotationActionsIn: aString startAt: annotationStart [
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
Gt2DocumentCompletionStrategy >> annotationClass [
	^ PRAbstractAnnotation withAllSubclasses
		detect: [ :each | each tag = tagName ]
		ifNone: [ nil ]
]

{ #category : #'private-annotations' }
Gt2DocumentCompletionStrategy >> annotationParameterActionsFor: parameterString startAt: parameterStart [
	self parameterRegex
		matchesIn: parameterString
		subexpressionsDo: [ :str :parts | 
			| name value nameWithoutEquals hasEquals |
			name := parts first.
			value := parts last.
			name isNil
				ifTrue: [ name := value.
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
Gt2DocumentCompletionStrategy >> annotationParametersActionsFor: parametersString startAt: parametersStart [
	| char |
	(self parameterRegex matchingRangesIn: parametersString)
		do: [ :each | 
			(position between: each first + parametersStart and: each last + parametersStart)
				ifTrue: [ ^ self annotationParameterActionsFor: (parametersString copyFrom: each first to: each last) startAt: parametersStart + each first ] ].
	char := string at: position.
	(':|' includes: char)
		ifTrue: [ ^ self parametersStartingWith: '' delete: 0 includeDefaultValues: true ].
	^ #()
]

{ #category : #private }
Gt2DocumentCompletionStrategy >> annotationRegex [
	^ '(\$\{([^$:| \s}]*))(([:|](([-a-zA-Z0-9]+=)?[^|}[:cntrl:]]+)*)*)(}?\$?)' asRegex
]

{ #category : #'private-annotations' }
Gt2DocumentCompletionStrategy >> annotationTagActionsFor: tagString startAt: annotationStart [
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
Gt2DocumentCompletionStrategy >> classesStartingWith: aString [
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
Gt2DocumentCompletionStrategy >> complete: label with: insertedText deleting: deleteSize at: positionInteger prefixSize: prefixSize [
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
Gt2DocumentCompletionStrategy >> completionActionsFor: aText at: positionInteger max: maxSize [
	(positionInteger < 1 or: [ positionInteger > aText size ])
		ifTrue: [ ^ #() ].
	position := positionInteger.
	max := maxSize.
	string := aText asString.
	(self annotationRegex matchingRangesIn: string)
		do: [ :each | 
			(positionInteger between: each first and: each last)
				ifTrue: [ ^ self annotationActionsIn: (string copyFrom: each first to: each last) startAt: each first ] ].
	(self fileRegex matchingRangesIn: string)
		do: [ :each | 
			(positionInteger between: each first and: each last)
				ifTrue: [ ^ self fileReferenceActionsIn: (string copyFrom: each first to: each last) ] ].
	(self scriptCompletionsFor: string at: positionInteger) ifNotNil: [ :completions | ^ completions ].
	((string at: positionInteger) = $$ and: [ positionInteger = 1 or: [ (string at: positionInteger - 1) ~= $} ] ])
		ifTrue: [ ^ self allAnnotationActions ].
	^ #()
]

{ #category : #'private-annotations' }
Gt2DocumentCompletionStrategy >> defaultParameterValueActionsFor: class startingWith: aString [
	^ self parameterValueActionsForClass: class name: class defaultParameterName startingWith: aString
]

{ #category : #accessing }
Gt2DocumentCompletionStrategy >> directoryReference [
	^ directory ifNil: [ FileSystem workingDirectory ]
]

{ #category : #private }
Gt2DocumentCompletionStrategy >> exampleClasses [
	^ exampleClasses
		ifNil: [ exampleClasses := GtPrefixTree
				withAll:
					((ProtoObject withAllSubclasses select: [ :each | each selectors anySatisfy: [ :sel | each >> sel hasPragmaNamed: #gtExample ] ])
						collect: [ :each | each name ]) ]
]

{ #category : #private }
Gt2DocumentCompletionStrategy >> exampleClassesStartingWith: aString [
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
Gt2DocumentCompletionStrategy >> exampleMethodsIn: aClass [
	^ GtPrefixTree withAll: ((aClass selectors select: [ :each | aClass >> each hasPragmaNamed: #gtExample ]) collect: [ :each | each ])
]

{ #category : #private }
Gt2DocumentCompletionStrategy >> exampleMethodsStartingWith: aString [
	^ self methodsStartingWith: aString classes: self exampleClasses methods: [ :class | self exampleMethodsIn: class ]
]

{ #category : #initialization }
Gt2DocumentCompletionStrategy >> fileReference: aFileReference [
	directory := (aFileReference exists and: [ aFileReference isDirectory ])
		ifTrue: [ aFileReference ]
		ifFalse: [ aFileReference parent ]
]

{ #category : #'private-annotations' }
Gt2DocumentCompletionStrategy >> fileReferenceActionsIn: aString [
	^ self filenamesStartingWith: (aString allButFirst: 8)
]

{ #category : #private }
Gt2DocumentCompletionStrategy >> fileRegex [
	^ '\+file\://[^[:cntrl:]+]*\+?' asRegex
]

{ #category : #private }
Gt2DocumentCompletionStrategy >> filenamesStartingWith: aString [
	| fileReference segments currentDirectory filenamePart names |
	currentDirectory := self directoryReference.
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

{ #category : #testing }
Gt2DocumentCompletionStrategy >> hasCompletionEntryFor: aString [
	^ true
]

{ #category : #testing }
Gt2DocumentCompletionStrategy >> hasCompletionsAt: anInteger in: aText [
	^ true
]

{ #category : #initialization }
Gt2DocumentCompletionStrategy >> initialize [
	super initialize.
	annotationTags := GtPrefixTree new.
	PRAbstractAnnotation
		allSubclassesDo: [ :class | 
			class isAbstract
				ifFalse: [ annotationTags add: '${' , class tag ] ]
]

{ #category : #private }
Gt2DocumentCompletionStrategy >> methodsIn: aClass [
	^ GtPrefixTree withAll: aClass selectors
]

{ #category : #private }
Gt2DocumentCompletionStrategy >> methodsStartingWith: aString [
	^ self methodsStartingWith: aString classes: self allClasses methods: [ :class | self methodsIn: class ]
]

{ #category : #private }
Gt2DocumentCompletionStrategy >> methodsStartingWith: aString classes: classesTree methods: methodBlock [
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
Gt2DocumentCompletionStrategy >> parameterRegex [
	^ '([-a-zA-Z0-9]+=)?([^:|}[:cntrl:]]+)' asRegex
]

{ #category : #'private-annotations' }
Gt2DocumentCompletionStrategy >> parameterValueActionsForClass: class name: parameterName startingWith: aString [
	| selector |
	selector := (ParameterValueCompletionSelectors at: class ifAbsent: [ Dictionary new ]) at: parameterName asSymbol ifAbsent: [ nil ].
	selector notNil
		ifTrue: [ ^ self perform: selector with: aString ].
	^ #()
]

{ #category : #'private-annotations' }
Gt2DocumentCompletionStrategy >> parametersStartingWith: aString delete: anInteger includeDefaultValues: aBoolean [
	self annotationClass
		ifNotNil: [ :class | 
			^ ((class possibleParameters select: [ :each | aString isEmpty or: [ each beginsWith: aString ] ])
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
Gt2DocumentCompletionStrategy >> scriptCompletionsFor: source at: anIndex [
	| startIndex endIndex actions |
	(self scriptStartRegex matchingRangesIn: source)
		do: [ :each | 
			each last < anIndex
				ifTrue: [ startIndex := each last + 1 ] ].
	startIndex isNil
		ifTrue: [ ^ nil ].
	(self scriptEndRegex matchingRangesIn: source)
		reverseDo: [ :each | 
			each first > anIndex
				ifTrue: [ endIndex := each first - 1 ] ].
	endIndex isNil
		ifTrue: [ ^ nil ].
	actions := GtPharoCompletionStrategy newForSnippet
		completionActionsFor: (source copyFrom: startIndex to: endIndex) asRopedText
		at: anIndex - startIndex + 1
		max: max.
	actions do: [ :each | each translateBy: startIndex - 1].
	^ actions
]

{ #category : #private }
Gt2DocumentCompletionStrategy >> scriptEndRegex [
	^ '^\]\]\] *$' asRegex
]

{ #category : #private }
Gt2DocumentCompletionStrategy >> scriptStartRegex [
	^ '\[\[\[(([^[:space:]]+[ 	]*)*[ 	]*(\r\n?|\n))' asRegex
]
