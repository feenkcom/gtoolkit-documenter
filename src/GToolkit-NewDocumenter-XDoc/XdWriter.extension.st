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
						size: eachFile size ] ]
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
XdWriter >> css [
	^ '
	a[aria-expanded=true] .fa-caret-right, a[aria-expanded=false] .fa-caret-down {
  	 	display: none;
	}
	a .fa-caret-right, a .fa-caret-down {
		padding-left: 5px;
		color: #ccc;
	}
	'
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
	aHtmlWriter := PRHTMLWriter new.
	aHtmlWriter configuration
		gtDataWriter: aDataWriter;
		gtDocument: aDocument.
	anHtmlContent := aHtmlWriter write: aPRDocument.
	self
		documentType: XdHtmlType;
		attachment: self constants htmlIndexFile text: anHtmlContent;
		attachment: self constants cssIndexFile text: self css.
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
