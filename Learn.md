# Function Modifier

Modifiers are code that can be run before and / or after a function call.  
They are used to modify the behaviour of a function.

Modifiers can be used to:

- Restrict access
- Validate inputs
- Guard against reentrancy hack

The function body is inserted where the special symbol `_;` appears in the modifier definition.  
So if the condition of modifier is satisfied while calling this function, the function is executed and otherwise, an exception is thrown.

## onlyOwner modifier

Let's write a modifier that restricts access to the function to the owner of the contract.

- `_` Underscore is a special character only used inside a function modifier and it tells Solidity to execute the rest of the code.

First, we will create the modifier:

```
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
```

Now let's write a function that uses this modifier:

```
    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }
```

Hit `Run` to test if the modifier works or not. It should throw "Not owner" error when you try to call the function without being the owner.
You should see output in 2nd test output.

## validAddress modifier

We can even pass an input to the modifier.

This modifier checks if the address is a valid address and not a zero address.

```
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }
```

Add this modifier to the `changeOwner` function to check if `_newOwner` is a valid address:

```
    function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner) {
        owner = _newOwner;
    }
```

Hit `Run` to test if the modifier works or not. It should throw "Not valid address" error when you try to call the function with a zero address.
You should see the error in 3rd test output.

## noReentrancy modifier

Modifiers can be called before and / or after a function.

Let's write a modifier that prevents a function from being called while it is still executing.

```
    bool public locked;
    modifier noReentrancy() {
        require(!locked, "No reentrancy");

        locked = true;
        _;
        locked = false;
    }
```

Let's write a test function that uses this modifier:

```
    uint public x = 10;
    function decrement(uint i) public noReentrancy {
        x -= i;

        if (i > 1) {
            decrement(i - 1);
        }
    }
```

This function tries to call the itself recursively is `i` > 1 but our modifier prevents it.
Modifier locks the function while it is executing and unlocks it when it finishes.

Hit `Run` to test if the modifier works or not. It should throw "No reentrancy" error when you try to call the function while it is still executing.
You should see the error in 4th test output.
