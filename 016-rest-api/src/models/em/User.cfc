component restpath="/user"  rest="true" {

  remote struct function sayHay() httpmethod="GET" restpath="say" {
    return { message="Hello World" };
  }
  
}