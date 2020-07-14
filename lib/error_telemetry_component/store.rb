module ErrorTelemetryComponent
  class Store
    include EntityStore

    category 'error'
    entity Entity
    projection Projection
    reader MessageStore::Postgres::Read
  end
end
