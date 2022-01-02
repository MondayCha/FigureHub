# Figure Hub Backend

Here mainly write problems I meet during developing a rails app.

## Zsh History
```shell
cd figurehub_backend
rails g model User name:string nickname:string type:integer token:string avatar:string password:digest
rails g model Origin name:string kind:integer info:text
rails g model Character name:string gender:integer info:text origin:references
rails g model Company name:string link:string
rails g model Figure name:string kind:integer price:decimal scale:string company:references
rails g model FigureCharacterAssociation figure:references character:references
rails db:migrate
bundle exec rspec.
```

## Rails Attribute Types

```
:binary
:boolean
:date
:datetime
:decimal
:float
:integer
:primary_key
:string
:text
:time
:timestamp
:hstore
:array
:cidr_address
:ip_address
:mac_address
```

## Rails HTTP Codes

https://apidock.com/rails/ActionController/Base/render#254-List-of-status-codes-and-their-symbols

## Rspec and Documentation Issues

1. Unable to gem Apitome: https://github.com/jejacks0n/apitome/issues/103
2. JSON Response is binary data: https://github.com/zipmark/rspec_api_documentation/issues/456

## Multiple references to a same table.

https://stackoverflow.com/questions/14867981/how-do-i-add-migration-with-multiple-references-to-the-same-model-in-one-table