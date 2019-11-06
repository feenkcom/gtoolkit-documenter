Extension { #name : #XdWriter }

{ #category : #'*GToolkit-Documenter-XDoc' }
XdWriter >> attachChanges: aDocument [
	| aResources |
	aResources := aDocument resourcer includeChanges; compute.
	aResources do: [ :eachResource | 
		eachResource resource binaryReadStreamDo: [ :stream | 
			self
				attachment: (GtFileUtility
					fileNameOf: eachResource resource
					relativeTo: aDocument rootDirectory)
				stream: stream
				size: eachResource resource size ] ]
]

{ #category : #'*GToolkit-Documenter-XDoc' }
XdWriter >> attachExportedFiles: aDataWriter [
	aDataWriter allFiles
		do: [ :eachFile | 
			eachFile
				binaryReadStreamDo: [ :aStream | 
					self
						attachment:
							(GtFileUtility
								fileNameOf: eachFile
								relativeTo: aDataWriter rootDirectory)
						stream: aStream
						size: eachFile size.] ]
]

{ #category : #'*GToolkit-Documenter-XDoc' }
XdWriter >> document: aDocument [
	self
		documentType: XdType documenter;
		attachment: aDocument basename text: aDocument string.
	self reuseOrAddFigures: aDocument.
	self attachChanges: aDocument
]

{ #category : #'*GToolkit-Documenter-XDoc' }
XdWriter >> documentHtml: aDocument [
	| aPRDocument aDataWriter aHtmlWriter anHtmlContent |
	aPRDocument := aDocument parse.
	self
		assert: [ aPRDocument isPetit2Failure not ]
		description: [ 'Documenter text cannot be parsed' ].
	aDataWriter := XdExternalDataWriter new.
	aHtmlWriter := GtHTMLWriter new.
	aHtmlWriter configuration
		gtDataWriter: aDataWriter;
		gtUniqueIdGenerator: XdUniqueIdGenerator new;
		gtDocument: aDocument.
	anHtmlContent := aHtmlWriter write: aPRDocument.
	self
		documentType: XdHtmlType;
		attachment: self constants htmlIndexFile text: anHtmlContent.
	self reuseOrAddFigures: aDocument.
	self attachExportedFiles: aDataWriter.

	self addPreview: aDataWriter.
]

{ #category : #'*GToolkit-Documenter-XDoc' }
XdWriter >> reuseOrAddFigures: aDocument [
	| aResources |
	aResources := aDocument resourcer includeFigures; compute.
	aResources do: [ :eachResource | 
		eachResource resource binaryReadStreamDo: [ :stream | 
			self
				reuseOrAddAttachment: (GtFileUtility
					fileNameOf: eachResource resource
					relativeTo: aDocument rootDirectory)
				stream: stream
				size: eachResource resource size ] ]
]
