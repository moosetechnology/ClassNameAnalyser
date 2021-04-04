Class {
	#name : #CNBClassHierarchyPrinter,
	#superclass : #ClassHierarchyPrinter,
	#category : #CNBBuilder
}

{ #category : #'public API' }
CNBClassHierarchyPrinter >> print [
	"Answer a description containing the names and instance variable names 
	of all of the subclasses and superclasses of the class."
	
	theClass ifNotNil: [ 
		showSuperclasses 
			ifTrue: [ self printSuperclasses ].
			stream nextPutAll: '------->'.
			self printClass: theClass.
			self printSubclassesOf: theClass ].
	^ stream contents
]

{ #category : #printing }
CNBClassHierarchyPrinter >> printClass: aClass [
	"Print a single line in the printout."
	stream tab: index.
	stream nextPutAll: aClass name.
	
	stream cr
]
