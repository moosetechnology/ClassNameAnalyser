Class {
	#name : #BaselineOfClassNameAnalyser,
	#superclass : #BaselineOf,
	#category : #BaselineOfClassNameAnalyser
}

{ #category : #baselines }
BaselineOfClassNameAnalyser >> baseline: spec [
	<baseline>
	spec for: #common do: [	
				
		"Packages"
		spec 
			package: 'DMFeatureSelector';
			package: 'DMFeatureSelector-Tests' with: [ spec requires: #('DMFeatureSelector'). ]].
]
