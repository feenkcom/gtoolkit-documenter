"
A GtPillarExampleParserTest is a test class for testing the behavior of GtPillarExampleParser
"
Class {
	#name : #GtPillarExampleParserTest,
	#superclass : #PRPillarParserOldTest,
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #testing }
GtPillarExampleParserTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #accessing }
GtPillarExampleParserTest >> parserClass [
	^ GtOldPillarExampleParser
]

{ #category : #tests }
GtPillarExampleParserTest >> testScriptExample [
	| parameters |
	self
		parse:
			'[[[example=GtConnectorExamples>>#oneExampleMethod|height=400|expanded=true|noCode=true|show=gtLiveIn:]]]'
		rule: #script.
	parameters := SmallDictionary new
		at: 'example' put: 'GtConnectorExamples>>#oneExampleMethod';
		at: 'height' put: '400';
		at: 'expanded' put: 'true'; 
		at: 'noCode' put: 'true'; 
		at: 'show' put: 'gtLiveIn:';
		yourself.
	self 
		assert: result 
		equals: (GtOldPillarExampleCodeblock content: '' parameters: parameters)
]

{ #category : #tests }
GtPillarExampleParserTest >> testScriptExampleWithNewLine [
	self
		parse:
			'[[[example=GtConnectorExamples>>#oneExampleMethod|height=400|expanded=true|noCode=true|show=gtLiveIn:]]]
'
		rule: #script
]
