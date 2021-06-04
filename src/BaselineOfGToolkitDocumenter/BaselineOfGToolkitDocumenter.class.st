"
1. Documenter
The Documenter is a tool for creating and consuming live documents directly in the development environment. 

At its core it offers a live editor for manipulating Pillar documents. The interaction happens seamlessly directly in the text editor, and it can be combined with different types of previews to serve several classes of use cases:
- documentation of existing code
- tutorials
- interactive data notebooks

Take a look at the demo file here:
[documenter.pillar](fileLocator://gtResource/feenkcom/gtoolkit-demos/doc/tutorial/esug-2018-documenter/documenter.pillar)


"
Class {
	#name : #BaselineOfGToolkitDocumenter,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitDocumenter
}

{ #category : #baseline }
BaselineOfGToolkitDocumenter >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'GToolkitCompleter' with: [
				spec repository: 'github://feenkcom/gtoolkit-completer/src' ];
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder/src' ];
			baseline: 'GToolkitUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility/src' ];
			baseline: 'GToolkitVisualizerPhlow' with: [
				spec repository: 'github://feenkcom/gtoolkit-visualizer/src' ];
			baseline: 'GToolkitExamples' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples/src' ];
			baseline: 'GToolkitInspector' with: [
				spec repository: 'github://feenkcom/gtoolkit-inspector/src' ];
			baseline: 'PillarExporter' with: [
				spec repository: 'github://feenkcom/pillar:feenk/src' ];
			baseline: 'DeepTraverser' with: [
				spec repository: 'github://feenkcom/DeepTraverser/src' ];
			baseline: 'XdocClient' with: [
				spec repository: 'github://feenkcom/xdoc/src' ].
		spec
			package: 'GToolkit-Documenter' with: [
				spec requires: #(#PillarExporter #GToolkitCoder #GToolkitCompleter #GToolkitUtility #GToolkitExamples #GToolkitInspector ). ];
			package: 'GToolkit-Documenter-XDoc' with: [
				spec requires: #('GToolkit-Documenter' #GToolkitUtility #XdocClient ). ]. ].

]
