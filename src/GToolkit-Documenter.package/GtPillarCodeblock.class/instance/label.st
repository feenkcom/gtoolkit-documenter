as yet unclassified
label
	<return: #String>
	^ self pillarNode label ifEmpty: [ GtDocumenterConstants defaultExecuteButtonLabel ]