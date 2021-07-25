Class {
	#name : #GeoOPUserStatusConfirmedDriver,
	#superclass : #GeoOPUserStatusParticipating,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPUserStatusConfirmedDriver class >> statusSymbol [

	^#confirmedSchedulingDriver
]

{ #category : #accessing }
GeoOPUserStatusConfirmedDriver class >> userStatusString [

	^'Bevestigd Chauffeur'
]

{ #category : #accessing }
GeoOPUserStatusConfirmedDriver >> color [


	^Color blue darker
]

{ #category : #testing }
GeoOPUserStatusConfirmedDriver >> isConfirmed [

	^true
]

{ #category : #testing }
GeoOPUserStatusConfirmedDriver >> isConfirmedDriver [

	^true
]

{ #category : #accessing }
GeoOPUserStatusConfirmedDriver >> nextAdminStatusesOn: coll [
	coll
		add: self iCannotStatus
]

{ #category : #accessing }
GeoOPUserStatusConfirmedDriver >> nextAdminStatusesOn: coll user: aUser [
	coll
		add: self iCannotStatus
]

{ #category : #'accessing schedule' }
GeoOPUserStatusConfirmedDriver >> scheduleImageClosed [

	^'/resources/20_kar.png'
]

{ #category : #'accessing schedule' }
GeoOPUserStatusConfirmedDriver >> scheduleImageFinished [

	^'/resources/20_kar_finished.png'
]

{ #category : #'accessing schedule' }
GeoOPUserStatusConfirmedDriver >> scheduleImageOpen [

	^'/resources/20_kar.png'
]

{ #category : #accessing }
GeoOPUserStatusConfirmedDriver >> userButtonString [

	^'Bevestigen Chauffeur'
]
