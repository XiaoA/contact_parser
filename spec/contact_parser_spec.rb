require "spec_helper"

RSpec.describe ContactParser do
  it "has a version number" do
    expect(ContactParser::VERSION).not_to be nil
  end

  it "parses contacts" do
    contacts =
      [
        "John Doe <john@example.com>",
        "Duffy Duck <duffy@duck.io>",
        "Billy <billy@boo.mail.com>"
      ].join(",")

    expect(ContactParser.new(contacts).bulk_parse).to eq(
      accepted: [
        {
          email: "john@example.com",
          first_name: "John",
          last_name: "Doe"
        }, {
          email: "duffy@duck.io",
          first_name: "Duffy",
          last_name: "Duck"
        }, {
          email: "billy@boo.mail.com",
          first_name: "Billy",
          last_name: "Billy"
        }
      ],
      rejected: []
    )
  end

  it "rejects contacts with invalid email" do
    contacts =
      [
        "John Doe <john@example.com>",
        "Duffy Duck <duffy@duck>",
        "Billy Boo <billy@boo.mail.com>"
      ].join(",")

    expect(ContactParser.new(contacts).bulk_parse).to eq(
      accepted: [
        {
          email: "john@example.com",
          first_name: "John",
          last_name: "Doe"
        }, {
          email: "billy@boo.mail.com",
          first_name: "Billy",
          last_name: "Boo"
        }
      ],
      rejected: ["Duffy Duck duffy@duck"]
    )
  end

  it "handles missing contacts" do
    contacts =
      [
        "John Doe <john@example.com>",
        "Billy Boo <billy@boo.mail.com>"
      ].join(",,")

    expect(ContactParser.new(contacts).bulk_parse).to eq(
      accepted: [
        {
          email: "john@example.com",
          first_name: "John",
          last_name: "Doe"
        }, {
          email: "billy@boo.mail.com",
          first_name: "Billy",
          last_name: "Boo"
        }
      ],
      rejected: []
    )
  end

  it "handles line breaks between contacts" do
    contacts =
      [
        "John Doe <john@example.com>",
        "Billy Boo <billy@boo.mail.com>"
      ].join(",\n\n")

    expect(ContactParser.new(contacts).bulk_parse).to eq(
      accepted: [
        {
          email: "john@example.com",
          first_name: "John",
          last_name: "Doe"
        }, {
          email: "billy@boo.mail.com",
          first_name: "Billy",
          last_name: "Boo"
        }
      ],
      rejected: []
    )
  end
end
