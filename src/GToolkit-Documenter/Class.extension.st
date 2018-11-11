Extension { #name : #Class }

{ #category : #'*GToolkit-Documenter' }
Class >> gtInspectorPillarCommentWithBlocIn: composite [
	<gtInspectorPresentationOrder: 19>
	^ composite bloc
		title: '_Comment';
		element: [ GtDocumenter editorForText: self comment ]
]

{ #category : #'*GToolkit-Documenter' }
Class >> gtPillarCommentFor: aView [
	<gtView>
	^ aView explicit
		title: 'Comment (old)';
		priority: 0;
		stencil: [ GtDocumenter editorForText: self comment ];
		actionStencil: [ :tab | 
			BrButton new 
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				icon: BrGlamorousIcons accept asElement;
				action: [ self comment: tab viewContentElement editor text asString ] ]
]
