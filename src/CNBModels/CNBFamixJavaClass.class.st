Class {
	#name : #CNBFamixJavaClass,
	#superclass : #TestCase,
	#instVars : [
		'classC',
		'classB',
		'classA',
		'classI1',
		'classI2',
		'classI3',
		'inheritanceCB',
		'model',
		'inheritanceCI1',
		'inheritanceBA',
		'inheritanceAI2',
		'inheritanceAI3',
		'classObject',
		'inheritanceAObject'
	],
	#category : #CNBModels
}

{ #category : #running }
CNBFamixJavaClass >> setUp [
	super setUp.
	
	"Classes definition"
	classC := FamixJavaClass named: 'classC'.
	classB := FamixJavaClass named: 'classB'.
	classA := FamixJavaClass named: 'classA'.
	classObject := FamixJavaClass named: 'Object'.
	
	"Interfaces definition"
	classI1 := (FamixJavaClass named: 'classI1') isInterface: true; yourself.
	classI2 := (FamixJavaClass named: 'classI2') isInterface: true; yourself.
	classI3 := (FamixJavaClass named: 'classI3') isInterface: true; yourself.
	
	"Inheritance relations definition"
	inheritanceCB := FamixJavaInheritance new subclass: classC; superclass: classB.
	inheritanceCI1 := FamixJavaInheritance new subclass: classC; superclass: classI1.
	inheritanceBA := FamixJavaInheritance new subclass: classB; superclass: classA.
	inheritanceAI2 := FamixJavaInheritance new subclass: classA; superclass: classI2.
	inheritanceAI3 := FamixJavaInheritance new subclass: classA; superclass: classI3.
	inheritanceAObject := FamixJavaInheritance new subclass: classA; superclass: classObject.
	
	
]

{ #category : #tests }
CNBFamixJavaClass >> testRootAccordingToAClassName [

	self 
		assert: (classC rootAccordingTo: 'Object')
		equals: classA
]

{ #category : #tests }
CNBFamixJavaClass >> testSuperInheritances [

	self 
		assert: classC superInheritances size 
		equals: 2
]

{ #category : #tests }
CNBFamixJavaClass >> testSuperInheritancesWithoutInterfaces [

	self 
		assert: ((classC superInheritances collect: #target) reject: #isInterface) first name
		equals: 'classB'
]

{ #category : #tests }
CNBFamixJavaClass >> testSuperclassHierarchy [

	self 
		assert: classC superclassHierarchy size 
		equals: 5
]

{ #category : #tests }
CNBFamixJavaClass >> testSuperclassHierarchyWithoutInterfaces [

	self 
		assert: (classC superclassHierarchy reject: #isInterface) size
		equals: 2
]
