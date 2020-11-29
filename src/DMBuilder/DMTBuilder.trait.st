Trait {
	#name : #DMTBuilder,
	#traits : 'DMTColorAttributor',
	#classTraits : 'DMTColorAttributor classTrait',
	#category : #DMBuilder
}

{ #category : #building }
DMTBuilder >> buildConceptualModelFrom: aModel [
	| msePackages famixPackages |
	msePackages := (aModel allModelNamespaces
		ifEmpty: aModel allModelPackages) asMooseGroup.
	famixPackages := (aModel allModelPackages
		ifNil: aModel allModelNamespaces) asMooseGroup.
	aModel class name = 'MooseModel'
		ifTrue: [ ^ DMConceptualModel new
				name: aModel name;
				packagemodels:
					(msePackages
						collect: [ :eachPackage | 
							DMPackageModel new
								name: eachPackage name;
								classmodels: (eachPackage classes collect: [ :each | each classmodel ]) ]) ].
	aModel class name = 'FamixStModel'
		ifTrue: [ ^ DMConceptualModel new
				name: aModel name;
				packagemodels:
					(famixPackages
						collect: [ :eachPackage | 
							DMPackageModel new
								name: eachPackage name;
								classmodels: (eachPackage classes collect: [ :each | each classmodel ]) ]) ]
]

{ #category : #'as yet unclassified' }
DMTBuilder >> buildRootModelsFrom: aConceptualModel [
	| classmodels rootModels |
	self initialize.
	classmodels := self extractClassModelsFrom: aConceptualModel.
	rootModels := aConceptualModel hierarchies
		collect: [ :eachHierarchy | 
			DMRootModel new
				name: eachHierarchy name;
				subclasses: (classmodels select: [ :eachClass | eachClass root = eachHierarchy ]);
				type:
					(self
						classTypeWithSubclasses: (classmodels select: [ :eachClass | eachClass root = eachHierarchy ]));
				color:
					(self
						attributeColorByType:
							(self
								classTypeWithSubclasses: (classmodels select: [ :eachClass | eachClass root = eachHierarchy ]))) ].
	^ rootModels
]

{ #category : #'as yet unclassified' }
DMTBuilder >> classTypeWithSubclasses: anArrayOfClassModelsOfTheSameRoot [
	anArrayOfClassModelsOfTheSameRoot size = 1
		ifTrue: [ (anArrayOfClassModelsOfTheSameRoot at: 1) reference isTrait
				ifTrue: [ ^ #Trait ]
				ifFalse: [ (anArrayOfClassModelsOfTheSameRoot at: 1) root
						= (anArrayOfClassModelsOfTheSameRoot at: 1) reference
						ifTrue: [ ^ #monoClass ] ] ].
				
	((anArrayOfClassModelsOfTheSameRoot collect: [ :each | each concept ])
		asSet size = 1) & ((anArrayOfClassModelsOfTheSameRoot atRandom) concept = (DMFeatureSelector new extractConceptFrom: (anArrayOfClassModelsOfTheSameRoot atRandom) root name))
		ifTrue: [ ^ #monoSuffix ].
	^ #multiSuffix
]
