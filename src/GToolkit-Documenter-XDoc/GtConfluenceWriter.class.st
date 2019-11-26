Class {
	#name : #GtConfluenceWriter,
	#superclass : #PRHTMLWriter,
	#category : #'GToolkit-Documenter-XDoc-Writer'
}

{ #category : #'visiting-document' }
GtConfluenceWriter >> visitExternalLink: anExternalLink [
	canvas tag
		name: 'a';
		parameterAt: 'href' put: (anExternalLink localFileOrExternalReference replaceAllRegex: '&' with: '&amp;');
		with: anExternalLink alias.
]

{ #category : #visiting }
GtConfluenceWriter >> visitGt2ExampleAnnotation: aGt2ExampleAnnotation [
	
]
