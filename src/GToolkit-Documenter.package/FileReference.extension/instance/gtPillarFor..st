*GToolkit-Documenter
gtPillarFor: aView
	<gtView: 0>
	(#('pier' 'pillar') includes: self extension) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Pillar';
		priority: 10;
		stencil: [ GtDocumenter editorForPillar: self ]