"
I am a parser for a Pillar syntax. 
I use the PRPillarParser and I build a PRDocument that can include GT-Example scripts.
GT-Example scripts are scripts that includes 'example' parameter and has no body, e.g., 

[[[example=GtPillarExampleScript class>> #basicExample|height=400|expanded=true|show=gtPrintIn:]]]
"
Class {
	#name : #GtOldPillarExampleParser,
	#superclass : #PRPillarParserOld,
	#traits : 'GtAssertingTrait',
	#classTraits : 'GtAssertingTrait classTrait',
	#instVars : [
		'sourceFile'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #accessing }
GtOldPillarExampleParser class >> ignoredNames [
	^ super ignoredNames, #(sourceFile)
]

{ #category : #initialization }
GtOldPillarExampleParser class >> initialize [
	self markups
		at: GtOldPillarExampleCodeblock put: '[[['.
	self endMarkups
		at: GtOldPillarExampleCodeblock put: ']]]'.
]

{ #category : #accessing }
GtOldPillarExampleParser >> parameterValueUntilNewline [
	"allow extra end markup"
	^ (self parameterValueUntilParser: newline / (EndMarkups at: PRCodeblock) asParser)
		==> [ :array | self stringFrom: array ]
]

{ #category : #accessing }
GtOldPillarExampleParser >> script [
	| endParser startParser |
	endParser := ((EndMarkups at: PRCodeblock) asParser token, space star , lineEnd) 
		==> [ :t | t first ].
	startParser := (Markups at: PRCodeblock) asParser token, scriptParameters , endParser negate star token, endParser.
	^ startParser ==> [ :tokens | | scriptTokens scriptType |
		scriptTokens := GtOldPillarScriptTokens new.
		scriptTokens sourceFileReference: self sourceFile.
		scriptTokens tokens: tokens.
		scriptType := GtOldPillarCodeSnippetDetector typeForScriptTokens: scriptTokens.
		scriptType parserHandlerClass tokens: scriptTokens ].
]

{ #category : #accessing }
GtOldPillarExampleParser >> scriptParameters [
	^ parametersUntilNewline , newline optional ==> [ :array | array first ]
		==> [ :array | self parametersFrom: array ]
]

{ #category : #accessing }
GtOldPillarExampleParser >> sourceFile [
	self 
		assert: [ sourceFile notNil ] 
		description: [ 'Source file should be initialized first' ].
	^ sourceFile
]

{ #category : #accessing }
GtOldPillarExampleParser >> sourceFile: aFileReference [
	self 
		assert: [ aFileReference notNil ] 
		description: [ 'Source file should be initialized' ].
	self 
		assert: [ aFileReference exists ] 
		description: [ 'Source file should exist' ].
	
	sourceFile := aFileReference
]
