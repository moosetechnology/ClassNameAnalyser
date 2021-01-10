Class {
	#name : #DMNameAbbreviationCreatorTest,
	#superclass : #TestCase,
	#instVars : [
		'abbreviationcreator'
	],
	#category : #'DMFeatureSelector-Tests'
}

{ #category : #running }
DMNameAbbreviationCreatorTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	abbreviationcreator := DMNameAbbreviationCreator new

]

{ #category : #tests }
DMNameAbbreviationCreatorTest >> testAbbreviateUntil [

	self assert: (abbreviationcreator abbreviate: 'DMClassNamesBlueprintTestAbbreviateUntil' until: 3) equals: 'DCNBlueprintTestAbbreviateUntil'
	

]

{ #category : #tests }
DMNameAbbreviationCreatorTest >> testDevideUntil [
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
