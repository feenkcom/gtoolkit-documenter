ui
gtPillarFor: aView
	<gtView: 0>
	^ aView explicit
		title: 'Pillar';
		stencil: [ GtDocumenter editorForText: self string ]