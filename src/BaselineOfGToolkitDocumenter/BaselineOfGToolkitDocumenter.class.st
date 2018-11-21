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
	spec for: #common do: [ 
		spec
			baseline: 'Brick' with: [ spec
				repository: 'github://pharo-graphics/Brick/src' ];
			baseline: 'GToolkitCompleter' with: [ spec
				repository: 'github://feenkcom/gtoolkit-completer/src' ];
			baseline: 'GToolkitCoder' with: [ spec
				repository: 'github://feenkcom/gtoolkit-coder/src' ];
			baseline: 'GToolkitUtility' with: [ spec 
				repository: 'github://feenkcom/gtoolkit-utility/src' ];
			baseline: 'GToolkitVariableBindings' with: [ spec 
				repository: 'github://feenkcom/gtoolkit-playground/src' ];
			baseline: 'GToolkitExamples' with: [ spec 
				repository: 'github://feenkcom/gtoolkit-examples/src' ];
			baseline: 'GToolkitInspector' with: [ spec
				repository: 'github://feenkcom/gtoolkit-inspector/src' ];
			baseline: 'PillarExporter' with: [ spec
				repository: 'github://feenkcom/pillar:feenk/src' ];
			project: 'DeepTraverser' with: [ spec
				className: #ConfigurationOfDeepTraverser;
				versionString: #development;
				repository: 'http://smalltalkhub.com/mc/Moose/DeepTraverser/main/' ];
			package: 'GToolkit-Documenter' with: [ spec requires: #( 
				#Brick #PillarExporter 
				#GToolkitCoder
				#GToolkitCompleter
				#GToolkitUtility 
				#GToolkitVariableBindings
				#GToolkitExamples 
				#GToolkitInspector ) ];
			package: 'GToolkit-Documenter-Exporter' with: [ spec requires: #( 
				#Brick #PillarExporter #GToolkitUtility 'GToolkit-Documenter' ) ];
			package: 'GToolkit-Documenter-Exporter-Tests' with: [ spec requires: #( 
				'GToolkit-Documenter-Exporter' ) ];
			package: 'GToolkit-Documenter-Epicea' with: [ spec requires: #(
				 'Brick' 'GToolkitUtility' 'GToolkit-Documenter' 'GToolkit-Documenter-Exporter' ) ];
			package: 'GToolkit-Documenter-Examples' with: [ spec requires: #( 
				'GToolkitExamples' 'GToolkit-Documenter' 'GToolkit-Documenter-Exporter'
				'GToolkit-Documenter-Epicea' ) ];
			package: 'GToolkit-NewDocumenter' with: [ spec requires: #( 
				#Brick 
				#PillarExporter 
				#GToolkitCoder
				#GToolkitCompleter
				#GToolkitUtility 
				#GToolkitVariableBindings
				#GToolkitExamples 
				#GToolkitInspector ) ]
	].

	spec for: #'pharo6.x' do: [ 
		spec
			baseline: 'GToolkitPharo6Compatibility' with: [ spec 
				repository: 'github://feenkcom/gtoolkit/src' ];
			configuration: 'WebBrowser' with: [ spec 
				repository: 'http://smalltalkhub.com/mc/TorstenBergmann/WebBrowser/main/' ];
			package: 'GToolkit-Documenter' with: [ spec 
				requires: #( 'WebBrowser' 'GToolkitPharo6Compatibility' ) ];
			package: 'GToolkit-NewDocumenter' with: [ spec 
			 	requires: #( 'WebBrowser' 'GToolkitPharo6Compatibility' ) ]
	].
]
