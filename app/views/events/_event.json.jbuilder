json.extract! event, :id, :name

json.sgid event.attachable_sgid
json.content render(partial: 'events/event', locals: {event: event}, formats: [:html])