"
GtDocumenterParserCheck scans pillar source text and checks for text that may trigger problems with the parser.  

- Not all issues will be found.
- Some issues that are flagged will not always trigger problems.


Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : 'GtDocumenterParserCheck',
	#superclass : 'Object',
	#instVars : [
		'pillarSource',
		'messages'
	],
	#category : 'GToolkit-Documenter-Styler'
}

{ #category : 'steps - subchecks' }
GtDocumenterParserCheck >> check: aString [
	"Check the supplied string for problematic text.
	Signal GtParserCheckFailure if problems are found."

	aString ifNil: [ ^self ].
	self reset.
	pillarSource := aString.
	self checkSource.
	messages isEmpty ifFalse: 
		[ GtParserCheckFailure signalSource: pillarSource messages: messages ].
]

{ #category : 'private - checks' }
GtDocumenterParserCheck >> checkSource [
	"Check the supplied pillar source"

	self checkUnbalancedPlus.
]

{ #category : 'private - checks' }
GtDocumenterParserCheck >> checkUnbalancedPlus [
	"Check for an odd number of plus signs (which are used to link to images).
	Ignore escaped plus signs (\+)"

	| indexes |

	indexes := OrderedCollection new.
	1 to: pillarSource size do: [ :i |
		(pillarSource at: i) = $+ ifTrue: [ 
			i = 1 ifTrue: 
				[ indexes add: i ]
			ifFalse:
				[ (pillarSource at: i-1) = $\ ifFalse: 
					[ indexes add: i ] ] ] ].
	indexes size odd ifTrue: 
		[ messages add: 'Unbalanced plus signs at ', indexes asString ].
]

{ #category : 'accessing' }
GtDocumenterParserCheck >> messages [
	^ messages
]

{ #category : 'accessing' }
GtDocumenterParserCheck >> pillarSource [
	^ pillarSource
]

{ #category : 'accessing' }
GtDocumenterParserCheck >> pillarSource: anObject [
	pillarSource := anObject
]

{ #category : 'initialization' }
GtDocumenterParserCheck >> reset [ 
	"Reset the state to check another string"

	messages := OrderedCollection new.
]
