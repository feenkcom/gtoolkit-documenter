grammar - List
list
	self flag: #todo.	"The list elements should be trim."
	self flag: #memoized.
	^ (unorderedList / orderedList / definitionList) "memoized"