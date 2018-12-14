Extension { #name : #XdWriter }

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
XdWriter >> document: aDocument [
	| aResources |

	self
		documentType: XdDocumenterType;
		attachment: aDocument basename text: aDocument string.
		
	aResources := aDocument resourcer includeFigures; compute.
	aResources do: [ :eachResource | 
		eachResource resource binaryReadStreamDo: [ :stream | 
			self 
				attachment: (GtFileUtility fileNameOf: eachResource resource relativeTo: aDocument  rootDirectory ) 
				stream: stream 
				size: eachResource resource size ]].
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
XdWriter >> documentHtml: aDocument [
	| aPRDocument aDataWriter aHtmlWriter aResources anHtmlContent |
	
	aPRDocument := aDocument parse.
	self 
		assert: [ aPRDocument isPetit2Failure not ]
		description: [ 'Documenter text cannot be parsed' ].
	aDataWriter := Gt2ExternalDataWriter new.
	aHtmlWriter := PRHTMLWriter new.
	aHtmlWriter configuration gtDataWriter: aDataWriter.
	anHtmlContent :=  aHtmlWriter write: aPRDocument.

	self
		documentType: XdHtmlType;
		attachment: self constants htmlIndexFile text: anHtmlContent.
		
	aResources := aDocument resourcer includeFigures; compute.
	aResources do: [ :eachResource | 
		eachResource resource binaryReadStreamDo: [ :stream | 
			self 
				attachment: (GtFileUtility fileNameOf: eachResource resource relativeTo: aDocument  rootDirectory ) 
				stream: stream 
				size: eachResource resource size ]].
]
