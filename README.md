# README

## Assumptions

**Environment**
* Has postgres installed
* Ruby version 2.6.3

**Instructions**
* Accounts will have enough money for transfer ammount.
* Assignment said _"Every Branch Account may make transfers as long as the account to be transferred is under the same tree and is not a Parent Account."_, so made assumption that only Branch Accounts may make transfers and not Parent Accounts.
* Balance from Contributions and Deposits come from an infinite source of money. Balance from transfers comes from valid Branch Account.
* Reversing a `TransactionHistory` doesn't create a new `TransactionHistory` record. 


## Installation

**Initialization**
* run `bundle install` then `rails db:create` in root folder.

**Running Tests**
* run `rspec` in root folder.

## Testing

- If you want to create accounts, make sure you create a Person or Legal Person first.
 
- If you want to create an account tree, make sure you pass in an existing `account_id` for a `parent_id`.


**Account**

* create

  `POST /accounts`
  
  - Required Parameters
  
  ```
  string account_owner_type Person/LegalPerson
  int account_owner_id
  string name
  ```
  
  - Optional Parameters

  ```
  int status {0: active, 1: locked, 2: canceled }
  int balance
  int parent_id
  ```

* update

  `PATCH /accounts/:id`

* destroy

  `DELETE /accounts/:id`

* contribute

  `POST /accounts/:account_id/contribute`
  
  - Required Parameters
  
  ```
  int amount
  string code
  ```

* deposit

  `POST /accounts/:account_id/deposit`
  
  - Required Parameters
  
  ```
  int amount
  ```
  
* transfer

  `POST /accounts/:account_id/transfer`
  
  - Required Parameters
  
  ```
  int amount
  int source_account_id
  ```

**Person**

* create

  `POST /people/create`
  - Required Parameters
  
  ```
  int social_insurance_number
  string full_name
  datetime birth_date
  ```

* update

  `PATCH /people/:id`

* destroy

  `DELETE /people/:id`

**Legal Person**

* create

  `POST /legal_people/create`
  - Required Parameters
  
  ```
  int federal_business_number
  string company_name
  string fantasy_name
  ```
  
* update

  `PATCH /legal_people/:id`

* destroy
  
  `DELETE /legal_people/:id`
