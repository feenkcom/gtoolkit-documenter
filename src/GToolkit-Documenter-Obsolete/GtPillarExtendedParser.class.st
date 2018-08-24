Class {
	#name : #GtPillarExtendedParser,
	#superclass : #PRPillarParserOld,
	#traits : 'GtAssertingTrait',
	#classTraits : 'GtAssertingTrait classTrait',
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #accessing }
GtPillarExtendedParser >> annotatedParagraph [
	^ super annotatedParagraph token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]
]

{ #category : #accessing }
GtPillarExtendedParser >> annotation [
	^ super annotation token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]
]

{ #category : #accessing }
GtPillarExtendedParser >> dataListItem [
	^ super dataListItem token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]
]

{ #category : #accessing }
GtPillarExtendedParser >> definitionList [
	^ super definitionList token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]
]

{ #category : #accessing }
GtPillarExtendedParser >> header [
	^ super header token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]
]

{ #category : #accessing }
GtPillarExtendedParser >> monospaceFormat [
	^ super monospaceFormat token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]
]

{ #category : #accessing }
GtPillarExtendedParser >> orderedList [
	^ super orderedList token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]
]

{ #category : #accessing }
GtPillarExtendedParser >> orderedListItem [
	^ super orderedListItem token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]
]

{ #category : #accessing }
GtPillarExtendedParser >> script [
	^ super script token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]
]

{ #category : #accessing }
GtPillarExtendedParser >> termListItem [
	^ super termListItem token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]
]

{ #category : #accessing }
GtPillarExtendedParser >> unorderedList [
	^ super unorderedList token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]
]

{ #category : #accessing }
GtPillarExtendedParser >> unorderedListItem [
	^ super unorderedListItem token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]
]
