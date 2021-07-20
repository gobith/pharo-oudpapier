Extension { #name : #Object }

{ #category : #'*Geo Oudpapier Domain' }
Object class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping | self neoJsonMappingOn: mapping ]
]

{ #category : #'*Geo Oudpapier Domain' }
Object class >> neoJsonMappingOn: mapping [
	
]
