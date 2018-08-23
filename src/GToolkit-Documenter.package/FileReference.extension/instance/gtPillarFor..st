*GToolkit-Documenter
gtPillarFor: aView
	<gtView>
	(#('pier' 'pillar') includes: self extension) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Pillar';
		priority: 10;
		stencil: [ GtDocumenter editorForPillar: self ];
		actionStencil: [ 
			| button |
			button := BrButton new.
			button
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				action:  [
					button fireEvent: (GtPhlowObjectToSpawn new
						object: self parseWithGtDocumenter;
						sourceElement: button) ];
				icon: BrGlamorousIcons play asElement;
				label: 'Parse using GToolkit Documenter' translated ]