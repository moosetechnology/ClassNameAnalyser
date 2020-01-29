Extension { #name : #FamixStPackage }

{ #category : #'*DMModels' }
FamixStPackage >> classmodels [
	^self classes collect: [ :each | each classmodel ]
]

{ #category : #'*DMModels' }
FamixStPackage >> conceptualClassModels [ 
	^DMClassModelGroup new addAll: (self classmodels)
]

{ #category : #'*DMModels' }
FamixStPackage >> packagemodel [
	^DMPackageModel name: self name with: self conceptualClassModels  
]
