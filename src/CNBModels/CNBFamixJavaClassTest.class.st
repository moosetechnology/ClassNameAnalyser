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
		'inheritanceOParameterizableClassE',
		'interface1',
		'interface2',
		'interface3'
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
	parameterizableClassD := FamixJavaParameterizableInterface new name:
		                         'parameterizableClassD'.

	parameterizableClassE := FamixJavaParameterizableClass new name:
		                         'parameterizableClassE'.

	"ParameterizedTypes each has a parameterizableClass"
	parameterizedTypeD := FamixJavaParameterizedType new
		                      name: 'parameterizedTypeD';
		                      parameterizableClass: parameterizableClassD;
		                      yourself.
	parameterizedTypeE := FamixJavaParameterizedType new
		                      name: 'parameterizedTypeE';
		                      parameterizableClass: parameterizableClassE;
		                      yourself.

	"Interfaces definition"
	interface1 := FamixJavaInterface named: 'interface1'.
	interface2 := FamixJavaInterface named: 'interface2'.
	interface3 := FamixJavaInterface named: 'interface3'.

	"Inheritance relations definition"
	inheritanceCB := FamixJavaInheritance new
		                 subclass: classC;
		                 superclass: classB.
	inheritanceCI1 := FamixJavaInheritance new
		                  subclass: classC;
		                  superclass: interface1.

	inheritanceCParameterizableTypeD := FamixJavaInheritance new
		                                    subclass: classC;
		                                    superclass: parameterizedTypeD.

	inheritanceBA := FamixJavaInheritance new
		                 subclass: classB;
		                 superclass: classA.
	inheritanceAI2 := FamixJavaInheritance new
		                  subclass: classA;
		                  superclass: interface2.
	inheritanceAI3 := FamixJavaInheritance new
		                  subclass: classA;
		                  superclass: interface3.

	inheritanceAParameterizedTypeE := FamixJavaInheritance new
		                                  subclass: classA;
		                                  superclass: parameterizedTypeE.

	inheritanceOParameterizableClassE := FamixJavaInheritance new
		                                     subclass: parameterizableClassE;
		                                     superclass: classO.

	inheritanceOObject := FamixJavaInheritance new
		                      subclass: classO;
		                      superclass: classObject
]

{ #category : #tests }
CNBFamixJavaClassTest >> testRootAccordingToAClassName [

	self 
		assert: (classC rootAccordingTo: 'Object')
		equals: classO
]

{ #category : #tests }
CNBFamixJavaClassTest >> testSuperClassA [
	"A Implements I2, Implements I3, inherits from parameterizedTypeE which has the parameterizableClassE"

	self assert: classA superClass equals: parameterizableClassE
]

{ #category : #tests }
CNBFamixJavaClassTest >> testSuperClassC [
	"C  extends B, 
		implements I1, 
		inherits parameterizedTypeD which contains parameterizableClassD which is an Interface"

	self assert: classC superClass equals: classB
]

{ #category : #tests }
CNBFamixJavaClassTest >> testSuperInheritances [

	"C  extends B, 
		implements I1, 
		inherits parameterizedTypeD which contains parameterizableClassD which is an Interface"

	self 
		assert: classC superInheritances size 
		equals: 3
]

{ #category : #tests }
CNBFamixJavaClassTest >> testSuperInheritancesWithoutInterfaces [
	"C  extends B, 
		implements I1, 
		inherits parameterizedTypeD which contains parameterizableClassD which is an Interface"

	self
		assert:
			((classC superInheritances collect: #target) reject: #isInterface)
				first
		equals: classB
]

{ #category : #tests }
CNBFamixJavaClassTest >> testSuperclassHierarchy [

	self
		assertCollection: (classC superclassHierarchy collect: #name)
		hasSameElements:
			#( 'classB' 'classI1' 'parameterizedTypeD' 'classA' 'classI2'
			   'classI3' 'parameterizedTypeE' 'parameterizableClassE'
			   'classO' 'Object' 'parameterizableClassD' )
]

{ #category : #tests }
CNBFamixJavaClassTest >> testSuperclassHierarchyRoot [

	self
		assert: (classC rootAccordingTo: 'Object')
		equals:
			((classC superclassHierarchy select: #isClass) reject: #isInterface)
				reversed second "First should be Object"
]

{ #category : #tests }
CNBFamixJavaClassTest >> testSuperclassHierarchyWithoutInterfaces [

	self
		assertCollection:
			((classC superclassHierarchy reject: #isInterface) collect: #name)
				asArray
		hasSameElements:
			#( 'classB' 'parameterizedTypeD' 'classA' 'parameterizedTypeE'
			   'parameterizableClassE' 'classO' 'Object' )
]

{ #category : #tests }
CNBFamixJavaClassTest >> testSuperclasses [

	self
		assert:
			(((classC superclassHierarchy select: #isClass) reject:
				  #isInterface) collect: #name) asArray
		equals:
		#( 'classB' 'classA' 'parameterizableClassE' 'classO' 'Object' )
]
