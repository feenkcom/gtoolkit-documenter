event handling
displayGlobalChanges: aBlElement
	"Trigger event to display ${class:GtEpiceaLog}$ in an inspector"
	aBlElement fireEvent: (GLMBlocObjectToSelect new toSelect: self epiceaLog)