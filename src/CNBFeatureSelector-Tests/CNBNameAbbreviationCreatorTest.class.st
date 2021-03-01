Class {
	#name : #CNBNameAbbreviationCreatorTest,
	#superclass : #TestCase,
	#instVars : [
		'abbreviationcreator'
	],
	#category : #'CNBFeatureSelector-Tests'
}

{ #category : #running }
CNBNameAbbreviationCreatorTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	abbreviationcreator := CNBNameAbbreviationCreator new

]

{ #category : #tests }
CNBNameAbbreviationCreatorTest >> testAbbreviateUntil [

	self assert: (abbreviationcreator abbreviate: 'DMClassNamesBlueprintTestAbbreviateUntil' until: 3) equals: 'DCNBlueprintTestAbbreviateUntil'
	

]

{ #category : #tests }
CNBNameAbbreviationCreatorTest >> testDevideUntil [
	self
		assert:
			(abbreviationcreator
				devide: {'DM' . 'Class' . 'Names' . 'Blueprint' . 'Test' . 'Devide' . 'Until'}
				until: 4)
		equals:
			(Array
				with: {'DM' . 'Class' . 'Names' . 'Blueprint'}
				with: {'Test' . 'Devide' . 'Until'})
]
