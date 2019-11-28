Class {
	#name : #GtConfluenceWriter,
	#superclass : #PRHTMLWriter,
	#category : #'GToolkit-Documenter-XDoc-Writer'
}

{ #category : #private }
GtConfluenceWriter >> exportImgFor: aFigure [
	canvas tag
		name: 'ac:image';
		parameterAt: 'ac:height' put: '250';
		with: [
			canvas emptyTag
				name: 'ri:attachment';
				parameterAt: 'ri:filename' put: 'file.png';
				closeTag.
		].
]

{ #category : #'visiting-document' }
GtConfluenceWriter >> visitExternalLink: anExternalLink [
	canvas tag
		name: 'a';
		parameterAt: 'href' put: (anExternalLink localFileOrExternalReference replaceAllRegex: '&' with: '&amp;');
		with: anExternalLink alias.
]

{ #category : #visiting }
GtConfluenceWriter >> visitGt2ExampleAnnotation: aGt2ExampleAnnotation [
	"self gtWriteExampleResult: aGt2ExampleAnnotation."
]
