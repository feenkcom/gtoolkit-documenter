instance creation
newApplyChangesButtonElement
	<return: #BrButton>
	| aButton |

	aButton := self newSlimButton.
	aButton label: (self epiceaLog hasImpact ifTrue: [ 'Apply' ] ifFalse: [ 'Applied' ]).
	aButton action: [ self epiceaLog applyCodeChanges ].

	self documentPart
		subscribe: GtEpiceaImpactChangedAnnouncement 
		do: [ :anAnnouncement |
			| newValue |
			newValue := anAnnouncement hasImpact ifTrue: [ 'Apply' ] ifFalse: [ 'Applied' ].
			aButton label: newValue ].

	^ aButton