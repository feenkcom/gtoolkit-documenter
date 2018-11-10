Extension { #name : #EpEvent }

{ #category : #'*GToolkit-NewDocumenter' }
EpEvent >> gtDefinitionFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Definition';
		priority: 1;
		text: [ (self accept: EpNewStateVisitor new) asRopedText 
			monospace; 
			foreground: Gt2DocumentConstants matchLineColor ]
]

{ #category : #'*GToolkit-NewDocumenter' }
EpEvent >> gtSystemFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Diff';
		priority: 2;
		text: [ Gt2EpiceaDiffStencil new
				from: (self accept: (GtEpiceaCurrentStateVisitor 
					inEnvironment: self class environment));
				to: (self accept: EpNewStateVisitor new);
				create ]
]
