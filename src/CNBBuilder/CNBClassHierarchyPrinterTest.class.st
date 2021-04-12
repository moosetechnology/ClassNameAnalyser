Class {
	#name : #CNBClassHierarchyPrinterTest,
	#superclass : #TestCase,
	#instVars : [
		'printer'
	],
	#category : #CNBBuilder
}

{ #category : #running }
CNBClassHierarchyPrinterTest >> setUp [
	super setUp.
	
	"Put here a common initialization logic for tests"
	
	printer := CNBClassHierarchyPrinter new.
]

{ #category : #running }
CNBClassHierarchyPrinterTest >> testPrintForClass [ 

	| output stream theClass |
	theClass := CNBAbstractModel.
	output := (printer forClass: theClass) print.
	stream := (String new: 100) writeStream.
	theClass allSuperclasses reverseDo: [ :aClass | stream nextPutAll: aClass name. stream cr. stream tab ].
	stream cr.
	stream nextPutAll: '------->'.	stream tab. stream tab. stream nextPutAll: theClass name. stream cr.
	stream tab.
	theClass subclasses do: [ :aClass | stream tab. stream nextPutAll: aClass name. stream cr. stream tab. ].
	
	self 
		assert: output equals: stream contents
	
	
	
]
