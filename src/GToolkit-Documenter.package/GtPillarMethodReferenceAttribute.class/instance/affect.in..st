accessing
affect: aBrText in: anEditorElement
	| anEmbededElement |
	anEmbededElement := super affect: aBrText in: anEditorElement.
	anEmbededElement editor styler classOrMetaClass: self methodReference realClass.
	^ anEmbededElement