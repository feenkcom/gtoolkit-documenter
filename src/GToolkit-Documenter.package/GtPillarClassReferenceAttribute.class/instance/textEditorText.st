accessing
textEditorText
	<return: #BlText>
	^ self classReference isDefined 
		ifTrue: [ self classReference realClass definition asRopedText ]
		ifFalse: [ self classReference definition asRopedText ]