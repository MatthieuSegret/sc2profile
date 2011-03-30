# sc2stats

Parses a Battle.net StarCraft 2 profile for name, 1v1 league and 1v1 league points.

## Usage

    p = SC2Stats.new("<profile url>")
    => <Name> (<League>, <Points> pts)

    p.name
    => <Name>

    p.league
    => <League>

    p.points
    => <Points>

A profile that has not yet been placed will return:

    <Name> (No league, 0 pts)

## Contributing to sc2stats
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== Copyright

Copyright (c) 2011 Julian Møller. See LICENSE.txt for
further details.

