*GToolkit-Documenter-Exporter
parseWithGtDocumenter
	^ self readStreamDo: [ :aStream | 
		PR2PillarParser new optimize parse: aStream ].