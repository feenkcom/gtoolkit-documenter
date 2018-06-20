*GToolkit-Documenter-Exporter
parseWithGtDocumenter
	^ self readStreamDo: [ :aStream | 
		PR2PillarParser parse: aStream ].