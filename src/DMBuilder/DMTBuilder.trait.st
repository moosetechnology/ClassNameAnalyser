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
		(aModel class name = 'MooseModel')
		ifTrue: [  
	^ DMConceptualModel new
		name: aModel name;
		packagemodels:
			(msePackages
				collect: [ :eachPackage | 
					DMPackageModel new
						name: eachPackage name;
						classmodels: (eachPackage classes collect: [ :each | each classmodel ]) ])].
		(aModel class name ='FamixStModel')
		ifTrue: [ 
			^ DMConceptualModel new
		name: aModel name;
		packagemodels:
			(famixPackages
				collect: [ :eachPackage | 
					DMPackageModel new
						name: eachPackage name;
						classmodels: (eachPackage classes collect: [ :each | each classmodel ]) ])
			 ]
]
