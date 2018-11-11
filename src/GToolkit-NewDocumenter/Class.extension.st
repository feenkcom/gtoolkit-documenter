Extension { #name : #Class }

{ #category : #'*GToolkit-NewDocumenter' }
Class >> gtDocumentFor: aView [
	<gtView>
	^ aView explicit
		title: 'Comment';
		priority: -1;
		stencil: [ Gt2Document forClass: self ];
		actionStencil: [ :tab | 
			BrButton new 
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				icon: BrGlamorousIcons accept asElement;
				action: [ 
					(tab viewContentElement userData 
						at: Gt2DocumentConstants documentUserDataKey) store ] ]
]
