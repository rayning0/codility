// https://code.tutsplus.com/articles/data-structures-with-javascript-singly-linked-list-and-doubly-linked-list--cms-23392
// http://blog.benoitvallon.com/data-structures-in-javascript/the-singly-linked-list-data-structure/

node = {
  value: 5,
  next: null
}

function List(){
  this.head = null;
}

List.prototype.push = function(val) {
  var node = {
    value: val,
    next: null
  }

  if (!this.head) {
    this.head = node;
  } else {
    var curr = this.head;
    while(curr.next) {
      curr = curr.next;
    }
    curr.next = node;
  }
}

List.prototype.length = function() {
  var count = 0;
  if (this.head) {
    var curr = this.head;
    while(curr) {
      curr = curr.next;
      count++;
    }
  }
  return count;
}

List.prototype.insert = function(index, val) {
  var node = {
    value: val,
    next: null,
  }

  var count = 0,
      curr = this.head;
  while(count < index) {
    curr = curr.next;
    count++;
  }
  var nextNode = curr.next;
  curr.next = node;
  node.next = nextNode;
}

List.prototype.delete = function(index) {
  var count = 0,
      curr = this.head,
      message = {failure: 'Failure: non-existent node in this list.'},
      nodeBefore = null;

  if (index < 0 || index >= this.length()) {
    throw new Error(message.failure);
  }

  if (index === 0) {
    this.head = curr.next;
  } else {
    while(count < index) {
      nodeBefore = curr;
      curr = curr.next;
      count++;
    }
    nodeBefore.next = curr.next;
    curr = null;
  }
}

List.prototype.print = function() {
  var curr = this.head,
      array = [];
  while(curr) {
    array.push(curr.value);
    curr = curr.next;
  }
  console.log(array);
}

List.prototype.find = function(index) {
  var count = 0,
      curr = this.head;
  while(count < index) {
    curr = curr.next;
    count++;
  }
  return curr;
}

// OUTPUT:

// > a = new List();
// List { head: null }
// > a.push(5)
// > a.push(10)
// > a.push(15)
// > a
// List { head: { value: 5, next: { value: 10, next: [Object] } } }
// > a.push(20)
// > a.length()
// 4
// > a.print()
// [ 5, 10, 15, 20 ]
// > a.find(2)
// { value: 15, next: { value: 20, next: null } }
// > a.delete(2)
// > a.print()
// [ 5, 10, 20 ]
// > a
// List { head: { value: 5, next: { value: 10, next: [Object] } } }
// > a.delete(1)
// > a
// List { head: { value: 5, next: { value: 20, next: null } } }
// > a.print()
// [ 5, 20 ]
// > a.insert(1, 8)
// > a
// List { head: { value: 5, next: { value: 20, next: [Object] } } }
// > a.print()
// [ 5, 20, 8 ]
// > a.insert(0, 10)
// > a
// List { head: { value: 5, next: { value: 10, next: [Object] } } }
// > a.print()
// [ 5, 10, 20, 8 ]
// > a.delete(0)
// > a
// List { head: { value: 10, next: { value: 20, next: [Object] } } }
