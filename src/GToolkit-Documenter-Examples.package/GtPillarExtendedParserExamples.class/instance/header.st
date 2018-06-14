accessing
header
	<gtExample>
	| aText aDocument |
	aText := '! Hello' asRopedText.
	aDocument := GtPillarExtendedParser parse: aText.
	self assert: aDocument notNil.
	self assert: aDocument isPetitFailure not.
	^ aDocument