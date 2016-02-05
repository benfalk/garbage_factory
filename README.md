[![Build Status](https://travis-ci.org/benfalk/garbage_factory.svg?branch=master)](https://travis-ci.org/benfalk/garbage_factory)

# GarbageFactory

Tool to quickly model objects from a provided json-schema.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'garbage_factory'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install garbage_factory

## Usage

Let's assume you have a json schema file, saved as a yaml
file `schemas/flight.yml` that looks like this:

```yaml
title: Passenger Jet Flight
description: Models a commercial flight one might take
type: object
required:
  - airline_company
  - aircraft_model
  - origin_details
  - destination_details
properties:
  airline_company:
    title: Airline Company
    description: The buisness that runs the aircraft
    type: string
  aircraft_model:
    type: object
    properties:
      max_distance:
        type: integer
      max_passengers:
        type: integer
  origin_details:
    $ref: '#/definitions/location_details'
  destination_details:
    $ref: '#/definitions/location_details'
definitions:
  location_details:
    title: Location Details
    description: |
      Describes where a customer boards or leaves a flight,
      both by location and time
    type: object
    properties:
      gate_number:
        type: string
      time:
        type: string
      airport:
        type: string
      country:
        type: string
      city:
        type: string
```

You can do the following:

```ruby
class Flight
  GarbageFactory.model 'schemas/flight.yml'
end

flight = Flight.new airline_company: 'Delta',
                    aircraft_model: {
                      max_distance: 500,
                      max_passengers: 120
                    }

flight.airline_company #=> "Delta"
flight.origin_details.airport #=> nil
flight.origin_details.airport = "FWA"
flight.origin_details.airport #=> "FWA"
```

You can also pick out a definition from a schema:

```ruby
class LocationDetail
  GarbageFactory.model 'schemas/flight.yml', at: '#/definitions/location_details'

  def to_s
    "#{city},#{country} #{airport}:#{gate_number} @#{time}"
  end
end
```

And then use it as an override in another:
```ruby
class BetterFlight
  include GarbageFactory.model flight, override: { '#/definitions/location_details' => LocationDetail }
end

flight = BetterFlight.new origin_details: {
                            city: "Fort Wayne",
                            country: "USA",
                            airport: "FWA",
                            gate_number: '6',
                            time: "07:15"
                          }
flight.origin_details.to_s #=> "Fort Wayne,USA FWA:6 @07:15"
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/garbage_factory/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
