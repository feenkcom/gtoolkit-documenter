private
complete: label with: insertedText deleting: deleteSize at: positionInteger prefixSize: prefixSize
	| insertionAction deleteAction |
	insertionAction := GtInsertTextCompletionAction
		labeled: label
		completion: insertedText
		position: positionInteger
		from: positionInteger - prefixSize + 1.
	deleteSize = 0
		ifTrue: [ ^ insertionAction ].
	deleteAction := GtDeleteTextCompletionAction labeled: label from: positionInteger + 1 to: positionInteger + deleteSize.
	^ (GtCompositeCompletionAction labeled: label)
		addAction: deleteAction;
		addAction: insertionAction;
		yourself