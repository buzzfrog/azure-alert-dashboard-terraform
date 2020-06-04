{
  "lenses": {
    "0": {
      "order": 0,
      "parts": {
        "0": {
          "position": {
            "x": 0,
            "y": 0,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "sharedTimeRange",
                "isOptional": true
              },
              {
                "name": "options",
                "value": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${appservice_id}"
                        },
                        "name": "BytesReceived",
                        "aggregationType": 1,
                        "metricVisualization": {
                          "displayName": "Data In",
                          "resourceDisplayName": "${appservice_name}"
                        }
                      }
                    ],
                    "title": "Data In",
                    "titleKind": 2,
                    "visualization": {
                      "chartType": 2
                    },
                    "openBladeOnClick": {
                      "openBlade": true
                    }
                  }
                },
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${appservice_id}"
                        },
                        "name": "BytesReceived",
                        "aggregationType": 1,
                        "metricVisualization": {
                          "displayName": "Data In",
                          "resourceDisplayName": "${appservice_name}"
                        }
                      }
                    ],
                    "title": "Data In",
                    "titleKind": 2,
                    "visualization": {
                      "chartType": 2,
                      "disablePinning": true
                    },
                    "openBladeOnClick": {
                      "openBlade": true
                    }
                  }
                }
              }
            },
            "filters": {
              "MsPortalFx_TimeRange": {
                "model": {
                  "format": "local",
                  "granularity": "1m",
                  "relative": "60m"
                }
              }
            }
          }
        },
        "1": {
          "position": {
            "x": 0,
            "y": 4,
            "colSpan": 6,
            "rowSpan": 4
          },
          "metadata": {
            "inputs": [
              {
                "name": "sharedTimeRange",
                "isOptional": true
              },
              {
                "name": "options",
                "value": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${sqldatabase_id}"
                        },
                        "name": "cpu_percent",
                        "aggregationType": 3,
                        "metricVisualization": {
                          "displayName": "CPU percentage",
                          "resourceDisplayName": "${sqldatabase_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${sqldatabase_id}"
                        },
                        "name": "physical_data_read_percent",
                        "aggregationType": 3,
                        "metricVisualization": {
                          "displayName": "Data IO percentage",
                          "resourceDisplayName": "${sqldatabase_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${sqldatabase_id}"
                        },
                        "name": "log_write_percent",
                        "aggregationType": 3,
                        "metricVisualization": {
                          "displayName": "Log IO percentage",
                          "resourceDisplayName": "${sqldatabase_name}"
                        }
                      }
                    ],
                    "title": "Compute utilization",
                    "titleKind": 2,
                    "visualization": {
                      "chartType": 2
                    },
                    "openBladeOnClick": {
                      "openBlade": true
                    }
                  }
                },
                "isOptional": true
              }
            ],
            "type": "Extension/HubsExtension/PartType/MonitorChartPart",
            "settings": {
              "content": {
                "options": {
                  "chart": {
                    "metrics": [
                      {
                        "resourceMetadata": {
                          "id": "${sqldatabase_id}"
                        },
                        "name": "cpu_percent",
                        "aggregationType": 3,
                        "metricVisualization": {
                          "displayName": "CPU percentage",
                          "resourceDisplayName": "${sqldatabase_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${sqldatabase_id}"
                        },
                        "name": "physical_data_read_percent",
                        "aggregationType": 3,
                        "metricVisualization": {
                          "displayName": "Data IO percentage",
                          "resourceDisplayName": "${sqldatabase_name}"
                        }
                      },
                      {
                        "resourceMetadata": {
                          "id": "${sqldatabase_id}"
                        },
                        "name": "log_write_percent",
                        "aggregationType": 3,
                        "metricVisualization": {
                          "displayName": "Log IO percentage",
                          "resourceDisplayName": "${sqldatabase_name}"
                        }
                      }
                    ],
                    "title": "Compute utilization",
                    "titleKind": 2,
                    "visualization": {
                      "chartType": 2,
                      "disablePinning": true
                    },
                    "openBladeOnClick": {
                      "openBlade": true
                    }
                  }
                }
              }
            },
            "filters": {
              "MsPortalFx_TimeRange": {
                "model": {
                  "format": "local",
                  "granularity": "auto",
                  "relative": "60m"
                }
              }
            }
          }
        }
      }
    }
  },
  "metadata": {
    "model": {
      "timeRange": {
        "value": {
          "relative": {
            "duration": 24,
            "timeUnit": 1
          }
        },
        "type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
      }
    }
  }
}