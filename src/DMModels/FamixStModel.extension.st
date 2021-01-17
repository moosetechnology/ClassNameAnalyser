Extension { #name : #FamixStModel }

{ #category : #'*DMModels' }
FamixStModel >> conceptualmodel [
	| packages |
	packages := (self allModelPackages ifNil: self allModelNamespaces) asMooseGroup.
	^ DMConceptualModel new
		name: self name;
		packagemodels: (DMBuilder doPackageModelsUsing: packages).
]
