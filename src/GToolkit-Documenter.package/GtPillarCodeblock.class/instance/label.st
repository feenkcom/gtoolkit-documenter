accessing
label
	<return: #String>
	^ self pillarNode label ifEmpty: [ GtDocumenterConstants defaultExecuteButtonLabel ]