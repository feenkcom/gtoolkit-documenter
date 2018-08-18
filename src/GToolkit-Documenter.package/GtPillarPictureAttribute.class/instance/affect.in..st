accessing
affect: aBrText in: anEditorElement

	| anImageElement |
	anImageElement := BlElement new
		size: self image extent;
		background: (BlBackground builder image: self image; build);
		yourself.

	^ GtDocumenterUtility newResizableAndPannableElementFor: anImageElement height: self image height