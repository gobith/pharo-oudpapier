Class {
	#name : #GeoOPUserWebsiteRole,
	#superclass : #Object,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPUserWebsiteRole class >> fromString: aString [ 
	
	
	^(self subclasses detect: [ : cls | cls roleString = aString ] ifNone: [ GeoOPUserWebsiteNormalRole  ]) new
]

{ #category : #accessing }
GeoOPUserWebsiteRole class >> roleClasses [

	^{GeoOPUserWebsiteNormalRole . GeoOPUserWebsiteAdminRole  }
]

{ #category : #accessing }
GeoOPUserWebsiteRole class >> roleString [

	^self subclassResponsibility 
]

{ #category : #testing }
GeoOPUserWebsiteRole >> isAdmin [

	^false
]
