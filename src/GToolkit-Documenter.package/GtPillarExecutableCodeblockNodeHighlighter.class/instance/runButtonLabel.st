as yet unclassified
runButtonLabel
	<return: #String>
	^ self executableNode pillarNode label 
		ifEmpty: [ GtDocumenterConstants defaultExecuteButtonLabel ]