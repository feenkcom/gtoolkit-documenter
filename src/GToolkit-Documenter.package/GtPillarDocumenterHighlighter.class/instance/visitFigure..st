visiting-document
visitFigure: aFigure
	| expandingAttribute previewAttribute attributeCreatingBlock fileNameWithoutPrefix pictureFileReference anImageForm |
	fileNameWithoutPrefix := aFigure reference.
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
			from: aFigure start
			to: aFigure stop) foreground: Color red.
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
			from: aFigure start
			to: aFigure stop) foreground: Color gray.
	self targetText 
		attributes: { expandingAttribute . previewAttribute }
		from: aFigure stop
		to: aFigure stop