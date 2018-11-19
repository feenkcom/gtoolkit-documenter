"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestGToolkitDocumenterExamples,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Documenter-Examples-Manifest'
}

{ #category : #deprecation }
ManifestGToolkitDocumenterExamples class >> isDeprecated [
	^ true
]

{ #category : #'code-critics' }
ManifestGToolkitDocumenterExamples class >> ruleRBClassNotReferencedRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#'GToolkit-Documenter-Examples')) #'2018-11-19T09:59:12.526809-03:00') )
]
