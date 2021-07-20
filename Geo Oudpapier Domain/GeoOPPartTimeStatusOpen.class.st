Class {
	#name : #GeoOPPartTimeStatusOpen,
	#superclass : #GeoOPPartTimeStatus,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPPartTimeStatusOpen >> buttonString [

	^'Open'
]

{ #category : #accessing }
GeoOPPartTimeStatusOpen >> nextStatus [

	^GeoOPPartTimeStatusClosed singleInstance
]

{ #category : #visiting }
GeoOPPartTimeStatusOpen >> scheduleImageFor: aStatus [

	^aStatus scheduleImageOpen
]

{ #category : #visiting }
GeoOPPartTimeStatusOpen >> scheduleStringFor: aStatus [

	^aStatus scheduleStringOpen
]

{ #category : #accessing }
GeoOPPartTimeStatusOpen >> statusString [

	^'Open'
	
]

{ #category : #accessing }
GeoOPPartTimeStatusOpen >> statusSymbol [

	^#open
]
