*GToolkit-Documenter-Exporter
parseWithGtDocumenter
	| encoding |
	encoding := [ self binaryReadStreamDo: [ :in | (ZnCharacterEncoder detectEncoding: in upToEnd) identifier ] ]
		on: ZnCharacterEncodingError
		do: [ nil ].
	^ self binaryReadStreamDo: [ :in | 
		PR2PillarParser new optimize parse: (ZnCharacterReadStream on: in encoding: encoding) upToEnd ]