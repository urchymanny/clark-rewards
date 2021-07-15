# Clark Coding Challenge

This application takes in an input of customers recommendations and acceptance and returns points which are different for each customer and is based on their invitees acceptance to their recommendations.

- Ruby version - `3.0.0`
- Dependencies
  - Rails
  - Byebug
  - RSpec
  - rexml
  - RSpec

## Installation

To run this project, I have created two options

- You need to install ruby, rails on your local machine and then run the rails console

  ```shell
  rails console
  ```

- You can make a post request with the input data to the provided url below

  ```shell
  curl -XPOST -H "Content-type: application/json" -d '{"data": "2018-06-12 09:41 A recommends B \n 2018-06-14 09:41 B accepts \n 2018-06-16 09:41 B recommends C \n 2018-06-17 09:41 C accepts \n 2018-06-19 09:41 C recommends D \n 2018-06-23 09:41 B recommends D \n 2018-06-25 09:41 D accepts"}' 'https://clark-rewards.herokuapp.com/rewards'
  ```

## Usage

To use this project in the rails console, follow the steps below;

First, we need to save the input in a variable

```ruby
data = "2018-06-12 09:41 A recommends B \n 2018-06-14 09:41 B accepts \n 2018-06-16 09:41 B recommends C \n 2018-06-17 09:41 C accepts \n 2018-06-19 09:41 C recommends D \n 2018-06-23 09:41 B recommends D \n 2018-06-25 09:41 D accepts"
```

Then, we want to initialize the Rewards module with the `input` data

```ruby
rewards = Rewards::Main.new(data)
```

This initializes a Main object class, to initialize the main object, a couple of classes run in the background to

- `Extract` customer from the input by looping through each line and selecting the customer's key `e.g "A" or "B"` also confirming who recommended which customer and when each customer accepts their recommendation.
- `Generate` customers from the extracted customer data. A typical customer has data including `key or name`, `parent or recommender`, `contract acceptance boolean`, `recommendation time`, `time of contract acceptance` and `points`

After initializing the Main object class, we proceed to run the method that rewards a customer's parent and ancestors

```ruby
rewards.perform
```

