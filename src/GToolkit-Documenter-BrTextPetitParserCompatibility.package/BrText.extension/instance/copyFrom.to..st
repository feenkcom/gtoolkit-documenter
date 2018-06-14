*GToolkit-Documenter-BrTextPetitParserCompatibility
copyFrom: aStartInteger to: anEndInteger 
	"aStartInteger can be bigger than anEndInteger and also bigger than self size."
	aStartInteger > anEndInteger ifTrue: [ ^ String empty ].
	^ self from: aStartInteger to: anEndInteger