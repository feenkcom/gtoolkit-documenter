instance creation
newInspectButtonElement
	<return: #BrButton>

	^ self newSlimButton
		"Stencils tend to be reusable, so we have to store a reference to the current result as a model of the view model"
		viewModelDo: [ :aViewModel | aViewModel model: self result ];
		label: 'Inspect';
		action: [ :aButtonElement :aButtonModel |
			aButtonElement fireEvent: (GLMBlocObjectToSelect new toSelect: aButtonModel model) ]