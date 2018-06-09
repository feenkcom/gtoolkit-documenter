accessing
documentPartAt: anInteger 
	^ collection at: anInteger ifAbsent: [ nil ]