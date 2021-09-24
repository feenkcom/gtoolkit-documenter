Extension { #name : 'PRObject' }

{ #category : '*GToolkit-Documenter' }
PRObject >> gtProperties: aView [
	<gtView>
	properties ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Properties';
		priority: 5;
		items: [ self properties asOrderedCollection ]
]
