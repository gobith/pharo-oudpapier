Class {
	#name : #GeoOPPartTimeStatusFinished,
	#superclass : #GeoOPPartTimeStatus,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPPartTimeStatusFinished >> buttonString [

	^'Voltooien'
]

{ #category : #testing }
GeoOPPartTimeStatusFinished >> isActive [

	^false
]

{ #category : #testing }
GeoOPPartTimeStatusFinished >> isFinished [

	^true
]

{ #category : #accessing }
GeoOPPartTimeStatusFinished >> nextStatus [

	^GeoOPPartTimeStatusArchived singleInstance
]

{ #category : #visiting }
GeoOPPartTimeStatusFinished >> scheduleImageFor: aStatus [

	^aStatus scheduleImageFinished
]

{ #category : #visiting }
GeoOPPartTimeStatusFinished >> scheduleStringFor: aStatus [

	^aStatus scheduleStringFinished
]

{ #category : #accessing }
GeoOPPartTimeStatusFinished >> statusString [

	^'Voltooid'
	
]

{ #category : #accessing }
GeoOPPartTimeStatusFinished >> statusSymbol [

	^#finished
]
