# ActivityProvider

Activity Provider for store data of education in LRS (Learning Record Store) based on xAPI specification https://github.com/adlnet/xAPI-Spec/blob/master/xAPI.md

## Caution

This is very raw version and can contains many bugs or feature absence. Please, use it on your own risk. Bug reports are welcome.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activity_provider'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activity_provider

## Usage

### Setup

First of all, specify LRS url:

```ruby
ActivityProvider.configure do |config|
  config.xapi_url = 'http://somehost/'
end
```

By default path of statement is `/statements`, but you can change it with your own:

```ruby
ActivityProvider.configure do |config|
  config.statement_path = '/other/statement/path'
end
```

### Save Statement

Actor, Verb and Object are mandatory. Other fields are optional.

```ruby
account = ActivityProvider::LRS::Account.new({
  home_page: 'http://somehost/users',
  name: 123456
})
identifier = ActivityProvider::LRS::Identifier.new(account: account)
actor = ActivityProvider::LRS::Member.new(identifier: identifier)
verb = ActivityProvider::LRS::Verb.new(verb: 'answered')

score = ActivityProvider::LRS::Score.new(raw: 100, min: 1, max: 100)

object = ActivityProvider::LRS::LRSObject.new(
  id: 'http://somehost/object/id'
)

result = ActivityProvider::LRS::Result.new(response: @user_answer_content.to_json.to_s,
                                           success: true, score: score)
context_activities = { parent: [{ id: "http://somehost/parent/id" }] }
context = ActivityProvider::LRS::Context.new(context_activities: context_activities)
statement_argumenets = { actor: actor, verb: verb, object: object,
                         context: context, result: result }
statement = ActivityProvider::LRS::Statement.new({
  actor: actor, verb: verb, object: object, context: context, result: result
})
statement.save # returns list of statements ids
```

If statement's `id` is present, then ActivityProvider send PUT request, otherwise it send POST.

You can send batch of statements:

```ruby
ActivityProvider.send_statements([statement1, statement2])
```

### Fetch Statement

```ruby
statement = ActivityProvider::LRS::Statement.find('da3b6ac8-02f1-4ad5-9d7e-a34bde57404e')
statement.actor # => ActivityProvider::LRS::Member
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lfidnl/activity_provider.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
