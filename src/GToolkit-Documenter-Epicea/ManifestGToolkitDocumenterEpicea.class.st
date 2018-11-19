Class {
	#name : #ManifestGToolkitDocumenterEpicea,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Documenter-Epicea'
}

{ #category : #deprecation }
ManifestGToolkitDocumenterEpicea class >> isDeprecated [
	^ true
]

{ #category : #'code-critics' }
ManifestGToolkitDocumenterEpicea class >> ruleReInspectorPresentationsNonlazyCodeV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#GtOldEpiceaCodeSnippet #gtInspectorEntriesIn: #false)) #'2018-05-16T11:14:14.471903+02:00') )
]
