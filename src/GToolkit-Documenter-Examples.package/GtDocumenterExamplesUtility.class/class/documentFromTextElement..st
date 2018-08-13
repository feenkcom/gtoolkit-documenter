utility - accessing
documentFromTextElement: aBlTextElement 
	<return: #GtDocument>
	| aDocument |
	aDocument := aBlTextElement editor styler document.
	self assert: aDocument notNil.
	self assert: aDocument documentParts notNil.
	^ aDocument