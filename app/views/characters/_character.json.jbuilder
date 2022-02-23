json.extract! character, :id, :name

json.sgid character.attachable_sgid
json.content render(partial: 'characters/character', locals: {character: character}, formats: [:html])