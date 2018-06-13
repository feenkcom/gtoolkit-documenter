*GToolkit-Documenter-Exporter
parseWithGtDocumenter
	^ self readStreamDo: [ :aStream | 
		GtPillarExtendedParser parse: aStream ].