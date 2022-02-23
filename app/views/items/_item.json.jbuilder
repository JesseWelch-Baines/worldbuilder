json.extract! item, :id, :name

json.sgid item.attachable_sgid
json.content render(partial: 'items/item', locals: {item: item}, formats: [:html])