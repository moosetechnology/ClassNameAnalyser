Extension { #name : #MooseAbstractGroup }

{ #category : #'*DMMooseClassNameBlueprint' }
MooseAbstractGroup >> allClassNamesBlueprint [
	<navigation: 'ClassNamesBlueprint'>
	
	| selectedPackages packageNames featureSelector conceptualModel builder viewModel roassalView|
	selectedPackages := self allPackages reject: [ :each | each isStub ].
	packageNames := selectedPackages collect: [ :each | each name ].
	featureSelector := DMFeatureSelector new.
	conceptualModel := featureSelector applyFeaturesOn: (packageNames asArray).
	builder := DMClassNamesBlueprintBuilder new.
	viewModel := builder buildModelFrom: conceptualModel.
	roassalView := DMRoassalClassNamesBlueprint new.
	^ self privateState cacheAt: 'u'
	ifAbsentPut: [  
			roassalView visualize: viewModel
			 ]
	
]
