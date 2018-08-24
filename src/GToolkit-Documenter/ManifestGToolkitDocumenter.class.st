"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestGToolkitDocumenter,
	#superclass : #PackageManifest,
	#category : 'GToolkit-Documenter-Manifest'
}

{ #category : #'code-critics' }
ManifestGToolkitDocumenter class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#GtPillarInspectorStencil #create #false)) #'2018-08-10T09:01:38.326112-04:00') )
]

{ #category : #'code-critics' }
ManifestGToolkitDocumenter class >> ruleRBCollectionMessagesToExternalObjectRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#GtSystemChangesHandler #initialize #false)) #'2018-05-17T10:40:44.150367+02:00') )
]
