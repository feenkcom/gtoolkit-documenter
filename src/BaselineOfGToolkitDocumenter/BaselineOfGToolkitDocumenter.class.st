"
!Documenter
The Documenter is a tool for creating and consuming live documents directly in the development environment. 

At its core it offers a live editor for manipulating Pillar documents. The interaction happens seamlessly directly in the text editor, and it can be combined with different types of previews to serve several classes of use cases:
- documentation of existing code
- tutorials
- interactive data notebooks

Take a look at the demo file here:
${icebergFile:path=feenkcom/gtoolkit-demos/doc/tutorial/esug-2018-documenter/documenter.pillar}$

"
Class {
	#name : 'BaselineOfGToolkitDocumenter',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfGToolkitDocumenter'
}

{ #category : 'baseline' }
BaselineOfGToolkitDocumenter >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'GToolkitCompleter' with: [
				spec repository: 'github://feenkcom/gtoolkit-completer:v0.8.396/src' ].
		spec
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:v0.8.481/src' ].
		spec
			baseline: 'GToolkitUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.65/src' ].
		spec
			baseline: 'GToolkitVisualizerPhlow' with: [
				spec repository: 'github://feenkcom/gtoolkit-visualizer:v0.8.435/src' ].
		spec
			baseline: 'GToolkitExamples' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.8.32/src' ].
		spec
			baseline: 'GToolkitInspector' with: [
				spec repository: 'github://feenkcom/gtoolkit-inspector:v0.8.510/src' ].
		spec
			baseline: 'PillarExporter' with: [
				spec repository: 'github://feenkcom/pillar:v7.3.25/src' ].
		spec
			baseline: 'DeepTraverser' with: [
				spec repository: 'github://feenkcom/DeepTraverser:v1.1.87/src' ].
		spec
			baseline: 'XdocClient' with: [
				spec repository: 'github://feenkcom/xdoc:v0.8.421/src' ].

		spec package: 'GToolkit-Documenter' with: [
			spec requires: #('PillarExporter' 'GToolkitCoder' 'GToolkitCompleter' 'GToolkitUtility' 'GToolkitExamples' 'GToolkitInspector') ].
		spec package: 'GToolkit-Documenter-XDoc' with: [
			spec requires: #('GToolkit-Documenter' 'GToolkitUtility' 'XdocClient') ].
	]
]
