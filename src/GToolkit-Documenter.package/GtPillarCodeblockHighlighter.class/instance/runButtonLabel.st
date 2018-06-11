accessing - pillar node
runButtonLabel
	<return: #String>
	^ self documentPart pillarNode label 
		ifEmpty: [ GtDocumenterConstants defaultExecuteButtonLabel ]