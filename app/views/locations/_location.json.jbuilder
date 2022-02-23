json.extract! location, :id, :name

json.sgid location.attachable_sgid
json.content render(partial: 'locations/location', locals: {location: location}, formats: [:html])