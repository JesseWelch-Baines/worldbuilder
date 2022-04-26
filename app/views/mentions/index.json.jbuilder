json.array! @characters, partial: 'characters/character', as: :character
json.array! @locations, partial: 'locations/location', as: :location
json.array! @items, partial: 'items/item', as: :item
json.array! @events, partial: 'events/event', as: :event