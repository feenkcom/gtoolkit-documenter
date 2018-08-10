*GToolkit-Documenter
languageOrSmalltalk
	| aLanguage |
	aLanguage := self language.
	^ aLanguage = PRUnspecifiedScriptLanguage default 
		ifTrue: [ PRSmalltalkScriptLanguage default ] 
		ifFalse: [ aLanguage ]