instance creation
newBrowseGlobalChangesButtonModel
	^ BrButtonModel new
		label: 'Edit';
		action: [ :anElement :theModel | self epiceaLog displayGlobalChanges: theModel ]