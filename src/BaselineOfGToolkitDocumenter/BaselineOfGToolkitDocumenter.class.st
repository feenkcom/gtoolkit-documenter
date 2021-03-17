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
				spec repository: 'github://feenkcom/gtoolkit-completer:v0.8.295/src' ];
			baseline: 'GToolkitCoder' with: [
				spec repository: 'github://feenkcom/gtoolkit-coder:v0.8.369/src' ];
			baseline: 'GToolkitUtility' with: [
				spec repository: 'github://feenkcom/gtoolkit-utility:v0.8.26/src' ];
			baseline: 'GToolkitVariableBindings' with: [
				spec repository: 'github://feenkcom/gtoolkit-playground:v0.8.338/src' ];
			baseline: 'GToolkitVisualizerPhlow' with: [
				spec repository: 'github://feenkcom/gtoolkit-visualizer:v0.8.316/src' ];
			baseline: 'GToolkitExamples' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.8.17/src' ];
			baseline: 'GToolkitInspector' with: [
				spec repository: 'github://feenkcom/gtoolkit-inspector:v0.8.365/src' ];
			baseline: 'PillarExporter' with: [
				spec repository: 'github://feenkcom/pillar:v7.3.23/src' ];
			baseline: 'DeepTraverser' with: [
				spec repository: 'github://feenkcom/DeepTraverser:v1.1.71/src' ];
			baseline: 'XdocClient' with: [
				spec repository: 'github://feenkcom/xdoc:v0.8.311/src' ].
		spec 
			package: 'GToolkit-Documenter' with: [
				spec requires: #('PillarExporter' 'GToolkitCoder' 'GToolkitCompleter' 'GToolkitUtility' 'GToolkitVariableBindings' 'GToolkitExamples' 'GToolkitInspector' ). ];
			package: 'GToolkit-Documenter-XDoc' with: [
				spec requires: #('GToolkit-Documenter' 'GToolkitUtility' 'XdocClient' ). ]. ].

]
