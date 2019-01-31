Extension { #name : #XdWriter }

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
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

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
XdWriter >> attachExportedFiles: aDataWriter [
	| count |
	count := 0.
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
						size: eachFile size
						primary: (count = 0).
						count := count + 1. ] ]
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
XdWriter >> document: aDocument [
	self
		documentType: XdDocumenterType;
		attachment: aDocument basename text: aDocument string.
	self reuseOrAddFigures: aDocument.
	self attachChanges: aDocument
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
XdWriter >> documentHtml: aDocument [
	| aPRDocument aDataWriter aHtmlWriter anHtmlContent |
	"Existing images"
	"Crated images"
	aPRDocument := aDocument parse.
	self
		assert: [ aPRDocument isPetit2Failure not ]
		description: [ 'Documenter text cannot be parsed' ].
	aDataWriter := Gt2ExternalDataWriter new.
	aHtmlWriter := GtHTMLWriter new.
	aHtmlWriter configuration
		gtDataWriter: aDataWriter;
		gtUniqueIdGenerator: Gt2UniqueIdGenerator new;
		gtDocument: aDocument.
	anHtmlContent := aHtmlWriter write: aPRDocument.
	self
		documentType: XdHtmlType;
		attachment: self constants htmlIndexFile text: anHtmlContent.
	self reuseOrAddFigures: aDocument.
	self attachExportedFiles: aDataWriter
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
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
