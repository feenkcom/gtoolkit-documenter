Extension { #name : #FileReference }

{ #category : #'*GToolkit-NewDocumenter' }
FileReference >> gtDocumentFor: aView [
	<gtView>
	(#('pier' 'pillar') includes: self extension) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Document';
		priority: 9;
		stencil: [ Gt2Document forFile: self ];
		actionStencil: [ 
			| button |
			button := BrButton new.
			button
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				action:  [
					button fireEvent: (GtPhlowObjectToSpawn new
						object: self parseWithGt2Documenter;
						sourceElement: button) ];
				icon: BrGlamorousIcons tree asElement;
				label: 'Parse using GToolkit Documenter' translated ];
		actionStencil: [ :tab | 
			BrButton new 
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				icon: BrGlamorousIcons accept asElement;
				action: [ 
					(tab viewContentElement userData 
						at: Gt2DocumentConstants documentUserDataKey) store ] ]
]
