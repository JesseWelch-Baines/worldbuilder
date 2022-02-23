combined_json = json.array! @characters, partial: 'characters/character', as: :character
combined_json += json.array! @locations, partial: 'locations/location', as: :location
combined_json += json.array! @items, partial: 'items/item', as: :item
combined_json += json.array! @events, partial: 'events/event', as: :event