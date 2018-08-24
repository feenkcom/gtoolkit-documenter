Class {
	#name : #GtOldCodeSnippetFinder,
	#superclass : #Object,
	#instVars : [
		'tokens',
		'scriptIndex',
		'document'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #accessing }
GtOldCodeSnippetFinder >> document [
	^ document
]

{ #category : #accessing }
GtOldCodeSnippetFinder >> document: anObject [
	document := anObject
]

{ #category : #actions }
GtOldCodeSnippetFinder >> find [
	"If there is less scripts, create new one."

	<return: #GtOldCodeSnippetResult>
	self scriptIndex > self numberOfCodeSnippets
		ifTrue: [ ^ self newOrExistingCodeSnippet ].
	self hasSimilarSourceCodeAtSameIndex
		ifTrue: [ ^ self scriptAtSameIndex ].
	self hasSimilarSourceCodeAtFollowingIndex
		ifTrue: [ 
			self removeScriptAtSameIndex. 
			^ self scriptAtSameIndex ]. 
	^ self newCodeSnippetAtSameIndex
]

{ #category : #'gt-inspector-extension' }
GtOldCodeSnippetFinder >> gtInspectorOutsIn: composite [
	<gtInspectorPresentationOrder: -4>
	^ self document ifNotNil: [ :aDocument | 
		aDocument outs gtInspectorCodeSnippetsIn: composite ]
]

{ #category : #'gt-inspector-extension' }
GtOldCodeSnippetFinder >> gtInspectorSourceCodeIn: composite [
	<gtInspectorPresentationOrder: -4>
	^ composite text
		title: [ 'Source code' ];
		display: [ self sourceCode ];
		when: [ self tokens notNil ]
]

{ #category : #testing }
GtOldCodeSnippetFinder >> hasSimilarSourceCodeAtFollowingIndex [
	^ self numberOfCodeSnippets > self scriptIndex and: [ 
		(self scriptAtFollowingIndex sourceCode = self sourceCode) or: [ 
			self sourceCode endsWith: self scriptAtFollowingIndex sourceCode ] ]
]

{ #category : #testing }
GtOldCodeSnippetFinder >> hasSimilarSourceCodeAtSameIndex [
	^ (self scriptAtSameIndex sourceCode = self sourceCode) or: [ 
		self sourceCode endsWith: self scriptAtSameIndex sourceCode ]
]

{ #category : #'instance creation' }
GtOldCodeSnippetFinder >> newCodeSnippetAtSameIndex [
	| type newScript |
	type := GtOldPillarCodeSnippetDetector typeForScriptTokens: self tokens.
	newScript := type codeSnippetClass new.
	newScript index: self scriptIndex.
	newScript sourceCode: self sourceCode.
	newScript document: self document.
	newScript initializeFromTokens: self tokens.
	^ newScript
]

{ #category : #'instance creation' }
GtOldCodeSnippetFinder >> newOrExistingCodeSnippet [
	<return: #GtOldCodeSnippetResult>
	self assert: [ self scriptIndex <= (self numberOfCodeSnippets + 1) ] description: [ 'A code snippet was skipped' ].
	(self numberOfCodeSnippets + 1) = self scriptIndex ifTrue: [
		self newCodeSnippetAtSameIndex ].
	^ self outs codeSnippetAt: self scriptIndex
]

{ #category : #'accessing - computed' }
GtOldCodeSnippetFinder >> numberOfCodeSnippets [
	^ self outs size
]

{ #category : #'accessing - computed' }
GtOldCodeSnippetFinder >> outs [
	<return: #GtOldCodeSnippets>
	^ self document outs
]

{ #category : #private }
GtOldCodeSnippetFinder >> removeScriptAtSameIndex [
	self outs remove: self scriptAtSameIndex
]

{ #category : #'accessing - computed' }
GtOldCodeSnippetFinder >> scriptAtFollowingIndex [
	<return: #GtOldCodeSnippetResult>
	^ self outs codeSnippetAt: self scriptIndex + 1
]

{ #category : #'accessing - computed' }
GtOldCodeSnippetFinder >> scriptAtSameIndex [
	<return: #GtOldCodeSnippetResult>
	^ self outs codeSnippetAt: self scriptIndex
]

{ #category : #accessing }
GtOldCodeSnippetFinder >> scriptIndex [
	^ scriptIndex
]

{ #category : #accessing }
GtOldCodeSnippetFinder >> scriptIndex: anObject [
	scriptIndex := anObject
]

{ #category : #'accessing - computed' }
GtOldCodeSnippetFinder >> sourceCode [
	<return: #String>
	^ self tokens scriptBodyString
]

{ #category : #accessing }
GtOldCodeSnippetFinder >> tokens [
	^ tokens
]

{ #category : #accessing }
GtOldCodeSnippetFinder >> tokens: anObject [
	tokens := anObject
]
