import React, { Component } from 'react';
import { connect } from 'react-redux';
import { getTodos, toggleTodoFunc } from './actions/TodoActions';
import { TodoItem } from './components/';

class MyTodos extends Component {
  componentWillMount(){
    this.props.dispatch(getTodos());
  }
    render() {
      const { todos=[], dispatch } = this.props;

      const todoItems = todos.map( (todo) => {
        return <TodoItem key={todo.id} todo={todo} handleClick={toggleTodoFunc.bind(this, todo)}/>
      });
      return (
        <div>
        Some Items
        {todoItems}
        </div>
      );
    }
}
// state is following my reducers
const mapStateToProps = (state) => {
  return {
    todos: state.Todos.todoView.data.todos
  }
}
export default connect(mapStateToProps)(MyTodos);
// this is combining my component my state and (class)
