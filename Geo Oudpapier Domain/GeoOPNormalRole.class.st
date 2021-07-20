Class {
	#name : #GeoOPNormalRole,
	#superclass : #GeoOPUserRole,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #'as yet unclassified' }
GeoOPNormalRole class >> roleName [

	^'Normaal'
]

{ #category : #'as yet unclassified' }
GeoOPNormalRole class >> roleString [

	^'normal'
]

{ #category : #testing }
GeoOPNormalRole >> isNormal [

	^true
]
