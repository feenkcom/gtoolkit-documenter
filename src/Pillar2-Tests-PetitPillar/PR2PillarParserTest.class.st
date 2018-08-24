Class {
	#name : #PR2PillarParserTest,
	#superclass : #PR2PillarGrammarTest,
	#category : 'Pillar2-Tests-PetitPillar'
}

{ #category : #asserting }
PR2PillarParserTest >> assertStart: aStartInteger stop: aStopIndex [
	self assert: result notNil.
	self
		assert: result start
		equals: aStartInteger.
	self
		assert: result stop
		equals: aStopIndex.
	
]

{ #category : #asserting }
PR2PillarParserTest >> assertStart: aStartInteger stop: aStopIndex ofNode: aDocumentItem [
	self
		assert: aDocumentItem start
		equals: aStartInteger.
	self
		assert: aDocumentItem stop
		equals: aStopIndex.
	
]

{ #category : #accessing }
PR2PillarParserTest >> parserClass [
	^ PR2PillarParser
]

{ #category : #'tests - Reference' }
PR2PillarParserTest >> testAliasFigure [
	super testAliasFigure.
	self assert: result equals: { PRText content: 'Alias' } asOrderedCollection.
	self assertStart: 1 stop: 5 ofNode: result first.
]

{ #category : #'tests - Reference' }
PR2PillarParserTest >> testAliasFigureEscape [
	super testAliasFigureEscape.
	self assert: result equals: { PRText content: 'Alias>' } asOrderedCollection.
	self assertStart: 1 stop: 7 ofNode: result first.
]

{ #category : #'tests - Reference' }
PR2PillarParserTest >> testAliasLink [
	super testAliasLink.
	self assert: result equals: { PRText content: 'Alias' } asOrderedCollection.
	self assertStart: 1 stop: 5 ofNode: result first.
]

{ #category : #'tests - Reference' }
PR2PillarParserTest >> testAliasLinkEscape [
	super testAliasLinkEscape.
	self assert: result equals: { PRText content: 'Alias>' } asOrderedCollection.
	self assertStart: 1 stop: 7 ofNode: result first.
]

{ #category : #'tests - Anchor' }
PR2PillarParserTest >> testAnchor [
	super testAnchor.
	self assert: result equals: (PRAnchor named: 'test')
]

{ #category : #'tests - Anchor' }
PR2PillarParserTest >> testAnchorAreTrimed [
	super testAnchorAreTrimed.
	self assert: result equals: (PRAnchor named: 'test')
]

{ #category : #'tests - Anchor' }
PR2PillarParserTest >> testAnchorWithNewLine [
	super testAnchorWithNewLine.
	self assert: result equals: (PRAnchor named: 'foo')
]

{ #category : #'tests - Anchor' }
PR2PillarParserTest >> testAnchorWithSpaceInside [
	super testAnchorWithSpaceInside.
	self assert: result equals: (PRAnchor named: 'foo bar')
]

{ #category : #'tests - Paragraph' }
PR2PillarParserTest >> testAnnotatedParagraph [
	super testAnnotatedParagraph.
	self 
		assert: result 
		equals: (PRAnnotatedParagraph withAll: {PRText content: 'Bar'} annotation: 'foo').
	self assertStart: 1 stop: 9.
	self assertStart: 7 stop: 9 ofNode: result children first.
]

{ #category : #'tests - Paragraph' }
PR2PillarParserTest >> testAnnotatedParagraphEmpty [
	super testAnnotatedParagraphEmpty.
	self
		assert: result
		equals:
			(PRAnnotatedParagraph new
				annotation: 'foo';
				yourself).
	self assertStart: 1 stop: 5.
]

{ #category : #'tests - Paragraph' }
PR2PillarParserTest >> testAnnotatedParagraphEmptyWithNewLine [
	super testAnnotatedParagraphEmptyWithNewLine.
	self
		assert: result
		equals:
			(PRAnnotatedParagraph new
				annotation: 'foo';
				yourself).
	self assertStart: 1 stop: 5.
]

{ #category : #'tests - Annotation' }
PR2PillarParserTest >> testAnnotation [
	super testAnnotation.
	self
		assert: result
		equals: (PRInputFileAnnotation withParametersInCollection: 
						((OrderedDictionary new
						at: 'path' put: 'Foo';
						yourself))).
	self assertStart: 1 stop: 22.
]

{ #category : #'tests - Annotation' }
PR2PillarParserTest >> testAnnotationAreTrimedAtTheRight [
	super testAnnotationAreTrimedAtTheRight.
	self
		assert: result
		equals:
			(PRInputFileAnnotation
				withParametersInCollection:
					(OrderedDictionary new
						at: 'path' put: 'Foo';
						yourself)).
	self assertStart: 1 stop: 22.
]

{ #category : #'tests - Annotation' }
PR2PillarParserTest >> testAnnotationParameter [
	super testAnnotationParameter.
	self assert: result equals: #('value' 'foo')
]

{ #category : #'tests - Annotation' }
PR2PillarParserTest >> testAnnotationParameters [
	| expected |
	super testAnnotationParameters.
	expected := OrderedDictionary new.
	expected at: 'foo' put: 'bar'.
	expected at: 'timo' put: 'leon'.
	self assert: result equals:  expected
]

{ #category : #'tests - Annotation' }
PR2PillarParserTest >> testAnnotationParameters2 [
	| expected |
	super testAnnotationParameters.
	expected := OrderedDictionary new.
	expected at: 'foo' put: 'bar'.
	expected at: 'timo' put: 'leon'.
	self assert: result equals:  expected
]

{ #category : #'tests - Annotation' }
PR2PillarParserTest >> testAnnotationTag [
	super testAnnotationTag.
	self assert: result equals: PRMockAnnotation
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testBoldFormat [
	super testBoldFormat.
	self assert: result equals: (PRBoldFormat with: (PRText content: 'Foo')).
	self assertStart: 1 stop: 7.
	self assertStart: 3 stop: 5 ofNode: result children first.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testBoldFormatEmpty [
	super testBoldFormatEmpty.
	self assert: result equals: PRBoldFormat new.
	self assertStart: 1 stop: 4.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testBoldFormatWithEscaped [
	super testBoldFormatWithEscaped.
	self assert: result equals: (PRBoldFormat with: (PRText content: '""')).
	self assertStart: 1 stop: 8.
	self assertStart: 3 stop: 6 ofNode: result children first.
]

{ #category : #'tests - Text' }
PR2PillarParserTest >> testCommentedLine [
	super testCommentedLine.
	self assert: result equals: (PRCommentedLine content: 'some text')
]

{ #category : #'tests - Text' }
PR2PillarParserTest >> testCommentedLineWithNewline [
	super testCommentedLineWithNewline.
	self assert: result equals: (PRCommentedLine content: 'some text')
]

{ #category : #'tests - List' }
PR2PillarParserTest >> testDefinitionList [
	super testDefinitionList.
	self
		assert: result
		equals:
			(PRDefinitionList
				withAll:
					{(PRTermItem with: (PRText content: 'Foo')).
					(PRDataItem with: (PRText content: 'Bar'))}).
	self assertStart: 1 stop: 9.
	self assertStart: 1 stop: 5 ofNode: result children first.
	self assertStart: 2 stop: 4 ofNode: result children first children first.
	self assertStart: 6 stop: 9 ofNode: result children second.
	self assertStart: 7 stop: 9 ofNode: result children second children first.
	
]

{ #category : #'tests - Paragraph' }
PR2PillarParserTest >> testEmptyParagraph [
	super testEmptyParagraph.
	self assert: result equals: PREmptyParagraph new
]

{ #category : #'tests - Reference' }
PR2PillarParserTest >> testFigureFollowedByLinkWithAlias [
	| paragraph |
	super testFigureFollowedByLinkWithAlias.
	paragraph := PRParagraph withAll: { 
		PRFigure reference: 'file://TeapotWelcome.png'.
		(PRExternalLink reference: 'http://localhost')
			add: (PRText content: 'Go');
			yourself
	 }.
	self assert: result equals: paragraph
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testFormatWithLink [
	super testFormatWithLink.
	self assert: result equals: (PRBoldFormat with: (PRInternalLink reference: 'foo')).
	self assertStart: 1 stop: 9.
	self assertStart: 3 stop: 7 ofNode: result children first.
]

{ #category : #'tests - Header' }
PR2PillarParserTest >> testHeaderEmpty [
	super testHeaderEmpty.
	self assert: result equals: (PRHeader withAll: Array new level: 1).
	self assertStart: 1 stop: 1.
]

{ #category : #'tests - Header' }
PR2PillarParserTest >> testHeaderLevel1 [
	super testHeaderLevel1.
	self assert: result equals: (PRHeader withAll: {PRText content: 'Foo'} level: 1).
	self assertStart: 1 stop: 4.
	self assertStart: 2 stop: 4 ofNode: result children first.
]

{ #category : #'tests - Header' }
PR2PillarParserTest >> testHeaderLevel2 [
	super testHeaderLevel2.
	self assert: result equals: (PRHeader withAll: {PRText content: 'Foo'} level: 2).
	self assertStart: 1 stop: 5.
	self assertStart: 3 stop: 5 ofNode: result children first.
]

{ #category : #'tests - Header' }
PR2PillarParserTest >> testHeaderLevel3 [
	super testHeaderLevel3.
	self assert: result equals: (PRHeader withAll: {PRText content: 'Foo'} level: 3).
	self assertStart: 1 stop: 6.
	self assertStart: 4 stop: 6 ofNode: result children first.
]

{ #category : #'tests - Header' }
PR2PillarParserTest >> testHeaderLevel4 [
	super testHeaderLevel4.
	self assert: result equals: (PRHeader withAll: {PRText content: 'Foo'} level: 4).
	self assertStart: 1 stop: 7.
	self assertStart: 5 stop: 7 ofNode: result children first.
]

{ #category : #'tests - Header' }
PR2PillarParserTest >> testHeaderLevel5 [
	super testHeaderLevel5.
	self assert: result equals: (PRHeader withAll: {PRText content: 'Foo'} level: 5).
	self assertStart: 1 stop: 8.
	self assertStart: 6 stop: 8 ofNode: result children first.
]

{ #category : #'tests - Header' }
PR2PillarParserTest >> testHeaderLevel6 [
	super testHeaderLevel6.
	self assert: result equals: (PRHeader withAll: {PRText content: 'Foo'} level: 6).
	self assertStart: 1 stop: 9.
	self assertStart: 7 stop: 9 ofNode: result children first.
]

{ #category : #'tests - Header' }
PR2PillarParserTest >> testHeaderWithFormat [
	super testHeaderWithFormat.
	self 
		assert: result 
		equals: (PRHeader withAll: {PRBoldFormat with: (PRText content: 'Foo')} level: 1).
	self assertStart: 1 stop: 8.
	self assertStart: 2 stop: 8 ofNode: result children first.
	self assertStart: 4 stop: 6 ofNode: result children first children first.
]

{ #category : #'tests - Header' }
PR2PillarParserTest >> testHeaderWithFormatAndText [
	super testHeaderWithFormatAndText.
	self
		assert: result
		equals:
			(PRHeader
				withAll:
					{PRBoldFormat with: (PRText content: 'Foo').
					PRText content: ' bar'}
				level: 1).
	self assertStart: 1 stop: 12.
	self assertStart: 2 stop: 8 ofNode: result children first.
	self assertStart: 4 stop: 6 ofNode: result children first children first.
	self assertStart: 9 stop: 12 ofNode: result children second.

]

{ #category : #'tests - Header' }
PR2PillarParserTest >> testHeaderWithNewLine [
	super testHeaderWithNewLine.
	self assert: result equals: (PRHeader withAll: {PRText content: 'Foo'} level: 1).
	self assertStart: 1 stop: 4.
	self assertStart: 2 stop: 4 ofNode: result children first.
]

{ #category : #'tests - HorizontalRule' }
PR2PillarParserTest >> testHorizontalRule [
	super testHorizontalRule.
	self assert: result equals: PRHorizontalRule new
]

{ #category : #'tests - HorizontalRule' }
PR2PillarParserTest >> testHorizontalRuleFollowByNewLine [
	super testHorizontalRuleFollowByNewLine.
	self assert: result equals: PRHorizontalRule new
]

{ #category : #'tests - HorizontalRule' }
PR2PillarParserTest >> testHorizontalRuleTrimRight [
	super testHorizontalRuleTrimRight.
	self assert: result equals: PRHorizontalRule new
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testItalicFormat [
	super testItalicFormat.
	self assert: result equals: (PRItalicFormat with: (PRText content: 'Foo')).
	self assertStart: 1 stop: 7.
	self assertStart: 3 stop: 5 ofNode: result children first.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testItalicFormatEmpty [
	super testItalicFormatEmpty.
	self assert: result equals: PRItalicFormat new.
	self assertStart: 1 stop: 4.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testItalicFormatWithEscaped [
	super testItalicFormatWithEscaped.
	self assert: result equals: (PRItalicFormat with: (PRText content: '''''')).
	self assertStart: 1 stop: 8.
	self assertStart: 3 stop: 6 ofNode: result children first.
]

{ #category : #'tests - Reference' }
PR2PillarParserTest >> testLinkFollowedByFigureWithAlias [
	| paragraph |
	super testLinkFollowedByFigureWithAlias.
	paragraph := PRParagraph withAll: { 
		PRExternalLink reference: 'http://localhost'.
		(PRFigure reference: 'file://TeapotWelcome.png')
			add: (PRText content: 'Go');
			yourself
	 }.
	self assert: result equals: paragraph
]

{ #category : #'tests - List' }
PR2PillarParserTest >> testListMulti [
	super testListMulti.
	self
		assert: result
		equals:
			(PRUnorderedList
				withAll:
					{(PRListItem
						withAll:
							{(PRText content: '1').
							(PRUnorderedList
								withAll:
									{(PRListItem
										withAll:
											{(PRText content: '2').
											(PRUnorderedList with: (PRListItem with: (PRText content: '3')))}).
									(PRListItem with: (PRText content: '4')).
									(PRListItem with: (PRText content: '5')).
									(PRListItem with: (PRText content: '6'))})}).
					(PRListItem
						withAll:
							{(PRText content: '7').
							(PROrderedList with: (PRListItem with: (PROrderedList with: (PRListItem with: (PRText content: '8')))))})})
]

{ #category : #'tests - List' }
PR2PillarParserTest >> testListWithComment [
	super testListWithComment.
	self
		assert: result
		equals:
			(PROrderedList
				withAll:
					{PRListItem
						withAll:
							{PRText content: 'Foo'.
							PRCommentedLine content: 'Comment'}.
					PRListItem with: (PRText content: 'Bar')})
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testMonospaceFormat [
	super testMonospaceFormat.
	self assert: result equals: (PRMonospaceFormat with: (PRText content: 'Foo')).
	self assertStart: 1 stop: 7.
	self assertStart: 3 stop: 5 ofNode: result children first.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testMonospaceFormatEmpty [
	super testMonospaceFormatEmpty.
	self assert: result equals: PRMonospaceFormat new.
	self assertStart: 1 stop: 4.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testMonospaceFormatWithEscaped [
	super testMonospaceFormatWithEscaped.
	self assert: result equals: (PRMonospaceFormat with: (PRText content: '==')).
	self assertStart: 1 stop: 8.
	self assertStart: 3 stop: 6 ofNode: result children first.
]

{ #category : #'tests - List' }
PR2PillarParserTest >> testOrderedList [
	super testOrderedList.
	self assert: result equals: (PROrderedList with: (PRListItem with: (PRText content: 'Foo'))).
	self assertStart: 1 stop: 4.
	self assertStart: 1 stop: 4 ofNode: result children first.
	self assertStart: 2 stop: 4 ofNode: result children first children first.
]

{ #category : #'tests - List' }
PR2PillarParserTest >> testOrderedListEmpty [
	super testOrderedListEmpty.
	self assert: result equals: (PROrderedList with: PRListItem new).
	self assertStart: 1 stop: 1.
]

{ #category : #'tests - List' }
PR2PillarParserTest >> testOrderedListMulti [
	super testOrderedListMulti.
	self
		assert: result
		equals:
			(PROrderedList
				withAll:
					{(PRListItem
						withAll:
							{(PRText content: '1').
							(PROrderedList
								withAll:
									{(PRListItem
										withAll:
											{(PRText content: '2').
											(PROrderedList with: (PRListItem with: (PRText content: '3')))}).
									(PRListItem with: (PRText content: '4')).
									(PRListItem with: (PRText content: '5')).
									(PRListItem with: (PRText content: '6'))})}).
					(PRListItem
						withAll:
							{(PRText content: '7').
							(PROrderedList with: (PRListItem with: (PROrderedList with: (PRListItem with: (PRText content: '8')))))})}).
	self assertStart: 1 stop: 31.
	self assertStart: 1 stop: 24 ofNode: result children first.
	self assertStart: 2 stop: 2 ofNode: result children first children first.
	self flag: 'Because of `self listsParser parse: array fifth` in `PR2PillarParser>>#orderedListItem` (and similar methods) the sub-item possitions are not correct'.
	"self assertStart: 4 stop: 12 ofNode: result children first children second."

	self assertStart: 25 stop: 31 ofNode: result children second.
	self assertStart: 26 stop: 26 ofNode: result children second children first.
	
]

{ #category : #'tests - List' }
PR2PillarParserTest >> testOrderedListWithSubList [
	super testOrderedListWithSubList.
	self
		assert: result
		equals:
			(PROrderedList
				with:
					(PRListItem
						withAll:
							{PRText content: 'Foo'.
							PROrderedList with: (PRListItem with: (PRText content: 'Bar'))}))
]

{ #category : #'tests - List' }
PR2PillarParserTest >> testOrderedListWithTwoItems [
	super testOrderedListWithTwoItems.
	self
		assert: result
		equals:
			(PROrderedList
				withAll:
					{(PRListItem with: (PRText content: 'Foo')).
					(PRListItem with: (PRText content: 'Bar'))})
]

{ #category : #'tests - Paragraph' }
PR2PillarParserTest >> testParagraph [
	super testParagraph.
	self assert: result equals: (PRParagraph new add: (PRText content: 'This is a text'))
]

{ #category : #'tests - Paragraph' }
PR2PillarParserTest >> testParagraphWithFormat [
	super testParagraphWithFormat.
	self
		assert: result
		equals:
			(PRParagraph
				withAll:
					{(PRText content: 'Foo ').
					(PRBoldFormat with: (PRText content: 'Bar'))})
]

{ #category : #'tests - Text' }
PR2PillarParserTest >> testRaw [
	super testRaw.
	self assert: result equals: (PRRaw content: 'foo' type: 'mock' )
]

{ #category : #'tests - Text' }
PR2PillarParserTest >> testRawEmpty [
	super testRawEmpty.
	self assert: result equals: (PRRaw content: '')
]

{ #category : #'tests - Text' }
PR2PillarParserTest >> testRawMultiLines [
	super testRawMultiLines.
	self assert: result equals: (PRRaw content: 'foo
bar')
]

{ #category : #'tests - Reference' }
PR2PillarParserTest >> testReference [
	super testReference.
	self
		assert: result
		equals:
			(PRInternalLink new
				add: (PRText content: 'foo');
				anchor: 'bar';
				yourself)
]

{ #category : #'tests - Reference' }
PR2PillarParserTest >> testReferenceFigure [
	super testReferenceFigure.
	self assert: result equals: 'file://foo.png'
]

{ #category : #'tests - Reference' }
PR2PillarParserTest >> testReferenceFigureEscape [
	super testReferenceFigureEscape.
	self assert: result equals: 'file://foo+.png'
]

{ #category : #'tests - Reference' }
PR2PillarParserTest >> testReferenceLink [
	super testReferenceLink.
	self assert: result equals: 'file://foo.png'
]

{ #category : #'tests - Reference' }
PR2PillarParserTest >> testReferenceLinkEscape [
	super testReferenceLinkEscape.
	self assert: result equals: 'file://foo*.png'
]

{ #category : #'tests - Script' }
PR2PillarParserTest >> testScript [
	super testScript.
	self assert: result equals: (PRCodeblock content: 'foo').
	self assertStart: 1 stop: 11.
]

{ #category : #'tests - Script' }
PR2PillarParserTest >> testScriptParameter [
	super testScriptParameter.
	self assert: result equals: #('value' 'foo')
]

{ #category : #'tests - Script' }
PR2PillarParserTest >> testScriptParameterEscape [
	super testScriptParameterEscape.
	self assert: result equals: #('value=' 'foo')
]

{ #category : #'tests - Script' }
PR2PillarParserTest >> testScriptParameterNil [
	| script |
	super testScriptParameterNil.
	script := PRCodeblock content: 'bar'.
	script parameters at: 'foo' put: nil.
	self assert: result equals: script
]

{ #category : #'tests - Script' }
PR2PillarParserTest >> testScriptParameterValue [
	super testScriptParameterValue.
	self assert: result equals: 'foo'
]

{ #category : #'tests - Script' }
PR2PillarParserTest >> testScriptParameterWithNoValues [
	| script |
	super testScriptParameterWithNoValues.
	script := PRCodeblock content: 'bar'.
	script parameters at: 'foo' put: ''.
	self assert: result equals: script.
	self assertStart: 1 stop: 15.
]

{ #category : #'tests - Script' }
PR2PillarParserTest >> testScriptParameterWithoutValue [
	super testScriptParameterWithoutValue.
	self assert: result equals: #('foo'  nil)
]

{ #category : #'tests - Script' }
PR2PillarParserTest >> testScriptParameters [
	super testScriptParameters.
	self
		assert: result
		equals:
			(OrderedDictionary new
				at: 'value' put: 'foo';
				yourself)
]

{ #category : #'tests - Script' }
PR2PillarParserTest >> testScriptParametersEscape [
	super testScriptParametersEscape.
	self
		assert: result
		equals:
			(OrderedDictionary new
				at: 'value' put: 'foo|';
				at: 'bar' put: nil;
				yourself)
]

{ #category : #'tests - Script' }
PR2PillarParserTest >> testScriptParametersMultiple [
	super testScriptParametersMultiple.
	self
		assert: result
		equals:
			(OrderedDictionary new
				at: 'value' put: 'foo';
				at: 'bar' put: nil;
				yourself)
]

{ #category : #'tests - Script' }
PR2PillarParserTest >> testScriptWithLanguage [
	super testScriptWithLanguage.
	self
		assert: result
		equals:
			((PRCodeblock content: 'foo')
				language: PRSmalltalkScriptLanguage default;
				yourself).
	self assertStart: 1 stop: 29.
]

{ #category : #'tests - Script' }
PR2PillarParserTest >> testScriptWithNewLine [
	super testScriptWithNewLine.
	self assert: result equals: (PRCodeblock content: 'foo').
	self assertStart: 1 stop: 12.
]

{ #category : #'tests - Script' }
PR2PillarParserTest >> testScriptWithSpaceAtTheEnd [
	super testScriptWithSpaceAtTheEnd.
	self assert: result equals: (PRCodeblock content: 'foo').
	self assertStart: 1 stop: 13.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testStrikethroughFormat [
	super testStrikethroughFormat.
	self assert: result equals: (PRStrikethroughFormat with: (PRText content: 'Foo')).
	self assertStart: 1 stop: 7.
	self assertStart: 3 stop: 5 ofNode: result children first.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testStrikethroughFormatEmpty [
	super testStrikethroughFormatEmpty.
	self assert: result equals: PRStrikethroughFormat new.
	self assertStart: 1 stop: 4.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testStrikethroughFormatWithEscaped [
	super testStrikethroughFormatWithEscaped.
	self assert: result equals: (PRStrikethroughFormat with: (PRText content: '--')).
	self assertStart: 1 stop: 8.
	self assertStart: 3 stop: 6 ofNode: result children first.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testSubscriptFormat [
	super testSubscriptFormat.
	self assert: result equals: (PRSubscriptFormat with: (PRText content: 'Foo')).
	self assertStart: 1 stop: 7.
	self assertStart: 3 stop: 5 ofNode: result children first.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testSubscriptFormatEmpty [
	super testSubscriptFormatEmpty.
	self assert: result equals: PRSubscriptFormat new.
	self assertStart: 1 stop: 4.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testSubscriptFormatWithEscaped [
	super testSubscriptFormatWithEscaped.
	self assert: result equals: (PRSubscriptFormat with: (PRText content: '@@')).
	self assertStart: 1 stop: 8.
	self assertStart: 3 stop: 6 ofNode: result children first.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testSuperscriptFormat [
	super testSuperscriptFormat.
	self assert: result equals: (PRSuperscriptFormat with: (PRText content: 'Foo')).
	self assertStart: 1 stop: 7.
	self assertStart: 3 stop: 5 ofNode: result children first.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testSuperscriptFormatEmpty [
	super testSuperscriptFormatEmpty.
	self assert: result equals: PRSuperscriptFormat new.
	self assertStart: 1 stop: 4.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testSuperscriptFormatWithEscaped [
	super testSuperscriptFormatWithEscaped.
	self assert: result equals: (PRSuperscriptFormat with: (PRText content: '^^')).
	self assertStart: 1 stop: 8.
	self assertStart: 3 stop: 6 ofNode: result children first.
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTable [
	super testTable.
	self
		assert: result
		equals:
			(PRTable new
				add:
						(PRTableRow new
								add: (PRTableCell align: nil heading: true withAll: {PRText content: 'Foo'});
								add: (PRTableCell align: nil heading: true withAll: {PRText content: 'Bar'});
								yourself);
				add:
						(PRTableRow new
								add: (PRTableCell align: nil heading: false withAll: {PRText content: 'Foo2'});
								add: (PRTableCell align: nil heading: false withAll: {PRText content: 'Bar2'});
								yourself);
				yourself)
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableAlignMarkup [
	super testTableAlignMarkup.
	self assert: result equals: #right
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableCell [
	super testTableCell.
	self assert: result equals: (PRTableCell align: nil heading: false withAll: {PRText content: 'Foo'})
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableCellAreTrimed [
	super testTableCellAreTrimed.
	self assert: result equals: (PRTableCell align: nil heading: false withAll: {PRText content: 'Foo'})
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableCellCenter [
	super testTableCellCenter.
	self assert: result equals: (PRTableCell align: #center heading: false withAll: {PRText content: 'Foo'})
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableCellHeader [
	super testTableCellHeader.
	self assert: result equals: (PRTableCell align: nil heading: true withAll: {PRText content: 'Foo'})
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableCellHeaderCenter [
	super testTableCellHeaderCenter.
	self assert: result equals: (PRTableCell align: #center heading: true withAll: {PRText content: 'Foo'})
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableCellHeaderCenter2 [
	super testTableCellHeaderCenter2.
	self assert: result equals: (PRTableCell align: #center heading: true withAll: {PRText content: 'Foo'})
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableCellHeaderLeft [
	super testTableCellHeaderLeft.
	self assert: result equals: (PRTableCell align: #left heading: true withAll: {PRText content: 'Foo'})
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableCellHeaderLeft2 [
	super testTableCellHeaderLeft2.
	self assert: result equals: (PRTableCell align: #left heading: true withAll: {PRText content: 'Foo'})
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableCellHeaderRight [
	super testTableCellHeaderRight.
	self assert: result equals: (PRTableCell align: #right heading: true withAll: {PRText content: 'Foo'})
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableCellHeaderRight2 [
	super testTableCellHeaderRight2.
	self assert: result equals: (PRTableCell align: #right heading: true withAll: {PRText content: 'Foo'})
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableCellLeft [
	super testTableCellLeft.
	self assert: result equals: (PRTableCell align: #left heading: false withAll: {PRText content: 'Foo'})
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableCellRight [
	super testTableCellRight.
	self assert: result equals: (PRTableCell align: #right heading: false withAll: {PRText content: 'Foo'})
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableCellWithFormat [
	super testTableCellWithFormat.
	self
		assert: result
		equals: (PRTableCell align: nil heading: false withAll: {PRItalicFormat with: (PRText content: 'Foo')})
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableCenterMarkup [
	super testTableCenterMarkup.
	self assert: result equals: #center
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableHeadingMarkup [
	super testTableHeadingMarkup.
	self assert: result equals: true
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableLeftMarkup [
	super testTableLeftMarkup.
	self assert: result equals: #left
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableMarkups [
	super testTableMarkups.
	self
		assert: result
		equals:
			{nil.
			false}
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableMarkupsCenter [
	super testTableMarkupsCenter.
	self
		assert: result
		equals:
			{#center.
			false}
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableMarkupsHeading [
	super testTableMarkupsHeading.
	self
		assert: result
		equals:
			{nil.
			true}
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableMarkupsHeadingAndCenter [
	super testTableMarkupsHeadingAndCenter.
	self
		assert: result
		equals:
			{#center.
			true}
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableMarkupsHeadingAndCenter2 [
	super testTableMarkupsHeadingAndCenter2.
	self
		assert: result
		equals:
			{#center.
			true}
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableRightMarkup [
	super testTableRightMarkup.
	self assert: result equals: #right
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableRow [
	super testTableRow.
	self
		assert: result
		equals:
			(PRTableRow new
				add: (PRTableCell align: nil heading: false withAll: {PRText content: 'Foo'});
				add: (PRTableCell align: nil heading: false withAll: {PRText content: 'Bar'});
				yourself)
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableRowWithEmptyCells [
	super testTableRowWithEmptyCells.
	self
		assert: result
		equals:
			(PRTableRow new
				add: PRTableCell new;
				add: PRTableCell new;
				yourself)
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableRowWithHeading [
	super testTableRowWithHeading.
	self
		assert: result
		equals:
			(PRTableRow new
				add: (PRTableCell align: nil heading: true withAll: {PRText content: 'Foo'});
				add: (PRTableCell align: nil heading: true withAll: {PRText content: 'Bar'});
				yourself)
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableWithComment [
	super testTableWithComment.
	self flag: #todo	"See super."
	"self
		assert: result
		equals:
			(PRTable
				withAll:
					{PRTableRow
						with:
							(PRTableCell
								align: nil
								heading: false
								withAll:
									{PRText content: 'Foo'.
									PRCommentedLine content: 'Comment'}).
					PRTableRow with: (PRTableCell align: nil heading: false withAll: {PRText content: 'Bar'})})"
]

{ #category : #'tests - Table' }
PR2PillarParserTest >> testTableWithNewLine [
	super testTableWithNewLine.
	self
		assert: result
		equals:
			(PRTable new
				add:
						(PRTableRow new
								add: (PRTableCell align: nil heading: true withAll: {PRText content: 'Foo'});
								add: (PRTableCell align: nil heading: true withAll: {PRText content: 'Bar'});
								yourself);
				add:
						(PRTableRow new
								add: (PRTableCell align: nil heading: false withAll: {PRText content: 'Foo2'});
								add: (PRTableCell align: nil heading: false withAll: {PRText content: 'Bar2'});
								yourself);
				yourself)
]

{ #category : #'tests - Anchor' }
PR2PillarParserTest >> testText [
	super testText.
	self assert: result equals: (PRText content: 'Foo').
	self assertStart: 1 stop: 3.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testUnderlineFormat [
	super testUnderlineFormat.
	self assert: result equals: (PRUnderlineFormat with: (PRText content: 'Foo')).
	self assertStart: 1 stop: 7.
	self assertStart: 3 stop: 5 ofNode: result children first.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testUnderlineFormatEmpty [
	super testUnderlineFormatEmpty.
	self assert: result equals: PRUnderlineFormat new.
	self assertStart: 1 stop: 4.
]

{ #category : #'tests - Format' }
PR2PillarParserTest >> testUnderlineFormatWithEscaped [
	super testUnderlineFormatWithEscaped.
	self assert: result equals: (PRUnderlineFormat with: (PRText content: '__')).
	self assertStart: 1 stop: 8.
	self assertStart: 3 stop: 6 ofNode: result children first.
]

{ #category : #'tests - List' }
PR2PillarParserTest >> testUnorderedList [
	super testUnorderedList.
	self
		assert: result
		equals: (PRUnorderedList with: (PRListItem with: (PRText content: 'Foo'))).
	self assertStart: 1 stop: 4.
	self assertStart: 1 stop: 4 ofNode: result children first.
	self assertStart: 2 stop: 4 ofNode: result children first children first.
]

{ #category : #'tests - List' }
PR2PillarParserTest >> testUnorderedListEmpty [
	super testUnorderedListEmpty.
	self assert: result equals: (PRUnorderedList with: PRListItem new).
	self assertStart: 1 stop: 1.
]

{ #category : #'tests - List' }
PR2PillarParserTest >> testUnorderedListMulti [
	super testUnorderedListMulti.
	self
		assert: result
		equals:
			(PRUnorderedList
				withAll:
					{(PRListItem
						withAll:
							{(PRText content: '1').
							(PRUnorderedList
								withAll:
									{(PRListItem
										withAll:
											{(PRText content: '2').
											(PRUnorderedList with: (PRListItem with: (PRText content: '3')))}).
									(PRListItem with: (PRText content: '4')).
									(PRListItem with: (PRText content: '5')).
									(PRListItem with: (PRText content: '6'))})}).
					(PRListItem
						withAll:
							{(PRText content: '7').
							(PRUnorderedList
								with:
									(PRListItem with: (PRUnorderedList with: (PRListItem with: (PRText content: '8')))))})})
]

{ #category : #'tests - List' }
PR2PillarParserTest >> testUnorderedListWithSubList [
	super testUnorderedListWithSubList.
	self
		assert: result
		equals:
			(PRUnorderedList
				with:
					(PRListItem
						withAll:
							{(PRText content: 'Foo').
							(PRUnorderedList with: (PRListItem with: (PRText content: 'Bar')))}))
]

{ #category : #'tests - List' }
PR2PillarParserTest >> testUnorderedListWithTwoItems [
	super testUnorderedListWithTwoItems.
	self
		assert: result
		equals:
			(PRUnorderedList
				withAll:
					{(PRListItem with: (PRText content: 'Foo')).
					(PRListItem with: (PRText content: 'Bar'))})
]
