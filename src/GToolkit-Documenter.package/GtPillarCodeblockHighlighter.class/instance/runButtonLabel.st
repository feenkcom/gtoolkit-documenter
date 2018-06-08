as yet unclassified
runButtonLabel
	<return: #String>
	^ self documentPart pillarNode label 
		ifEmpty: [ GtDocumenterConstants defaultExecuteButtonLabel ]