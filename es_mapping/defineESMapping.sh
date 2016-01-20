curl -XPUT 'http://localhost:9200/biodiversity/' -d '
{
	"index": {
		"analysis": {
			"filter": {
				"nGram_filter": {
					"type": "nGram",
					"min_gram": 2,
					"max_gram": 20,
					"token_chars": [
						"letter",
						"digit",
						"punctuation",
						"symbol"
					]
				},
				"snowball_spanish": {
					"type": "snowball",
					"language": "Spanish"
				},
				"stopwords": {
					"type": "stop",
					"stopwords": "_spanish_"
				},
				"worddelimiter": {
					"type": "word_delimiter"
				},
				"my_shingle_filter": {
					"type": "shingle",
					"min_shingle_size": "2",
					"max_shingle_size": "5",
					"output_unigrams": "false",
					"output_unigrams_if_no_shingles": "false"
				},
				"my_ascii_folding": {
					"type" : "asciifolding",
					"preserve_original": true
				},
				"spanish_stop": {
          "type": "stop",
          "stopwords": "_spanish_"
        },
        "spanish_stemmer": {
          "type": "stemmer",
          "language": "light_spanish"
        }
			},
			"analyzer": {
				"nGram_analyzer": {
					"type": "custom",
					"tokenizer": "whitespace",
					"filter": [
						"lowercase",
						"asciifolding",
						"nGram_filter"
					]
				},
				"whitespace_analyzer": {
					"type": "custom",
					"tokenizer": "whitespace",
					"filter": [
						"lowercase",
						"asciifolding"
					]
				},
				"spanish": {
					"type": "custom",
					"tokenizer": "standard",
					"filter": ["lowercase", "stopwords", "my_ascii_folding", "snowball_spanish", "worddelimiter"]
				},
				"spanish_search_analyzer": {
          "tokenizer": "standard",
          "filter": [
            "lowercase",
            "spanish_stop",
            "my_ascii_folding",
            "snowball_spanish"
          ]
        },
				"my_shingle_analyzer": {
					"type": "custom",
					"tokenizer": "standard",
					"filter": ["lowercase", "my_shingle_filter"]
				},
				"string_lowercase": {
					"tokenizer": "keyword",
					"filter": ["lowercase"]
				}
			}
		}
	}
}'

curl -XPUT 'http://localhost:9200/biodiversity/_mapping/catalog' -d '
{
	"catalog":  {
		"properties": {
			"catalogoEspeciesId": {
				"type": "long"
			},
			"fechaActualizacion": {
				"type": "date"
			},
			"fechaElaboracion": {
				"type": "date"
			},
			"tituloMetadato": {
				"type": "string",
				"index": "not_analyzed"
			},
			"jerarquiaNombresComunes": {
				"type": "string",
				"index": "not_analyzed"
			},
			"active": {
				"type" : "integer"
			},
			"licenciaInfo": {
				"type": "string",
				"index": "analyzed",
				"fields" : {
					"untouched" : {
						"type": "string",
						"index": "not_analyzed"
					},
					"exactWords": {
						"type": "string",
						"analyzer": "string_lowercase"
					}
				}
			},
			"taxonNombre": {
				"type": "string",
				"index": "analyzed",
				"analyzer": "spanish_search_analyzer",
				"fields" : {
					"untouched": {
						"type": "string",
						"index": "not_analyzed"
					},
					"exactWords": {
						"type": "string",
						"analyzer": "string_lowercase"
					},
					"spanish": {
						"type": "string",
						"analyzer": "spanish_search_analyzer"
					},
					"ngram": {
						"type": "string",
						"analyzer": "nGram_analyzer",
						"search_analyzer": "whitespace_analyzer"
					}
				}
			},
			"taxonCompleto": {
				"type": "string",
				"index": "analyzed",
				"analyzer": "spanish_search_analyzer",
				"fields" : {
					"untouched": {
						"type": "string",
						"index": "not_analyzed"
					},
					"exactWords": {
						"type": "string",
						"analyzer": "string_lowercase"
					},
					"spanish": {
						"type": "string",
						"analyzer": "spanish_search_analyzer"
					},
					"ngram": {
						"type": "string",
						"analyzer": "nGram_analyzer",
						"search_analyzer": "whitespace_analyzer"
					}
				}
			},
			"taxonomia": {
				"properties": {
					"reino": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"filo": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields" : {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"clase": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields" : {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"orden": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields" : {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"familia": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields" : {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"genero": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields" : {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"epitetoEspecifico": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields" : {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"especie": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields" : {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					}
				}
			},
			"paginaweb": {
				"type": "string",
				"index": "not_analyzed"
			},
			"autor": {
				"type": "string",
				"index": "analyzed",
				"analyzer": "spanish_search_analyzer",
				"fields": {
					"untouched": {
						"type": "string",
						"index": "not_analyzed"
					},
					"exactWords": {
						"type": "string",
						"analyzer": "string_lowercase"
					},
					"spanish": {
						"type": "string",
						"analyzer": "spanish_search_analyzer"
					}
				}
			},
			"verificacion": {
				"properties": {
					"email": {
						"type": "string",
						"index": "not_analyzed"
					},
					"emailResponsable": {
						"type": "string",
						"index": "not_analyzed"
					},
					"fecha": {
						"type": "date"
					},
					"estadoId": {
						"type": "long"
					},
					"nombre": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields" : {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							}
						}
					},
					"descripcion": {
						"type": "string",
						"index": "not_analyzed"
					},
					"validoInd": {
						"type": "boolean"
					}
				}
			},
			"citacion": {
				"properties": {
					"citacionId": {
						"type": "long"
					},
					"sistemaclasificacionInd": {
						"type": "boolean"
					},
					"fecha": {
						"type":   "date",
          	"format": "yyyy"
					},
					"documentoTitulo": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"autor": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"editor": {
						"type": "string",
						"index": "not_analyzed"
					},
					"publicador": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"editorial": {
						"type": "string",
						"index": "not_analyzed"
					},
					"lugarPublicacion": {
						"type": "string",
						"index": "not_analyzed"
					},
					"edicionVersion": {
						"type": "string",
						"index": "not_analyzed"
					},
					"volumen": {
						"type": "string",
						"index": "not_analyzed"
					},
					"serie": {
						"type": "string",
						"index": "not_analyzed"
					},
					"numero": {
						"type": "string",
						"index": "not_analyzed"
					},
					"paginas": {
						"type": "string",
						"index": "not_analyzed"
					},
					"hipervinculo": {
						"type": "string",
						"index": "not_analyzed"
					},
					"fechaActualizacion": {
						"type": "date"
					},
					"fechaConsulta": {
						"type": "date"
					},
					"otros": {
						"type": "string",
						"index": "not_analyzed"
					},
					"tipoId": {
						"type": "long"
					},
					"tipoNombre": {
						"type": "string",
						"index": "not_analyzed"
					},
					"tipoSuperiorInd": {
						"type": "boolean"
					},
					"tipoSerieSuperiorInd": {
						"type": "boolean"
					}
				}
			},
			"contacto": {
				"properties": {
					"contactoId": {
						"type": "long"
					},
					"direccion": {
						"type": "string",
						"index": "not_analyzed"
					},
					"telefono": {
						"type": "string",
						"index": "not_analyzed"
					},
					"acronimo": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"persona": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"fax": {
						"type": "string",
						"index": "not_analyzed"
					},
					"correoElectronico": {
						"type": "string",
						"index": "not_analyzed"
					},
					"organizacion": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"cargo": {
						"type": "string",
						"index": "not_analyzed"
					},
					"instrucciones": {
						"type": "string",
						"index": "not_analyzed"
					},
					"horaInicial": {
						"type": "date",
						"format": "HH:mm:ss"
					},
					"horaFinal": {
						"type": "date",
						"format": "HH:mm:ss"
					},
					"idReferenteGeografico": {
						"type": "long"
					},
					"poblacionDane": {
						"type": "string",
						"index": "not_analyzed"
					},
					"intruccionesAcceso": {
						"type": "string",
						"index": "not_analyzed"
					},
					"localidadHistorica": {
						"type": "string",
						"index": "not_analyzed"
					},
					"paisAbreviatura": {
						"type": "string",
						"index": "not_analyzed"
					},
					"paisNombre": {
						"type": "string",
						"index": "not_analyzed"
					},
					"subAbreviatura": {
						"type": "string",
						"index": "not_analyzed"
					},
					"subNombre": {
						"type": "string",
						"index": "not_analyzed"
					},
					"saDane": {
						"type": "string",
						"index": "not_analyzed"
					},
					"tipoSubId": {
						"type": "long"
					},
					"tipoSubNombre": {
						"type": "string",
						"index": "not_analyzed"
					},
					"ciudadMunicipioAbreviatura": {
						"type": "string",
						"index": "not_analyzed"
					},
					"ciudadMunicipioNombre": {
						"type": "string",
						"index": "not_analyzed"
					},
					"ciudadMunicipioDane": {
						"type": "string",
						"index": "not_analyzed"
					}
				}
			},
			"listaNombresComunes": {
				"type": "string",
				"index": "analyzed",
				"analyzer": "spanish_search_analyzer",
				"fields": {
					"untouched": {
						"type": "string",
						"index": "not_analyzed"
					},
					"exactWords": {
						"type": "string",
						"analyzer": "string_lowercase"
					},
					"spanish": {
						"type": "string",
						"analyzer": "spanish_search_analyzer"
					},
					"ngram": {
						"type": "string",
						"analyzer": "nGram_analyzer",
						"search_analyzer": "whitespace_analyzer"
					}
				}
			},
			"nombresComunes": {
				"type": "nested",
				"include_in_parent": true,
				"properties": {
					"tesauroId": {
						"type": "long"
					},
					"tesauroNombre": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"grupoHumano": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields" : {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"idioma": {
						"type": "string",
						"index": "not_analyzed"
					},
					"regionesGeograficas": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields" : {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"paginaWeb": {
						"type": "string",
						"index": "not_analyzed"
					},
					"tesauroCompleto": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields" : {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					}
				}
			},
			"distribucionGeografica": {
				"properties": {
					"departamentos": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							},
							"ngram": {
								"type": "string",
								"analyzer": "nGram_analyzer",
								"search_analyzer": "whitespace_analyzer"
							}
						}
					},
					"regionesNaturales": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							},
							"ngram": {
								"type": "string",
								"analyzer": "nGram_analyzer",
								"search_analyzer": "whitespace_analyzer"
							}
						}
					},
					"corporacionesAutonomasRegionales": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							},
							"ngram": {
								"type": "string",
								"analyzer": "nGram_analyzer",
								"search_analyzer": "whitespace_analyzer"
							}
						}
					},
					"organizaciones": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							},
							"ngram": {
								"type": "string",
								"analyzer": "nGram_analyzer",
								"search_analyzer": "whitespace_analyzer"
							}
						}
					}
				}
			},
			"imagenes": {
				"type": "nested",
				"include_in_parent": true,
				"properties": {
					"license": {
						"type": "string",
						"index": "not_analyzed"
					},
					"rights": {
						"type": "string",
						"index": "not_analyzed"
					},
					"rightsHolder": {
						"type": "string",
						"index": "not_analyzed"
					},
					"source": {
						"type": "string",
						"index": "not_analyzed"
					},
					"url": {
						"type": "string",
						"index": "not_analyzed"
					}
				}
			},
			"imagenesExternas": {
				"type": "nested",
				"include_in_parent": true,
				"properties": {
					"license": {
						"type": "string",
						"index": "not_analyzed"
					},
					"rights": {
						"type": "string",
						"index": "not_analyzed"
					},
					"rightsHolder": {
						"type": "string",
						"index": "not_analyzed"
					},
					"source": {
						"type": "string",
						"index": "not_analyzed"
					},
					"url": {
						"type": "string",
						"index": "not_analyzed"
					}
				}
			},
			"mapas": {
				"type": "string",
				"index": "not_analyzed"
			},
			"sonidos": {
				"type": "string",
				"index": "not_analyzed"
			},
			"videos": {
				"type": "string",
				"index": "not_analyzed"
			},
			"atributos": {
				"properties": {
					"estadoDeAmenazaSegunCategoriaUICNColombia": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"estadoDeAmenazaSegunCategoriaUICNMundo": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"distribucionGeograficaEnColombia": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"distribucionGeograficaEnMundo": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"distribucionAltitudinal": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"comportamiento": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"reproduccion": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"estadoActualPoblacion": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"estadoCITES": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"vocalizaciones": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"etimologiaNombreCientifico": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"habitat": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"habito": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"alimentacion": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"impactos": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"informacionAlerta": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"informacionTipos": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"informacionUsos": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"invasora": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"mecanismosControl": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"medidasConservacion": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"metadatos": {
						"type": "string",
						"index": "not_analyzed"
					},
					"origen": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"factoresAmenaza": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"descripcionInvasion": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"descripcionGeneral": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"descripcionTaxonomica": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"ecologia": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"ecosistema": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"clavesTaxonomicas": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"creditosEspecificos": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"otrosRecursosEnInternet": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"regionesNaturales": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"registrosBiologicos": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"sinonimos": {
						"type": "string",
						"index": "analyzed",
						"analyzer": "spanish_search_analyzer",
						"fields": {
							"untouched": {
								"type": "string",
								"index": "not_analyzed"
							},
							"exactWords": {
								"type": "string",
								"analyzer": "string_lowercase"
							},
							"spanish": {
								"type": "string",
								"analyzer": "spanish_search_analyzer"
							}
						}
					},
					"recursosMultimedia": {
						"type": "string",
						"index": "not_analyzed"
					},
					"autores": {
						"type": "nested",
						"include_in_parent": true,
						"properties": {
							"contactoId": {
								"type": "long"
							},
							"direccion": {
								"type": "string",
								"index": "not_analyzed"
							},
							"telefono": {
								"type": "string",
								"index": "not_analyzed"
							},
							"acronimo": {
								"type": "string",
								"index": "analyzed",
								"analyzer": "spanish_search_analyzer",
								"fields": {
									"untouched": {
										"type": "string",
										"index": "not_analyzed"
									},
									"exactWords": {
										"type": "string",
										"analyzer": "string_lowercase"
									},
									"spanish": {
										"type": "string",
										"analyzer": "spanish_search_analyzer"
									}
								}
							},
							"persona": {
								"type": "string",
								"index": "analyzed",
								"analyzer": "spanish_search_analyzer",
								"fields": {
									"untouched": {
										"type": "string",
										"index": "not_analyzed"
									},
									"exactWords": {
										"type": "string",
										"analyzer": "string_lowercase"
									},
									"spanish": {
										"type": "string",
										"analyzer": "spanish_search_analyzer"
									}
								}
							},
							"fax": {
								"type": "string",
								"index": "not_analyzed"
							},
							"correoElectronico": {
								"type": "string",
								"index": "not_analyzed"
							},
							"organizacion": {
								"type": "string",
								"index": "analyzed",
								"analyzer": "spanish_search_analyzer",
								"fields": {
									"untouched": {
										"type": "string",
										"index": "not_analyzed"
									},
									"exactWords": {
										"type": "string",
										"analyzer": "string_lowercase"
									},
									"spanish": {
										"type": "string",
										"analyzer": "spanish_search_analyzer"
									}
								}
							},
							"cargo": {
								"type": "string",
								"index": "not_analyzed"
							},
							"instrucciones": {
								"type": "string",
								"index": "not_analyzed"
							},
							"horaInicial": {
								"type": "date",
								"format": "HH:mm:ss"
							},
							"horaFinal": {
								"type": "date",
								"format": "HH:mm:ss"
							}
						}
					},
					"revisores": {
						"type": "nested",
						"include_in_parent": true,
						"properties": {
							"contactoId": {
								"type": "long"
							},
							"direccion": {
								"type": "string",
								"index": "not_analyzed"
							},
							"telefono": {
								"type": "string",
								"index": "not_analyzed"
							},
							"acronimo": {
								"type": "string",
								"index": "analyzed",
								"analyzer": "spanish_search_analyzer",
								"fields": {
									"untouched": {
										"type": "string",
										"index": "not_analyzed"
									},
									"exactWords": {
										"type": "string",
										"analyzer": "string_lowercase"
									},
									"spanish": {
										"type": "string",
										"analyzer": "spanish_search_analyzer"
									}
								}
							},
							"persona": {
								"type": "string",
								"index": "analyzed",
								"analyzer": "spanish_search_analyzer",
								"fields": {
									"untouched": {
										"type": "string",
										"index": "not_analyzed"
									},
									"exactWords": {
										"type": "string",
										"analyzer": "string_lowercase"
									},
									"spanish": {
										"type": "string",
										"analyzer": "spanish_search_analyzer"
									}
								}
							},
							"fax": {
								"type": "string",
								"index": "not_analyzed"
							},
							"correoElectronico": {
								"type": "string",
								"index": "not_analyzed"
							},
							"organizacion": {
								"type": "string",
								"index": "analyzed",
								"analyzer": "spanish_search_analyzer",
								"fields": {
									"untouched": {
										"type": "string",
										"index": "not_analyzed"
									},
									"exactWords": {
										"type": "string",
										"analyzer": "string_lowercase"
									},
									"spanish": {
										"type": "string",
										"analyzer": "spanish_search_analyzer"
									}
								}
							},
							"cargo": {
								"type": "string",
								"index": "not_analyzed"
							},
							"instrucciones": {
								"type": "string",
								"index": "not_analyzed"
							},
							"horaInicial": {
								"type": "date",
								"format": "HH:mm:ss"
							},
							"horaFinal": {
								"type": "date",
								"format": "HH:mm:ss"
							}
						}
					},
					"editores": {
						"type": "nested",
						"include_in_parent": true,
						"properties": {
							"contactoId": {
								"type": "long"
							},
							"direccion": {
								"type": "string",
								"index": "not_analyzed"
							},
							"telefono": {
								"type": "string",
								"index": "not_analyzed"
							},
							"acronimo": {
								"type": "string",
								"index": "analyzed",
								"analyzer": "spanish_search_analyzer",
								"fields": {
									"untouched": {
										"type": "string",
										"index": "not_analyzed"
									},
									"exactWords": {
										"type": "string",
										"analyzer": "string_lowercase"
									},
									"spanish": {
										"type": "string",
										"analyzer": "spanish_search_analyzer"
									}
								}
							},
							"persona": {
								"type": "string",
								"index": "analyzed",
								"analyzer": "spanish_search_analyzer",
								"fields": {
									"untouched": {
										"type": "string",
										"index": "not_analyzed"
									},
									"exactWords": {
										"type": "string",
										"analyzer": "string_lowercase"
									},
									"spanish": {
										"type": "string",
										"analyzer": "spanish_search_analyzer"
									}
								}
							},
							"fax": {
								"type": "string",
								"index": "not_analyzed"
							},
							"correoElectronico": {
								"type": "string",
								"index": "not_analyzed"
							},
							"organizacion": {
								"type": "string",
								"index": "analyzed",
								"analyzer": "spanish_search_analyzer",
								"fields": {
									"untouched": {
										"type": "string",
										"index": "not_analyzed"
									},
									"exactWords": {
										"type": "string",
										"analyzer": "string_lowercase"
									},
									"spanish": {
										"type": "string",
										"analyzer": "spanish_search_analyzer"
									}
								}
							},
							"cargo": {
								"type": "string",
								"index": "not_analyzed"
							},
							"instrucciones": {
								"type": "string",
								"index": "not_analyzed"
							},
							"horaInicial": {
								"type": "date",
								"format": "HH:mm:ss"
							},
							"horaFinal": {
								"type": "date",
								"format": "HH:mm:ss"
							}
						}
					},
					"colaboradores": {
						"type": "nested",
						"include_in_parent": true,
						"properties": {
							"contactoId": {
								"type": "long"
							},
							"direccion": {
								"type": "string",
								"index": "not_analyzed"
							},
							"telefono": {
								"type": "string",
								"index": "not_analyzed"
							},
							"acronimo": {
								"type": "string",
								"index": "analyzed",
								"analyzer": "spanish_search_analyzer",
								"fields": {
									"untouched": {
										"type": "string",
										"index": "not_analyzed"
									},
									"exactWords": {
										"type": "string",
										"analyzer": "string_lowercase"
									},
									"spanish": {
										"type": "string",
										"analyzer": "spanish_search_analyzer"
									}
								}
							},
							"persona": {
								"type": "string",
								"index": "analyzed",
								"analyzer": "spanish_search_analyzer",
								"fields": {
									"untouched": {
										"type": "string",
										"index": "not_analyzed"
									},
									"exactWords": {
										"type": "string",
										"analyzer": "string_lowercase"
									},
									"spanish": {
										"type": "string",
										"analyzer": "spanish_search_analyzer"
									}
								}
							},
							"fax": {
								"type": "string",
								"index": "not_analyzed"
							},
							"correoElectronico": {
								"type": "string",
								"index": "not_analyzed"
							},
							"organizacion": {
								"type": "string",
								"index": "analyzed",
								"analyzer": "spanish_search_analyzer",
								"fields": {
									"untouched": {
										"type": "string",
										"index": "not_analyzed"
									},
									"exactWords": {
										"type": "string",
										"analyzer": "string_lowercase"
									},
									"spanish": {
										"type": "string",
										"analyzer": "spanish_search_analyzer"
									}
								}
							},
							"cargo": {
								"type": "string",
								"index": "not_analyzed"
							},
							"instrucciones": {
								"type": "string",
								"index": "not_analyzed"
							},
							"horaInicial": {
								"type": "date",
								"format": "HH:mm:ss"
							},
							"horaFinal": {
								"type": "date",
								"format": "HH:mm:ss"
							}
						}
					},
					"referenciasBibliograficas": {
						"type": "nested",
						"include_in_parent": true,
						"properties": {
							"citacionId": {
								"type": "long"
							},
							"sistemaclasificacionInd": {
								"type": "boolean"
							},
							"fecha": {
								"type":   "date",
		          	"format": "yyyy"
							},
							"documentoTitulo": {
								"type": "string",
								"index": "analyzed",
								"analyzer": "spanish_search_analyzer",
								"fields": {
									"untouched": {
										"type": "string",
										"index": "not_analyzed"
									},
									"exactWords": {
										"type": "string",
										"analyzer": "string_lowercase"
									},
									"spanish": {
										"type": "string",
										"analyzer": "spanish_search_analyzer"
									}
								}
							},
							"autor": {
								"type": "string",
								"index": "analyzed",
								"analyzer": "spanish_search_analyzer",
								"fields": {
									"untouched": {
										"type": "string",
										"index": "not_analyzed"
									},
									"exactWords": {
										"type": "string",
										"analyzer": "string_lowercase"
									},
									"spanish": {
										"type": "string",
										"analyzer": "spanish_search_analyzer"
									}
								}
							},
							"editor": {
								"type": "string",
								"index": "not_analyzed"
							},
							"publicador": {
								"type": "string",
								"index": "analyzed",
								"analyzer": "spanish_search_analyzer",
								"fields": {
									"untouched": {
										"type": "string",
										"index": "not_analyzed"
									},
									"exactWords": {
										"type": "string",
										"analyzer": "string_lowercase"
									},
									"spanish": {
										"type": "string",
										"analyzer": "spanish_search_analyzer"
									}
								}
							},
							"editorial": {
								"type": "string",
								"index": "not_analyzed"
							},
							"lugarPublicacion": {
								"type": "string",
								"index": "not_analyzed"
							},
							"edicionVersion": {
								"type": "string",
								"index": "not_analyzed"
							},
							"volumen": {
								"type": "string",
								"index": "not_analyzed"
							},
							"serie": {
								"type": "string",
								"index": "not_analyzed"
							},
							"numero": {
								"type": "string",
								"index": "not_analyzed"
							},
							"paginas": {
								"type": "string",
								"index": "not_analyzed"
							},
							"hipervinculo": {
								"type": "string",
								"index": "not_analyzed"
							},
							"fechaActualizacion": {
								"type": "date"
							},
							"fechaConsulta": {
								"type": "date"
							},
							"otros": {
								"type": "string",
								"index": "not_analyzed"
							}
						}
					}
				}
			}
		}
	}
}'
