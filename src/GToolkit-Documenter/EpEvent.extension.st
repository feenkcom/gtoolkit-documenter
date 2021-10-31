Extension { #name : #EpEvent }

{ #category : #'*GToolkit-Documenter' }
EpEvent >> gtDefinitionFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Definition';
		priority: 1;
		text: [ (self accept: GtEpiceaNewStateVisitor new) asRopedText foreground: GtDocumentConstants matchLineColor ]
]

{ #category : #'*GToolkit-Documenter' }
EpEvent >> gtSystemFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Diff';
		priority: 2;
		text: [ GtEpiceaDiffStencil new
				from: (self accept: (GtEpiceaCurrentStateVisitor 
					inEnvironment: self class environment));
				to: (self accept: GtEpiceaNewStateVisitor new);
				create ]
]
