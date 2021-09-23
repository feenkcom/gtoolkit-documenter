Extension { #name : 'Class' }

{ #category : '*GToolkit-Documenter' }
Class >> gtDocumentFor: aView [
	"<gtView>"
	^ aView explicit
		title: 'Comment';
		priority: -1;
		disableAsync;
		stencil: [ GtDocumenter forClass: self ];
		actionButtonIcon: BrGlamorousVectorIcons accept 
			tooltip: 'Save document' 
			action: [ :aToggle :aTab | aTab viewContentElement save ];
		actionToggleIcon: BrGlamorousIcons edit 
			tooltip: 'Show/Hide Markups'
			activated: [ :aToggle :aTab | aTab viewContentElement showMarkup ] 
			deactivated: [ :aToggle :aTab | aTab viewContentElement hideMarkup ]
]
