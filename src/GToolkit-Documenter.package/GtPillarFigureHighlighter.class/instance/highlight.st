private-container protocol
highlight
	| expandingAttribute previewAttribute attributeCreatingBlock fileNameWithoutPrefix pictureFileReference anImageForm |
	fileNameWithoutPrefix := self pillarNode reference.
    (fileNameWithoutPrefix beginsWith: 'file://')
        ifTrue: [ fileNameWithoutPrefix := fileNameWithoutPrefix
                copyFrom: 'file://' size + 1
                to: fileNameWithoutPrefix size ].
    pictureFileReference := self fileReference parent
        resolveString: fileNameWithoutPrefix.
    (pictureFileReference exists and: [ 
		pictureFileReference isFile
			and: [ pictureFileReference mimeTypes notNil
				and: [ pictureFileReference mimeTypes first matches: ZnMimeType imagePng ] ] ] )ifFalse: [ 
		(self targetText 
			from: self pillarNode start
			to: self pillarNode stop) foreground: Color red.
		^ self ].
	
	attributeCreatingBlock := [ 
		anImageForm := pictureFileReference binaryReadStreamDo: [ :stream | PNGReadWriter formFromStream: stream ].
		GtPillarPictureAttribute new image: anImageForm ].
	expandingAttribute := BrTextExpandButtonAttribute new
		attributesCreatingBlock: attributeCreatingBlock.
	previewAttribute := attributeCreatingBlock value.
	expandingAttribute isExpanded: true.
	expandingAttribute createdAttributes: { previewAttribute }.
	(self targetText 
			from: self pillarNode start
			to: self pillarNode stop) foreground: Color gray.
	self targetText 
		attributes: { expandingAttribute . previewAttribute }
		from: self pillarNode stop
		to: self pillarNode stop