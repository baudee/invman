# Investments Management App
Mobile application using Flutter and Serverpod to manage his investments.

## Class diagram
```mermaid
classDiagram
%% Relationships
User "1" *-- "1" Userinfo
User "n" o-- "1" WithdrawalRule
WithdrawalRule "1" *-- "n" Subtraction
User "1" *-- "n" Investment
Investment "n" o-- "1" Action


%% Classes
class Userinfo {
    int id
    String mail
}

class User {
    int id
    String currency
}

class Investment {
    int id
    double quantity
    double amount
}

class Action {
    int id
    double value
    String currency
}

class WithdrawalRule {
    int id
}

class Subtraction {
    int id
    double fixed
    double percent
    double minimum
}
```