import React, { Component } from 'react';

export class TodoItem extends Component {

  render() {
    const { todo, handleClick } = this.props;
    const isCompleted = todo.is_completed ? <p>complete</p> : <p>incomplete</p>;
    return (
      <div>
        <span><strong>{todo.id}</strong></span>
        <span>{todo.task}</span>
        <span>{isCompleted}</span>
        <button onClick={handleClick}>Done</button>
      </div>
    );
  }
}

export default TodoItem;
