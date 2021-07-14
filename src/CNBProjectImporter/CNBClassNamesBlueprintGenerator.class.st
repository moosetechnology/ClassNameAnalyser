"
I generate a ClassNames Blueprint.
"
Class {
	#name : #CNBClassNamesBlueprintGenerator,
	#superclass : #Object,
	#category : #CNBProjectImporter
}

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> buildPharoProjects: aCollectionOfNames [ 

	^ aCollectionOfNames collect: [ :aProjectName | 			
		(ClassNamesBlueprint new
		model: (CNBModelGenerator projectNameMatches: aProjectName); withSuffix) startBuilding ]


]

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> buildProjects: aCollectionOfNames from: aPathDirectory [

	| setting | 
	setting := CNBSettings new token: #both; deleteInterfaces.
	^ aCollectionOfNames collect: [ :aProjectName | | mseFileName|
		mseFileName 
			:= (CNBFeatureSelector new removeAllDigitsAndSpecialCharsFrom: aProjectName), '.mse'.
			
		(ClassNamesBlueprint new
		model: (CNBModelGenerator 
		importProject: aPathDirectory,aProjectName,'/',mseFileName); 
		setting: setting) startBuilding ]


]

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> importProject: aPath [

	^ ClassNamesBlueprint new
		model: (CNBModelGenerator importProject: aPath)
]

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> importProject: aPath with: aModel [

	^ ClassNamesBlueprint new
		model: (CNBModelGenerator importProject: aPath with: aModel)
]

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> importProjects: aCollectionOfNames from: aPathDirectory [

	^ aCollectionOfNames collect: [ :aProjectName | | mseFileName|
		mseFileName := (CNBFeatureSelector new removeAllDigitsAndSpecialCharsFrom: aProjectName), '.mse'.
		ClassNamesBlueprint new
		model: (CNBModelGenerator importProject: aPathDirectory,aProjectName,'/',mseFileName ) ]


]

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> javaProjects [
	| names visus |
names := {
'619-guice' . 
'531-halo' . 
'2714-plantuml' . 
'5819-keycloak' . 
'570-DataX' . 
'246-wechat' . 
'2411-optaplanner' . 
'1689-jenkins' . 
'7395-sonarqube' . 
'571-arthas' . 
'549-javassist' . 
'319-baritone' . 
'1240-ExoPlayer' . 
'1036-maven' . 
'4523-orientdb' . 
'5045-j2objc' . 
'717-micrometer' . 
'2418-storm' . 
'598-osmdroid' . 
'3166-gobblin' . 
'464-conductor' . 
'11921-flink' . 
'213-jsonschema2pojo' . 
'4982-druid' . 
'1364-nacos' . 
'261-processing' . 
'1051-jadx' . 
'7528-spring-framework' . 
'1074-yacy_search_server' . 
'2967-mapstruct' . 
'2999-cassandra' . 
'5923-spring-boot' . 
'11259-hadoop' . 
'2863-pmd' . 
'2146-jpexs-decompiler' . 
'2949-pulsar' . 
'6925-geoserver' . 
'2410-dubbo' . 
'1110-lettuce-core' . 
'1165-byte-buddy' . 
'257-cryptomator' . 
'1619-jstorm' . 
'2819-Activiti' . 
'15238-elasticsearch' . 
'2783-spotbugs' . 
'1708-javaparser' . 
'1756-languagetool' . 
'7594-OpenSearch' . 
'3734-skywalking' . 
}.

visus := self buildProjects: names from: '/Users/nour/Desktop/newSelectedProjects/'.
CSVGenerator new generateAll: (visus collect: #analysisDescription) to: '/Users/nour/Desktop/final.csv'
]

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> packagesNamed: aCollection [ 

	^ ClassNamesBlueprint new
		model: (CNBModelGenerator packagesNamed: aCollection) 
]

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> pharoProjects [
	| projectsNames visus |
	projectsNames := { 
	'Bloc' .
	'Morphic'. 
	'Kernel'.
	'Spec2' .
	'Roassal3' .
	'Pillar' .
	'Collections' .
	'System' .
	'Math' .
	'OSWindow' .
	'PetitParser' .
	'Moose' .
	'Seaside3' 
	}.
	visus := projectsNames collect: [ :aProjectName | 			
		(ClassNamesBlueprint new
		model: (CNBModelGenerator projectNameMatches: aProjectName , '*'); withSuffix) startBuilding ].
	
	CSVGenerator new generateAll: (visus collect: #analysisDescription) to: '/Users/nour/Desktop/PharoProjects.csv'
]

{ #category : #'as yet unclassified' }
CNBClassNamesBlueprintGenerator class >> projectNameMatches: aString [ 

	^ ClassNamesBlueprint new
		model: (CNBModelGenerator projectNameMatches: aString) 
]
