Class {
	#name : #CNBPackagesListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'packagesList',
		'updateButton',
		'deleteAllButton'
	],
	#category : #CNBSpec
}

{ #category : #accessing }
CNBPackagesListPresenter class >> defaultExtent [
	^ 500 @ 500
]

{ #category : #specs }
CNBPackagesListPresenter class >> defaultSpec [ 

	^ (SpBoxLayout newVertical 
		spacing: 2;
		add: #packagesList;
		add: (SpBoxLayout newHorizontal
				add: #updateButton height: self buttonHeight;
				add: '';
				add: #deleteAllButton height: self buttonHeight;
				yourself) height: self buttonHeight; yourself
	)
]

{ #category : #accessing }
CNBPackagesListPresenter class >> defaultTitle [
	^ 'Selected Packages'
]

{ #category : #accessing }
CNBPackagesListPresenter class >> items: aCollection [

	^ self new 
		items: aCollection 
]

{ #category : #examples }
CNBPackagesListPresenter class >> open [
	<example>
	self new openWithSpec 
]

{ #category : #initialization }
CNBPackagesListPresenter >> connectPresenters [ 
	super connectPresenters.
	
	updateButton action: [ self onUpdateClicked  ].
	

				
				
]

{ #category : #accessing }
CNBPackagesListPresenter >> deleteAllButton [ 
	^ deleteAllButton 
]

{ #category : #initialization }
CNBPackagesListPresenter >> initializePresenters [
	super initializePresenters.
	
	packagesList 
		:= SpFilteringSelectableListPresenter new
				displayIcon: [ :e | self iconNamed: #package ];
				display: [ :package | package name ];
				yourself.
							
	packagesList 
			listPresenter 
				bindKeyCombination: $a meta 
				toAction: [ packagesList selectItems: packagesList items ].
				
	updateButton := self newButton label: 'Update'.
	deleteAllButton := self newButton label: 'Delete All'.
	
]

{ #category : #initialization }
CNBPackagesListPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class defaultExtent
]

{ #category : #'as yet unclassified' }
CNBPackagesListPresenter >> items: aCollection [

	packagesList 
		items: aCollection;
		selectItems: aCollection
]

{ #category : #'as yet unclassified' }
CNBPackagesListPresenter >> onUpdateClicked [ 

	packagesList items: packagesList selectedItems.
	packagesList listPresenter refresh
]

{ #category : #accessing }
CNBPackagesListPresenter >> packagesList [ 

	^ packagesList 
]

{ #category : #accessing }
CNBPackagesListPresenter >> updateButton [ 
	^ updateButton 
]
