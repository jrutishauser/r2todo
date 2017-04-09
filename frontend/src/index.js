import React from 'react';
import ReactDOM from 'react-dom';
import { Router, Route, hashHistory } from 'react-router';
import 'bootstrap/dist/css/bootstrap.css';
import 'font-awesome/css/font-awesome.css';
import './index.scss';

import { Provider } from "react-redux";

import store from './store';

//import [Domain] from './Domain/[main.js]';
import MyTodos from './MyTodos/MyTodos';

ReactDOM.render((
    <Provider store={store}>
        <Router history={hashHistory}>
            <Route path="/" component={MyTodos}/>
        </Router>
    </Provider>
), document.getElementById('root'));
