# Clark Coding Challenge

This application takes in an input of customers recommendations and acceptance and returns points which are different for each customer and is based on their invitees acceptance to their recommendations.

- Ruby version - `3.0.0`

## Installation

To run this project, I have created two options - to run the project in your `rails console` or make a http POST request and get formatted response as shown below:

You can make a `post` request to a version on `heroku` with the input data which would calculate the rewards and return a json response

```shell
curl -XPOST -H "Content-type: application/json" -d '{"data": "2018-06-12 09:41 A recommends B \n 2018-06-14 09:41 B accepts \n 2018-06-16 09:41 B recommends C \n 2018-06-17 09:41 C accepts \n 2018-06-19 09:41 C recommends D \n 2018-06-23 09:41 B recommends D \n 2018-06-25 09:41 D accepts"}' 'https://clark-rewards.herokuapp.com/rewards'
```

You can also make the request with a `txt file` containing the input:

```shell
curl --location --request POST 'https://clark-rewards.herokuapp.com/rewards/from/file' --form 'file=@"customer.txt"'
```

make sure to run this from the directory where the customer.txt file is saved on your local machine

The above would produce a response:

```json
{"A":1.75,"B":1.5,"C":1.0,"D":0.0}
```

## Usage

To use this project in the rails console, follow the steps below;

First, you need to install ruby, rails on your local machine. Navigate to the project directory and then run

```ruby
bundle install
```

Then, open the rails console by using

```ruby
rails console
```

Then, we need to save the input in a variable

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

The perform method runs successfully with the help of the ``Reward::Heirachy`` class.

- The ``Reward::Heirachy`` class arranges the customers in a straight line tree with each invitee directly below their recommenders and rewards each customer's parent from the root customers(the first customer on the list of customers who accepted no contract or has any recommendation time) to the latest customer

## Testing

To test this application, navigate to the root directory and run this command in your shell/terminal

```shell
rspec
```

&nbsp;

Thank ​You​!

Mba Uchenna
