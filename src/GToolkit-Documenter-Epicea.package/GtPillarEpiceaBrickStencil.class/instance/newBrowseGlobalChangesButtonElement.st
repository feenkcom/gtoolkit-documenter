instance creation
newBrowseGlobalChangesButtonElement
	<return: #BrButton>

	^ self newSlimButton
		label: 'Edit';
		action: [ :anElement :theModel | self displayGlobalChanges: anElement ]