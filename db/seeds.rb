def att_str(attachment)
  # attachment string
  "<action-text-attachment sgid='#{attachment.attachable_sgid}'></action-text-attachment>"
end

unless ENV['persist']
  WritableField.delete_all
  Document.delete_all
  Paragraph.delete_all
  Character.delete_all
  Location.delete_all
  Item.delete_all
  Event.delete_all
  WritableInstance.delete_all
  World.delete_all
  User.delete_all
  ActiveRecord::Base.connection.execute('DELETE FROM action_text_rich_texts')
end

user = User.create(email: 'j.welch.baines@gmail.com', password: 'test123')

worlds = World.create(
  [
    {user_id: user.id, name: 'The Nexus'},
    {user_id: user.id, name: 'The Parallel Lands'},
    {user_id: user.id, name: 'Klurratall'}
  ]
)

characters = Character.create(
  [
    {user_id: user.id, name: 'Traeliorn Aemaris', world_id: worlds.first.id},
    {user_id: user.id, name: 'Dervish', world_id: worlds.first.id},
    {user_id: user.id, name: 'Drundaull', world_id: worlds.first.id},
    {user_id: user.id, name: 'Stewards of the Raven', world_id: worlds.first.id},
  ]
)

locations = Location.create(
  [
    {user_id: user.id, name: 'Windmere Wharf', world_id: worlds.first.id},
    {user_id: user.id, name: 'Krovou', world_id: worlds.first.id},
    {user_id: user.id, name: 'The Ivory Horse', world_id: worlds.first.id},
  ]
)

items = Item.create(
  [
    {user_id: user.id, name: 'A Brief History of the Drazmak Clan', world_id: worlds.first.id},
  ]
)

documents = Document.create(
  [
    {user_id: user.id, name: 'Greenskins', world_id: worlds.first.id}
  ]
)

paragraphs = Paragraph.create(
  [
    {user_id: user.id, world_id: worlds.first.id, description: '-'},
    {user_id: user.id, world_id: worlds.first.id, description: '-'},
    {user_id: user.id, world_id: worlds.first.id, description: '-'},
    {user_id: user.id, world_id: worlds.first.id, description: '-'},
    {user_id: user.id, world_id: worlds.first.id, description: '-'},
  ]
)

writable_instances = WritableInstance.create(
  [
    {user_id: user.id, document_id: documents.first.id, writable_id: paragraphs[0].id, writable_type: "Paragraph", order: 0},
    {user_id: user.id, document_id: documents.first.id, writable_id: items[0].id, writable_type: "Item", order: 1},
    {user_id: user.id, document_id: documents.first.id, writable_id: paragraphs[1].id, writable_type: "Paragraph", order: 2},
    {user_id: user.id, document_id: documents.first.id, writable_id: paragraphs[2].id, writable_type: "Paragraph", order: 3},
    {user_id: user.id, document_id: documents.first.id, writable_id: paragraphs[3].id, writable_type: "Paragraph", order: 4},
    {user_id: user.id, document_id: documents.first.id, writable_id: paragraphs[4].id, writable_type: "Paragraph", order: 5},

  ]
)

writable_fields = WritableField.create(
  [
    {user_id: user.id, world_id: worlds.first.id, model: 'Character', name: 'Race'},
    {user_id: user.id, world_id: worlds.first.id, model: 'Location', name: 'Type'}
  ]
)

characters[0].update(
  description: "<div>Traeliorn is a loud upbeat half-elf bard, whom the party first encounter on the road to #{att_str(locations[0])}. A member of the #{att_str(characters[3])}.</div>",
  custom_field_values: {writable_fields[0].id => 'Half-elf'}
)
characters[1].update(description:
  "<div>A member of the #{att_str(characters[3])}. He met with #{att_str(characters[0])} in a bar in Windmere Wharf.</div>",
  custom_field_values: {writable_fields[0].id => 'Dwarf'}
)
characters[2].update(description:
  "<div>A member of the #{att_str(characters[3])}. He met with #{att_str(characters[0])} in a bar in Windmere Wharf.</div>",
  custom_field_values: {writable_fields[0].id => 'Half-orc'}
)
characters[3].update(description:
  "<div>A group of adventurers working in parallel to our party.</div>"
)

locations[0].update(description:
  "<div>A bustling seaside town.</div>",
  custom_field_values: {writable_fields[1].id => 'Town'}
)

locations[1].update(description:
  "<div>A small remote hamlet with an old-fashioned community.</div>",
  custom_field_values: {writable_fields[1].id => 'Village'}
)

locations[2].update(description:
  "<div>A bustling pub in #{att_str(locations[0])}. Attended mostly by dockhands and laborers.</div>",
  custom_field_values: {writable_fields[1].id => 'Tavern'}
)

items[0].update(description:
  "<div>A mostly peaceful clan who spent their formative years under the dominion of a cruel and fearsome hobgoblin tribe. Clan Drazmak delivered themselves from the tyranny many years later during a well conceived uprising by Grax drazmak, their current ruler.</div>"
)

paragraphs[0].update(description:
  "<div>Yourself a reasonably seasoned adventurer, you arrive in the town of #{att_str(locations[1])} following rumours of a job.
  You have your own reasons for seeking out quests of this nature, but this one in particular was of interest to you.
  It seems a local goblin clan has been kidnapping townsfolk from the surrounding areas.
  You arrive and naturally proceed to the local tavern, #{att_str(locations[2])}. Grab a drink and make yourself comfortable.</div>"
)

paragraphs[1].update(description:
  "<div>The party are hired to clear out a group of goblins and rescue the woman they find in there.
  She has allegedly been kidnapped by them.
  The town had been unable to venture into the goblin cave for fear of death but since that day they've heard strange occult whispers and been plagued with terrible dreams.
  They fear that the goblins may have sacrificed her.</div>"
)

paragraphs[2].update(description:
  "<div>All the goblins in the cave are under the woman's thrall and will attack on sight. At times they may seem confused or reluctant.
  This tribe is generally peaceful and only does these things out of coercion.
  Attempting to reason with them may make them pause for thought, but then they wince with pain and continue their assault.</div>"
)

paragraphs[3].update(description:
  "<div>The true king of the goblin colony is being held in a side room. He is tied up. If the party does not kill him he will speak to them.
  He is young. His father, the previous king, was killed to make an example. The younger goblin is too strong willed to be controlled by the woman.
  “The other goblins, they are a proud and decent race, but simple-minded.”</div>"
)

paragraphs[4].update(description:
  "<div>If Melixa is found in the back room she will be suspiciously unrestrained. Though she may feign her role as a prisoner,
  in reality she is completely in control of the goblins in the cave. “They must recognise my highborn blood and thus have treated me well.
  However I am still a prisoner and will no doubt be sacrificed in a matter of days.”</div>"
)