Extension { #name : #FileReference }

{ #category : #'*GToolkit-Documenter' }
FileReference >> gtInspectorPillarWithBlocIn: composite [
	<gtInspectorPresentationOrder: -1>
	^ composite bloc
		title: '_Pillar';
		element: [ GtDocumenter editorForPillar: self ];
		act: [ :bloc |
				self ensureDelete; writeStreamDo: [ :s | s nextPutAll: bloc element editor text asString ] ]
				icon: GLMUIThemeExtraIcons glamorousSave
				on: $s
				entitled: 'Save';
"		act: [ :aBlocPresentation | aBlocPresentation element zoomIn ]
			icon: GLMUIThemeExtraIcons glamorousZoomIn
			entitled: 'Zoom in';
		act: [ :aBlocPresentation | aBlocPresentation element zoomOut ]
			icon: GLMUIThemeExtraIcons glamorousZoomOut
			entitled: 'Zoom out';
		act: [ :aBlocPresentation | aBlocPresentation element zoomReset ]
			icon: GLMUIThemeExtraIcons glamorousZoomToFit
			entitled: 'Zoom reset';
"		act: [ :aBlocPresentation | aBlocPresentation element editor inspect ]
			icon: GLMUIThemeExtraIcons glamorousInspect
			entitled: 'Inspect'; 
		when: [ 
			self exists and: [
				#('pier' 'pillar') includes: self extension ] ] 
]

{ #category : #'*GToolkit-Documenter' }
FileReference >> gtPillarFor: aView [
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
]
