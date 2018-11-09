Extension { #name : #PRCodeblock }

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> endMarkupSize [
	^ (PR2PillarGrammar endMarkups at: self class) size
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> newRunButtonAttribute [
	^ Gt2RunButtonAttribute new
		beAppend;
		stencil: (Gt2RunButtonStencilBuilder new
			label: self runButtonLabel;
			document: self gtDocument)
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> runButtonLabel [
	<return: #String>
	^ self label 
		ifEmpty: [ Gt2DocumentConstants defaultRunButtonLabel ]
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleInText: aBlRope [ 
	"Subclasses can add more styling"
	self styleParametersInText: aBlRope.
	self styleRunButtonInText: aBlRope.
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleParametersInText: aBlRope [
	| aLenghtOfTheParameterLine |
	aLenghtOfTheParameterLine := (aBlRope from: self start to: self stop) asString lines first size.
	(aBlRope
		from: self start 
		to: self start + aLenghtOfTheParameterLine)
			foreground: Gt2DocumentConstants subtleColor
]

{ #category : #'*GToolkit-NewDocumenter' }
PRCodeblock >> styleRunButtonInText: aBlRope [
	(aBlRope from: self stop - self endMarkupSize to: self stop)
		attribute: self newRunButtonAttribute
]
