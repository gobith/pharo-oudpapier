Class {
	#name : #GeoOPUserStatusConfirmed,
	#superclass : #GeoOPUserStatusParticipating,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPUserStatusConfirmed class >> statusSymbol [

	^#confirmedScheduling
]

{ #category : #accessing }
GeoOPUserStatusConfirmed class >> userStatusString [

	^'Bevestigd'
]

{ #category : #accessing }
GeoOPUserStatusConfirmed >> color [


	^Color blue darker
]

{ #category : #testing }
GeoOPUserStatusConfirmed >> isConfirmed [

	^true
]

{ #category : #accessing }
GeoOPUserStatusConfirmed >> nextAdminStatusesOn: coll user: aUser [
	coll
		add: self iCannotStatus
]

{ #category : #accessing }
GeoOPUserStatusConfirmed >> scheduleStringClosed [
	^ 'v'
]

{ #category : #accessing }
GeoOPUserStatusConfirmed >> userButtonString [

	^'Bevestigen'
]
