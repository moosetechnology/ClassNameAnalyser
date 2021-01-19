Class {
	#name : #DMBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'DMBuilder-Tests'
}

{ #category : #running }
DMBuilderTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
	builder := DMBuilder new
]

{ #category : #tests }
DMBuilderTest >> testAttribueColor [
]

{ #category : #tests }
DMBuilderTest >> testBuildPackageModels [
| model packageModels cnb |

	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		doNotRunCandidateOperator;
		importingContext:
			(MooseImportingContext new
			   mergeClassAndMetaclass;
				importClass;
				importInheritance ; 
				importPackage);
		model: model;
		addFromPackagesMatching: [:p | 'Moose-*' match: p name];
		run.
		cnb := DMClassNamesblueprint new
			model: model;
			motherRoot: Object.
	packageModels := DMBuilder doPackageModelsOf: cnb viewModel.
	self assert: (packageModels size) equals: (model packages size).
	self assert: (packageModels flatCollect: #classModels) size equals: model numberOfModelClasses 

]

{ #category : #tests }
DMBuilderTest >> testBuildRootModels [
| model packageModels cnb |

	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		doNotRunCandidateOperator;
		importingContext:
			(MooseImportingContext new
			   mergeClassAndMetaclass;
				importClass;
				importInheritance ; 
				importPackage);
		model: model;
		addFromPackagesMatching: [:p | 'Moose-*' match: p name];
		run.
		cnb := DMClassNamesblueprint new
			model: model;
			motherRoot: Object;
			startBuilding.
	packageModels := DMBuilder doPackageModelsOf: cnb viewModel.
	self assert: ((DMBuilder buildRootsOf: (packageModels flatCollect: #classModels) Accordingto: cnb viewModel motherRoot) collect: #name) asSet equals: (cnb rootModels collect: #name)

]

{ #category : #'as yet unclassified' }
DMBuilderTest >> testClassModelAccordingTo [
	self assert: (MoosePharoImporterTask classModelAccordingTo: Object) root equals: MooseTask.
	self assert: (MoosePharoImporterTask classModelAccordingTo: MooseTask) root equals: MooseAbstractImporter.
	self assert: (MoosePharoImporterTask classModelAccordingTo: MooseAbstractImporter) root equals: MooseImportingTask
]

{ #category : #tests }
DMBuilderTest >> testCreateSuffixesDictionary [

	| model packageModels cnb |

	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		doNotRunCandidateOperator;
		importingContext:
			(MooseImportingContext new
			   mergeClassAndMetaclass;
				importClass;
				importInheritance ; 
				importPackage);
		model: model;
		addFromPackagesMatching: [:p | 'Moose-*' match: p name];
		run.
		cnb := DMClassNamesblueprint new
			model: model;
			motherRoot: Object.
	packageModels := DMBuilder doPackageModelsOf: cnb viewModel.
	self assert: (DMBuilder createSuffixesDictionaryFrom: (packageModels flatCollect: #classModels)) keys asSet equals: ((packageModels flatCollect: #classModels) collect: #concept) asSet

]

{ #category : #tests }
DMBuilderTest >> testSortRootModels [
	| rm1 rm2 rm3 rm4 rm5 rm6 c |
	rm1 := DMRootModel new name: 'rm1';size: 3.
	rm2 := DMRootModel new name: 'rm2';size: 0.
	rm3 := DMRootModel new name: 'rm3';size: 4.
	rm4 := DMRootModel new name: 'rm4';size: 2.
	rm5 := DMRootModel new name: 'rm5';size: 7.
	rm6 := DMRootModel new name: 'rm6';size: 0.
	c := { rm1 . rm2 . rm3 . rm4 . rm5 . rm6 } asSet.
	self assert: (builder sortRootModels: c) asSet equals: { rm5 . rm3. rm1 . rm4 . rm2 . rm6} asSet
]

{ #category : #tests }
DMBuilderTest >> testStartBuilding [
| model packageModels cnb |

	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		doNotRunCandidateOperator;
		importingContext:
			(MooseImportingContext new
			   mergeClassAndMetaclass;
				importClass;
				importInheritance ; 
				importPackage);
		model: model;
		addFromPackagesMatching: [:p | 'Moose-*' match: p name];
		run.
		cnb := DMClassNamesblueprint new
			model: model;
			motherRoot: Object.
		cnb startBuilding.
]

{ #category : #'as yet unclassified' }
DMBuilderTest >> testbuildConceptViewModels [
	""
	| mooseSample mooseModel conceptualModel conceptViewModels |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion5) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	builder buildRootModelsFrom: conceptualModel.
	conceptViewModels := builder doConceptViewModelsOf: (conceptualModel allClassModels collect: #concept) using: (conceptualModel models atRandom) classModels.
	self assert: (conceptViewModels collect: #color) equals: {#red} asSet
]

{ #category : #'as yet unclassified' }
DMBuilderTest >> testbuildViewModel [
	| aConceptualModel aViewModel model class package |

	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		doNotRunCandidateOperator;
		importingContext:
			(MooseImportingContext new
			   mergeClassAndMetaclass;
				importClass;
				importInheritance ; 
				importPackage;
		model: model;
		addFromPackagesMatching: [:p | 'Moose-*' match: p name];
		run).
	aViewModel := DMBuilder do: model.
	self assert: (aViewModel allClassNames collect: #root) equals: (aViewModel rootModels collect: #name)
]
