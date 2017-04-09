import {combineReducers} from "redux";
import TodosReducers from './MyTodos/reducers/';
// Example
// import [domain]Reducers from './[Domain]/reducers/';

export default combineReducers({
    Todos: TodosReducers
});
