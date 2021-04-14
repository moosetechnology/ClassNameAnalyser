"
This class contains tests

 -> inherits, => implements
classC: -> classB; => I1; -> parameterizedTypeD (contains paraneterizableClassD which is an Interface)
classB: -> classA
classA: => I2; => I3; -> ParameterizedTypeE (contains parameterizableClassE)
parameterizableClassE: -> classO
classO: -> Object
"
Class {
	#name : #CNBFamixJavaClassTest,
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
		'inheritanceAObject',
		'parameterizableClassD',
		'parameterizableClassE',
		'parameterizedTypeD',
		'parameterizedTypeE',
		'inheritanceCParameterizableTypeD',
		'classO',
		'inheritanceOObject',
		'inheritanceAParameterizedTypeE',
		'inheritanceOParameterizableClassE'
	],
	#category : #CNBModels
}

{ #category : #running }
CNBFamixJavaClassTest >> setUp [
	super setUp.
	
	"Classes definition"
	classC := FamixJavaClass named: 'classC'.
	classB := FamixJavaClass named: 'classB'.
	classA := FamixJavaClass named: 'classA'.
	classO := FamixJavaClass named: 'classO'.
	classObject := FamixJavaClass named: 'Object'.
	
	"Parameterizable classes"
	parameterizableClassD 
		:= FamixJavaParameterizableClass new name: 'parameterizableClassD'; isInterface: true; yourself.
		
	parameterizableClassE := FamixJavaParameterizableClass new name: 'parameterizableClassE'.
	
	"ParameterizedTypes each has a parameterizableClass"
	parameterizedTypeD 
		:= FamixJavaParameterizedType new name: 'parameterizedTypeD'; 
			parameterizableClass: parameterizableClassD; yourself.
	parameterizedTypeE 
		:= FamixJavaParameterizedType new name: 'parameterizedTypeE'; 
		parameterizableClass: parameterizableClassE;yourself.
	
	"Interfaces definition"
	classI1 := (FamixJavaClass named: 'classI1') isInterface: true; yourself.
	classI2 := (FamixJavaClass named: 'classI2') isInterface: true; yourself.
	classI3 := (FamixJavaClass named: 'classI3') isInterface: true; yourself.
	
	"Inheritance relations definition"
	inheritanceCB := FamixJavaInheritance new subclass: classC; superclass: classB.
	inheritanceCI1 := FamixJavaInheritance new subclass: classC; superclass: classI1.
	
	inheritanceCParameterizableTypeD 
		:= FamixJavaInheritance new subclass: classC; superclass: parameterizedTypeD.
		
	inheritanceBA := FamixJavaInheritance new subclass: classB; superclass: classA.
	inheritanceAI2 := FamixJavaInheritance new subclass: classA; superclass: classI2.
	inheritanceAI3 := FamixJavaInheritance new subclass: classA; superclass: classI3.
	
	inheritanceAParameterizedTypeE 
		:= FamixJavaInheritance new subclass: classA; superclass: 	parameterizedTypeE.
			
	inheritanceOParameterizableClassE 
		:= FamixJavaInheritance new subclass: parameterizableClassE; superclass: 	classO. 
			
	inheritanceOObject := FamixJavaInheritance new subclass: classO; superclass: classObject.
	
	
]

{ #category : #tests }
CNBFamixJavaClassTest >> testRootAccordingToAClassName [

	self 
		assert: (classC rootAccordingTo: 'Object')
		equals: classO
]

{ #category : #tests }
CNBFamixJavaClassTest >> testSuperClass [ 

	self 
		assert: classC superClass 
		equals: classB
]

{ #category : #tests }
CNBFamixJavaClassTest >> testSuperClassA [ 

"A Implements I2, Implements I3, inherits from parameterizedTypeE which has the parameterizableClassE"

	self 
		assert: classA superClass 
		equals: parameterizableClassE 
]

{ #category : #tests }
CNBFamixJavaClassTest >> testSuperInheritances [

	self 
		assert: classC superInheritances size 
		equals: 3
]

{ #category : #tests }
CNBFamixJavaClassTest >> testSuperInheritancesWithoutInterfaces [

	self 
		assert: ((classC superInheritances collect: #target) reject: #isInterface) first name
		equals: 'classB'
]

{ #category : #tests }
CNBFamixJavaClassTest >> testSuperclassHierarchy [

	self 
		assert: (classC superclassHierarchy collect: #name) asArray
		
		equals: #(
					'classB' 
					'classI1' 
					'parameterizedTypeD' 
					'classA' 
					'classI2' 
					'classI3' 
					'parameterizedTypeE' 
					'parameterizableClassE' 
					'classO' 
					'Object' 
					'parameterizableClassD'
					 )
]

{ #category : #tests }
CNBFamixJavaClassTest >> testSuperclassHierarchyWithoutInterfaces [

	self 
		assert: ((classC superclassHierarchy reject: #isInterface) collect: #name) asArray
		equals: #(	
					'classB' 
					'parameterizedTypeD' 
					'classA' 
					'parameterizedTypeE' 
					'parameterizableClassE' 
					'classO' 
					'Object' 
		)
]

{ #category : #tests }
CNBFamixJavaClassTest >> testSuperclasses [

	self 
		assert: (((classC superclassHierarchy reject: #isInterface) 
							select: #isClass)collect: #name) asArray
		equals: #(	
					'classB' 
					'classA' 
					'parameterizableClassE' 
					'classO' 
					'Object' 
		)
]
