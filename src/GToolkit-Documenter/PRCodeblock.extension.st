Extension { #name : #PRCodeblock }

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> isSmalltalkLanguage [
	^ self languageOrSmalltalk = PRSmalltalkScriptLanguage default
]

{ #category : #'*GToolkit-Documenter' }
PRCodeblock >> languageOrSmalltalk [
	| aLanguage |
	aLanguage := self language.
	^ aLanguage = PRUnspecifiedScriptLanguage default 
		ifTrue: [ PRSmalltalkScriptLanguage default ] 
		ifFalse: [ aLanguage ]
]
