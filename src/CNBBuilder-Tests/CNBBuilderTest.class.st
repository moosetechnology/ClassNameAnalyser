Class {
	#name : #CNBBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder',
		'mooseMooseModel',
		'calypsoMooseModel',
		'calypsoCNB',
		'mooseCNB'
	],
	#category : #'CNBBuilder-Tests'
}

{ #category : #running }
CNBBuilderTest >> setUp [

	super setUp.

	mooseMooseModel := CNBModelGenerator projectNameMatches: 'Moose*-'.
	mooseCNB := ClassNamesBlueprint new
		            model: mooseMooseModel;
		            startBuilding.

	calypsoMooseModel := CNBModelGenerator projectNameMatches:
		                     'Calypso*-'.
	calypsoCNB := ClassNamesBlueprint new
		              model: calypsoMooseModel;
		              startBuilding
]

{ #category : #tests }
CNBBuilderTest >> testBuildPackageViewModels [

	| expectedConcepts |
	self
		assert: (mooseCNB viewModel packageViewModels collectAsSet: #name)
		equals: (mooseMooseModel allModelPackages collectAsSet: #name).

	expectedConcepts := mooseMooseModel allModelClasses collectAsSet: [
		                    :each |
		                    (each classModelAccordingTo: CNBSettings new)
			                    suffix ].
	self
		assertCollection:
			(mooseCNB viewModel packageViewModels flatCollectAsSet: [ :pckg |
				 pckg tokenViewModels collect: #name ])
		hasSameElements: expectedConcepts
]

{ #category : #tests }
CNBBuilderTest >> testBuildRootModels [

	| expectedRoots actualRoots |
	expectedRoots := mooseMooseModel allModelClasses collectAsSet: [ :cls |
		                 (cls rootAccordingTo: Object) name ].

	actualRoots := (mooseCNB viewModel rootModels collect: #name) asSet.

	self assertCollection: actualRoots includesAll: expectedRoots
]

{ #category : #tests }
CNBBuilderTest >> testClassModels [

	self
		assertCollection:
			(mooseCNB viewModel packageModels flatCollectAsSet: [ :pckgModel |
				 pckgModel classModels collect: #name ])
		hasSameElements:
		(mooseMooseModel allModelClasses collectAsSet: #name).

	self
		assertCollection:
			(calypsoCNB viewModel packageModels flatCollectAsSet: [ :pckgModel |
				 pckgModel classModels collect: #name ])
		hasSameElements:
			(calypsoMooseModel allModelPackages flatCollectAsSet: [ :pckg |
				 pckg classes collect: #name ])
]

{ #category : #tests }
CNBBuilderTest >> testClassType [

	| aMonoClass aMonoSuffixHierarchy aMultiSuffixHierarchy monoSuffixType multiSuffixType monoClassType |
	monoClassType := CNBClassType monoClass.
	monoSuffixType := CNBClassType monoToken.
	multiSuffixType := CNBClassType multiToken.
	aMonoSuffixHierarchy := mooseCNB viewModel rootModels detect: [ :each |
		                        each isMonoToken ].
	aMultiSuffixHierarchy := mooseCNB viewModel rootModels detect: [
		                         :each | each isMultiToken ].
	aMonoClass := mooseCNB viewModel rootModels detect: [ :each |
		              each isMonoClass ].
	self
		assert: (CNBClassType with: aMonoClass subclasses) type
		equals: monoClassType.
	self
		assert: (CNBClassType with: aMonoSuffixHierarchy subclasses) type
		equals: monoSuffixType.
	self
		assert: (CNBClassType with: aMultiSuffixHierarchy subclasses) type
		equals: multiSuffixType
]

{ #category : #tests }
CNBBuilderTest >> testPackageModels [

	self
		assert: (mooseCNB viewModel packageModels collectAsSet: #name)
		equals: (mooseMooseModel allModelPackages collectAsSet: #name).

	self
		assert: (calypsoCNB viewModel packageModels collectAsSet: #name)
		equals: (calypsoMooseModel allModelPackages collectAsSet: #name)
]

{ #category : #tests }
CNBBuilderTest >> testSortRootModels [

	| rm1 rm2 rm3 rm4 rm5 rm6 c |
	rm1 := CNBRootModel new name: 'rm1';
		       subclasses: (Array new: 3 withAll: CNBClassModel new).
	rm2 := CNBRootModel new name: 'rm2';
		       subclasses: Array new.
	rm3 := CNBRootModel new name: 'rm3';
		       subclasses: (Array new: 4 withAll: CNBClassModel new).
	rm4 := CNBRootModel new name: 'rm4';
		       subclasses: (Array new: 2 withAll: CNBClassModel new).
	rm5 := CNBRootModel new name: 'rm5';
		       subclasses: (Array new: 7 withAll: CNBClassModel new).
	rm6 := CNBRootModel new name: 'rm6';
		       subclasses: Array new.

	c := { rm1. rm2. rm3. rm4. rm5. rm6 }.

	self assertCollection: (CNBBuilder new sortRootModels: c) 
		equals: { rm5. rm3. rm1. rm4. rm2. rm6 }
]
