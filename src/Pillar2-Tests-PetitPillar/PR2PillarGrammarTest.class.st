Class {
	#name : #PR2PillarGrammarTest,
	#superclass : #PP2CompositeNodeTest,
	#category : 'Pillar2-Tests-PetitPillar'
}

{ #category : #accessing }
PR2PillarGrammarTest >> parserClass [
	^ PR2PillarGrammar
]

{ #category : #'tests - Reference' }
PR2PillarGrammarTest >> testAliasFigure [
	self parse: 'Alias>' rule: #figureAlias
]

{ #category : #'tests - Reference' }
PR2PillarGrammarTest >> testAliasFigureEscape [
	self parse: 'Alias\>>' rule: #figureAlias
]

{ #category : #'tests - Reference' }
PR2PillarGrammarTest >> testAliasLink [
	self parse: 'Alias>' rule: #linkAlias
]

{ #category : #'tests - Reference' }
PR2PillarGrammarTest >> testAliasLinkEscape [
	self parse: 'Alias\>>' rule: #linkAlias
]

{ #category : #'tests - Anchor' }
PR2PillarGrammarTest >> testAnchor [
	self parse: '@test' rule: #anchor
]

{ #category : #'tests - Anchor' }
PR2PillarGrammarTest >> testAnchorAreTrimed [
	self parse: '@  test  ' rule: #anchor
]

{ #category : #'tests - Anchor' }
PR2PillarGrammarTest >> testAnchorWithNewLine [
	self parse: '@foo
' rule: #elementWithNewline
]

{ #category : #'tests - Anchor' }
PR2PillarGrammarTest >> testAnchorWithSpaceInside [
	self parse: '@foo bar' rule: #anchor
]

{ #category : #'tests - Paragraph' }
PR2PillarGrammarTest >> testAnnotatedParagraph [
	self parse: '@@foo Bar' rule: #annotatedParagraph
]

{ #category : #'tests - Paragraph' }
PR2PillarGrammarTest >> testAnnotatedParagraphEmpty [
	self parse: '@@foo' rule: #annotatedParagraph
]

{ #category : #'tests - Paragraph' }
PR2PillarGrammarTest >> testAnnotatedParagraphEmptyWithNewLine [
	self parse: '@@foo
' rule: #elementWithNewline
]

{ #category : #'tests - Annotation' }
PR2PillarGrammarTest >> testAnnotation [
	self parse: '${inputFile:path=Foo}$' rule: #annotation
]

{ #category : #'tests - Annotation' }
PR2PillarGrammarTest >> testAnnotationAreTrimedAtTheRight [
	self parse: '${inputFile:path=Foo}$  ' rule: #annotation
]

{ #category : #'tests - Annotation' }
PR2PillarGrammarTest >> testAnnotationParameter [
	self parse: 'value=foo' rule: #parameterUntilEndAnnotation
]

{ #category : #'tests - Annotation' }
PR2PillarGrammarTest >> testAnnotationParameters [
	self parse: ':foo=bar|timo=leon' rule: #annotationParameters
]

{ #category : #'tests - Annotation' }
PR2PillarGrammarTest >> testAnnotationParameters2 [
	self parse: 'foo=bar|timo=leon' rule: #parametersUntilEndAnnotation
]

{ #category : #'tests - Annotation' }
PR2PillarGrammarTest >> testAnnotationTag [
	self parse: 'mock' rule: #annotationTag
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testBoldFormat [
	self parse: '""Foo""' rule: #format
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testBoldFormatEmpty [
	self parse: '""""' rule: #format
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testBoldFormatWithEscaped [
	self parse: '""\"\"""' rule: #format
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testCommentedLine [
	self parse: '%some text' rule: #commentedLine
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testCommentedLineWithNewline [
	self parse: '%some text
' rule: #elementWithNewline
]

{ #category : #'tests - List' }
PR2PillarGrammarTest >> testDefinitionList [
	self
		parse:
			';Foo
:Bar'
		rule: #definitionList
]

{ #category : #'tests - Paragraph' }
PR2PillarGrammarTest >> testEmptyParagraph [
	self
		parse:
			'
'
		rule: #emptyParagraph
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testEscapedCharacter [
	self parse: '\*' rule: #escapedCharacter
]

{ #category : #'tests - Reference' }
PR2PillarGrammarTest >> testFigureFollowedByLinkWithAlias [
	self parse: '+file://TeapotWelcome.png+*Go>http://localhost*' rule: #paragraph
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testFormatWithLink [
	self parse: '""*foo*""' rule: #format
]

{ #category : #'tests - Header' }
PR2PillarGrammarTest >> testHeaderEmpty [
	self parse: '!' rule: #header
]

{ #category : #'tests - Header' }
PR2PillarGrammarTest >> testHeaderLevel1 [
	self parse: '!Foo' rule: #header
]

{ #category : #'tests - Header' }
PR2PillarGrammarTest >> testHeaderLevel2 [
	self parse: '!!Foo' rule: #header
]

{ #category : #'tests - Header' }
PR2PillarGrammarTest >> testHeaderLevel3 [
	self parse: '!!!Foo' rule: #header
]

{ #category : #'tests - Header' }
PR2PillarGrammarTest >> testHeaderLevel4 [
	self parse: '!!!!Foo' rule: #header
]

{ #category : #'tests - Header' }
PR2PillarGrammarTest >> testHeaderLevel5 [
	self parse: '!!!!!Foo' rule: #header
]

{ #category : #'tests - Header' }
PR2PillarGrammarTest >> testHeaderLevel6 [
	self parse: '!!!!!!Foo' rule: #header
]

{ #category : #'tests - Header' }
PR2PillarGrammarTest >> testHeaderWithFormat [
	self parse: '!""Foo""' rule: #header
]

{ #category : #'tests - Header' }
PR2PillarGrammarTest >> testHeaderWithFormatAndText [
	self parse: '!""Foo"" bar' rule: #header
]

{ #category : #'tests - Header' }
PR2PillarGrammarTest >> testHeaderWithNewLine [
	self parse: '!Foo
' rule: #elementWithNewline
]

{ #category : #'tests - Header' }
PR2PillarGrammarTest >> testHeaderWithWithLink [
	self parse: '! Foo *Link*' rule: #header
]

{ #category : #'tests - HorizontalRule' }
PR2PillarGrammarTest >> testHorizontalRule [
	self parse: '_' rule: #horizontalRule
]

{ #category : #'tests - HorizontalRule' }
PR2PillarGrammarTest >> testHorizontalRuleFollowByNewLine [
	self parse: '_
' rule: #elementWithNewline
]

{ #category : #'tests - HorizontalRule' }
PR2PillarGrammarTest >> testHorizontalRuleTrimRight [
	self parse: '_  ' rule: #horizontalRule
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testItalicFormat [
	self parse: '''''Foo''''' rule: #format
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testItalicFormatEmpty [
	self parse: '''''''''' rule: #format
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testItalicFormatWithEscaped [
	self parse: '''''\''\''''''' rule: #format
]

{ #category : #'tests - Document' }
PR2PillarGrammarTest >> testLineEnd [
	self parse: '' rule: #lineEnd
]

{ #category : #'tests - Document' }
PR2PillarGrammarTest >> testLineEndwithNewline [
	self parse: String lf rule: #lineEnd
]

{ #category : #'tests - Reference' }
PR2PillarGrammarTest >> testLinkFollowedByFigureWithAlias [
	self parse: '*http://localhost*+Go>file://TeapotWelcome.png+' rule: #paragraph
]

{ #category : #'tests - List' }
PR2PillarGrammarTest >> testListMulti [
	self
		parse:
			'-1
--2
---3
--4
--5
--6
-7
-##8'
		rule: #list
]

{ #category : #'tests - List' }
PR2PillarGrammarTest >> testListWithComment [
	self
		parse:
			'#Foo
%Comment
#Bar'
		rule: #list
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testMonospaceFormat [
	self parse: '==Foo==' rule: #format
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testMonospaceFormatEmpty [
	self parse: '====' rule: #format
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testMonospaceFormatWithEscaped [
	self parse: '==\=\===' rule: #format
]

{ #category : #'tests - Document' }
PR2PillarGrammarTest >> testNewline [
	self parse: Smalltalk os lineEnding rule: #newline
]

{ #category : #'tests - Document' }
PR2PillarGrammarTest >> testNewlineCR [
	self parse: String cr rule: #newline
]

{ #category : #'tests - Document' }
PR2PillarGrammarTest >> testNewlineCRLF [
	self parse: String crlf rule: #newline
]

{ #category : #'tests - Document' }
PR2PillarGrammarTest >> testNewlineLF [
	self parse: String lf rule: #newline
]

{ #category : #'tests - List' }
PR2PillarGrammarTest >> testOrderedList [
	self parse: '#Foo' rule: #orderedList
]

{ #category : #'tests - List' }
PR2PillarGrammarTest >> testOrderedListEmpty [
	self parse: '#' rule: #orderedList
]

{ #category : #'tests - List' }
PR2PillarGrammarTest >> testOrderedListMulti [
	self
		parse:
			'#1
##2
###3
##4
##5
##6
#7
###8'
		rule: #orderedList
]

{ #category : #'tests - List' }
PR2PillarGrammarTest >> testOrderedListWithSubList [
	self
		parse:
			'#Foo
##Bar'
		rule: #orderedList
]

{ #category : #'tests - List' }
PR2PillarGrammarTest >> testOrderedListWithTwoItems [
	self
		parse:
			'#Foo
#Bar'
		rule: #orderedList
]

{ #category : #'tests - Paragraph' }
PR2PillarGrammarTest >> testParagraph [
	self parse: 'This is a text' rule: #paragraph
]

{ #category : #'tests - Paragraph' }
PR2PillarGrammarTest >> testParagraphWithFormat [
	self parse: 'Foo ""Bar""' rule: #paragraph
]

{ #category : #'tests - Reference' }
PR2PillarGrammarTest >> testParameterFigure [
	self parse: 'value=foo' rule: #parameterUntilEndFigure
]

{ #category : #'tests - Reference' }
PR2PillarGrammarTest >> testParameterLink [
	self parse: 'value=foo' rule: #parameterUntilEndLink
]

{ #category : #'tests - Reference' }
PR2PillarGrammarTest >> testParametersFigure [
	self parse: '|foo=bar|timo=leon' rule: #parametersFigure
]

{ #category : #'tests - Reference' }
PR2PillarGrammarTest >> testParametersLink [
	self parse: '|foo=bar|timo=leon' rule: #parametersLink
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testPreformatedLine [
	self parse: '= Foo' rule: #preformatedLine
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testPreformatedText [
	self parse: '= Foo' rule: #preformatedText
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testPreformatedTextEmpty [
	self parse: '= ' rule: #preformatedText
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testPreformatedTextWithMultiLines [
	self
		parse:
			'= Foo
= Bar'
		rule: #preformatedText
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testPreformatedTextWithNewline [
	self parse: '= Foo
' rule: #preformatedText
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testPreformatedTextWithSpaces [
	self parse: '=    Foo' rule: #preformatedText
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testPreformatedTextWithTab [
	self parse: '= 	Foo' rule: #preformatedText
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testRaw [
	self parse: '{{{mock:foo}}}' rule: #raw
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testRawEmpty [
	self parse: '{{{}}}' rule: #raw
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testRawHTML [
	self parse: '{{{html:foo}}}' rule: #raw
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testRawInvalid [
	self parse: '{{{invalid:foo}}}' rule: #raw
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testRawMultiLines [
	self parse: '{{{foo
bar}}}' rule: #raw
]

{ #category : #'tests - Reference' }
PR2PillarGrammarTest >> testReference [
	self parse: '*foo>@bar*' rule: #reference
]

{ #category : #'tests - Reference' }
PR2PillarGrammarTest >> testReferenceFigure [
	self parse: 'file://foo.png' rule: #referenceFigure
]

{ #category : #'tests - Reference' }
PR2PillarGrammarTest >> testReferenceFigureEscape [
	self parse: 'file://foo\+.png' rule: #referenceFigure
]

{ #category : #'tests - Reference' }
PR2PillarGrammarTest >> testReferenceLink [
	self parse: 'file://foo.png' rule: #referenceLink
]

{ #category : #'tests - Reference' }
PR2PillarGrammarTest >> testReferenceLinkEscape [
	self parse: 'file://foo\*.png' rule: #referenceLink
]

{ #category : #'tests - Script' }
PR2PillarGrammarTest >> testScript [
	self
		parse:
			'[[[
foo
]]]'
		rule: #script
]

{ #category : #'tests - Script' }
PR2PillarGrammarTest >> testScriptParameter [
	self parse: 'value=foo' rule: #parameterUntilNewline
]

{ #category : #'tests - Script' }
PR2PillarGrammarTest >> testScriptParameterEscape [
	self parse: 'value\==foo' rule: #parameterUntilNewline
]

{ #category : #'tests - Script' }
PR2PillarGrammarTest >> testScriptParameterNil [
	self
		parse:
			'[[[foo
bar
]]]'
		rule: #script
]

{ #category : #'tests - Script' }
PR2PillarGrammarTest >> testScriptParameterValue [
	self parse: '=foo' rule: #parameterValueUntilNewline
]

{ #category : #'tests - Script' }
PR2PillarGrammarTest >> testScriptParameterWithNoValues [
	self
		parse:
			'[[[foo=
bar
]]]'
		rule: #script
]

{ #category : #'tests - Script' }
PR2PillarGrammarTest >> testScriptParameterWithoutValue [
	self parse: 'foo' rule: #parameterUntilNewline
]

{ #category : #'tests - Script' }
PR2PillarGrammarTest >> testScriptParameters [
	self parse: 'value=foo
' rule: #scriptParameters
]

{ #category : #'tests - Script' }
PR2PillarGrammarTest >> testScriptParametersEscape [
	self parse: 'value=foo\||bar
' rule: #scriptParameters
]

{ #category : #'tests - Script' }
PR2PillarGrammarTest >> testScriptParametersMultiple [
	self parse: 'value=foo|bar
' rule: #scriptParameters
]

{ #category : #'tests - Script' }
PR2PillarGrammarTest >> testScriptWithLanguage [
	self
		parse:
			'[[[language=smalltalk
foo
]]]'
		rule: #script
]

{ #category : #'tests - Script' }
PR2PillarGrammarTest >> testScriptWithNewLine [
	self
		parse:
			'[[[
foo
]]]
'
		rule: #script
]

{ #category : #'tests - Script' }
PR2PillarGrammarTest >> testScriptWithSpaceAtTheEnd [
	self
		parse:
			'[[[
foo
]]]  '
		rule: #script
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testStrikethroughFormat [
	self parse: '--Foo--' rule: #format
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testStrikethroughFormatEmpty [
	self parse: '----' rule: #format
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testStrikethroughFormatWithEscaped [
	self parse: '--\-\---' rule: #format
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testSubscriptFormat [
	self parse: '@@Foo@@' rule: #format
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testSubscriptFormatEmpty [
	self parse: '@@@@' rule: #format
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testSubscriptFormatWithEscaped [
	self parse: '@@\@\@@@' rule: #format
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testSuperscriptFormat [
	self parse: '^^Foo^^' rule: #format
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testSuperscriptFormatEmpty [
	self parse: '^^^^' rule: #format
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testSuperscriptFormatWithEscaped [
	self parse: '^^\^\^^^' rule: #format
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTable [
	self
		parse:
			'|! Foo |! Bar
| Foo2 | Bar2'
		rule: #table
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableAlignMarkup [
	self parse: '}' rule: #tableAlignMarkup
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableCell [
	self parse: '|Foo' rule: #tableCell
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableCellAreTrimed [
	self parse: '|   Foo   ' rule: #tableCell
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableCellCenter [
	self parse: '||Foo' rule: #tableCell
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableCellHeader [
	self parse: '|!Foo' rule: #tableCell
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableCellHeaderCenter [
	self parse: '|!|Foo' rule: #tableCell
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableCellHeaderCenter2 [
	self parse: '||!Foo' rule: #tableCell
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableCellHeaderLeft [
	self parse: '|!{Foo' rule: #tableCell
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableCellHeaderLeft2 [
	self parse: '|{!Foo' rule: #tableCell
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableCellHeaderRight [
	self parse: '|!}Foo' rule: #tableCell
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableCellHeaderRight2 [
	self parse: '|}!Foo' rule: #tableCell
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableCellLeft [
	self parse: '|{Foo' rule: #tableCell
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableCellRight [
	self parse: '|}Foo' rule: #tableCell
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableCellWithFormat [
	self parse: '| ''''Foo'''' ' rule: #tableCell
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableCenterMarkup [
	self parse: '|' rule: #tableCenterMarkup
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableHeadingMarkup [
	self parse: '!' rule: #tableHeadingMarkup
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableLeftMarkup [
	self parse: '{' rule: #tableLeftMarkup
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableMarkups [
	self parse: '|' rule: #tableMarkups
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableMarkupsCenter [
	self parse: '||' rule: #tableMarkups
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableMarkupsHeading [
	self parse: '|!' rule: #tableMarkups
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableMarkupsHeadingAndCenter [
	self parse: '|!|' rule: #tableMarkups
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableMarkupsHeadingAndCenter2 [
	self parse: '||!' rule: #tableMarkups
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableRightMarkup [
	self parse: '}' rule: #tableRightMarkup
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableRow [
	self parse: '| Foo | Bar' rule: #tableRow
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableRowWithEmptyCells [
	self parse: '|  | ' rule: #tableRow
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableRowWithHeading [
	self parse: '|! Foo |! Bar' rule: #tableRow
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableWithComment [
	self flag: #todo	"We need to add that later."
	"self
		parse:
			'|Foo
%Comment
|Bar'
		rule: #table"
]

{ #category : #'tests - Table' }
PR2PillarGrammarTest >> testTableWithNewLine [
	self
		parse:
			'|! Foo |! Bar
| Foo2 | Bar2
'
		rule: #table
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testText [
	self parse: 'Foo' rule: #text
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testTextWithEscapeAtBeginning [
	self parse: '\*Foo' rule: #text
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testTextWithEscapeInTheMiddle [
	self parse: 'Foo \* Bar' rule: #text
]

{ #category : #'tests - Text' }
PR2PillarGrammarTest >> testTextWithMultiEscape [
	self parse: '\*Foo\*' rule: #text
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testUnderlineFormat [
	self parse: '__Foo__' rule: #format
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testUnderlineFormatEmpty [
	self parse: '____' rule: #format
]

{ #category : #'tests - Format' }
PR2PillarGrammarTest >> testUnderlineFormatWithEscaped [
	self parse: '__\_\___' rule: #format
]

{ #category : #'tests - List' }
PR2PillarGrammarTest >> testUnorderedList [
	self parse: '-Foo' rule: #unorderedList
]

{ #category : #'tests - List' }
PR2PillarGrammarTest >> testUnorderedListEmpty [
	self parse: '-' rule: #unorderedList
]

{ #category : #'tests - List' }
PR2PillarGrammarTest >> testUnorderedListMulti [
	self
		parse:
			'-1
--2
---3
--4
--5
--6
-7
---8'
		rule: #unorderedList
]

{ #category : #'tests - List' }
PR2PillarGrammarTest >> testUnorderedListWithSubList [
	self
		parse:
			'-Foo
--Bar'
		rule: #unorderedList
]

{ #category : #'tests - List' }
PR2PillarGrammarTest >> testUnorderedListWithTwoItems [
	self
		parse:
			'-Foo
-Bar'
		rule: #unorderedList
]
