Extension { #name : #FamixStModel }

{ #category : #'*DMModels' }
FamixStModel >> conceptualmodel [
	^ DMConceptualModel new
		name: self name;
		packagemodels:
			((self allModelPackages ifNil: self allModelNamespaces) asMooseGroup
				collect: [ :eachPackage | 
					DMPackageModel new
						name: eachPackage name;
						classmodels: (eachPackage classes collect: [ :each | each classmodel ]) ])
]
