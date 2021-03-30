Extension { #name : #SpFilteringSelectableListPresenter }

{ #category : #'*CNBSpec' }
SpFilteringSelectableListPresenter >> selectItem: anObject [

     self selectItems: (self selectedItems copyWith: anObject)
]

{ #category : #'*CNBSpec' }
SpFilteringSelectableListPresenter >> selectItems: aCollection [

    selectedItems := aCollection asSet.
    listPresenter selectItems: selectedItems asOrderedCollection
]
