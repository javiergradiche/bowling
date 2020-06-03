

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

## Run test:
```bash
bundle install
rspec
```


# Extra notes
* Using `thor` gem to simplify the input validations for cli
* Using `rspec` gem to manage tests