

# clone the repo
```bash
git clone git@github.com:javiergradiche/bowling.git  
```

# Pre-requisites to run
* ruby 2.6.5 (we recommend to use `rbenv` to install/manage different ruby versions)
* bundler
```bash
gem install bundler #to install bundler
```

## Run game:  
```bash
bundle install
ruby bowling.rb game FILE.txt
```

## Bonus
Integration tests added within the fixtures at 
`spec/game_spec.rb`

*Fixtures*

* spec/fixtures/test.1player-all-0.txt
* spec/fixtures/test.1player-all-10.txt
* spec/fixtures/test.1player-all-F.txt
* spec/fixtures/test.1player-all-open.txt
* spec/fixtures/test.1player-video.txt
* spec/fixtures/test.game-example.txt
* spec/fixtures/test.jeff-game-example.txt

## Run test:
```bash
bundle install
rspec
```

# Extra notes
* Using `thor` gem to simplify the input validations for cli
* Using `rspec` gem to manage tests