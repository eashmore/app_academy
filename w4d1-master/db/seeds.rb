s = User.create!(username: 'scott')
e = User.create!(username: 'eric')
three = User.create!(username: 'anonymous')

sc = Contact.create!(name: 'eric', email: 'wahtever', user_id: s.id)
ec = Contact.create!(name: 'scott', email: 'something', user_id: e.id)
nothing = Contact.create!(name: "luther", email: 'nothign', user_id: 3)

conshar = ContactShare.create!(user_id: s.id, contact_id: ec.id)
